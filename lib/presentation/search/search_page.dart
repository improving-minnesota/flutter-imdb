import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/data/models/movie_search_response.dart';
import 'package:imdb/presentation/search/movie_summary_card.dart';
import 'package:imdb/presentation/search/search_page_controller.dart';
import 'package:imdb/presentation/settings/settings_page.dart';

class SearchPage extends ConsumerStatefulWidget {

  const SearchPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  String searchTitle = '';
  MovieSearchResponse? response;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingsPage())
                );
              },
              child: const Icon(
                Icons.settings,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const Key('text_field_title_search'),
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Movie Search',
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Movie title is missing';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      key: const Key('button_search'),
                      onPressed: () {
                        if (_isSearching) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSearching = true;
                            response?.results.clear();
                          });
                          searchMovieTitle();
                        }
                      },
                      child: const Text('Search')),
                )
              ],
            ),
          ),
          Expanded(
            child: _isSearching ? Center(child: CircularProgressIndicator(),) : ListView.builder(
              itemCount: response == null ? 0 : response?.results.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 100,
                  child: MovieSummaryCard(
                    id: response?.results[index].id ?? '',
                    image: response?.results[index].image ?? '',
                    title: response?.results[index].title ?? '',
                    description: response?.results[index].description ?? '',
                    resultType: response?.results[index].resultType ?? '',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void searchMovieTitle() {
    ref.watch(searchPageControllerProvider).searchMovieTitle(_searchController.text)
    .catchError((err) {
      setState(() {
        _isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error searching for movies: ${err.toString()}')));
      return Future<MovieSearchResponse>.value(MovieSearchResponse.empty());
    })
    .then((value) {
      setState(() {
        response = value;
      });
    })
    .whenComplete(() {
      setState(() {
        _isSearching = false;
      });
    });
  }
}