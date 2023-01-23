import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/data/datasources/storage_service.dart';
import 'package:imdb/data/models/movie_detail_response.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings'),),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _apiKeyController,
                  decoration: const InputDecoration(
                    labelText: 'API Key',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.watch(storageServiceProvider).setApiKey(_apiKeyController.text)
                      .catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error saving settings')));
                      })
                      .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved')));
                      });
                    },
                    child: const Text('Save')),
              ],
            ),
          ),
        )
    );
  }

  void _loadSettings() async {
    ref.watch(storageServiceProvider).getApiKey()
    .then((value) {
      setState(() {
        _apiKeyController.text = value ?? '';
      });
    });
  }
}
