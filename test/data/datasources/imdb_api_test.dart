import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/application/exceptions.dart';
import 'package:imdb/data/datasources/imdb_api.dart';
import 'package:imdb/data/models/movie_detail_response.dart';
import 'package:imdb/data/models/movie_search_response.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'imdb_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getMoviesByTitle test', () {
    test('happy path', () async {
      final mockClient = MockClient();
      final container = ProviderContainer(overrides: [
        imdbApiClientProvider.overrideWithValue(mockClient),
      ]);
      const String url =
          'https://imdb-api.com/en/API/SearchMovie/aaa111/star wars';

      when(mockClient.get(Uri.tryParse(url)))
          .thenAnswer((realInvocation) async {
        return http.Response(titleSearchResponse, 200);
      });

      MovieSearchResponse response = await container
          .read(imdbApiProvider)
          .getMoviesByTitle('star wars', 'aaa111');
      expect(response.results.length, 3);
    });

    test('error returned', () async {
      final mockClient = MockClient();
      final container = ProviderContainer(overrides: [
        imdbApiClientProvider.overrideWithValue(mockClient),
      ]);
      const String url =
          'https://imdb-api.com/en/API/SearchMovie/aaa111/exception';

      when(mockClient.get(Uri.tryParse(url)))
          .thenAnswer((realInvocation) async {
        return http.Response(errorSearchResponse, 200);
      });

      expect(() async {
        await container
            .read(imdbApiProvider)
            .getMoviesByTitle('exception', 'aaa111');
      }, throwsA(isA<ImdbApiException>()));
    });
  });

  group('getMovieDetail test', () {
    test('happy path', () async {
      final mockClient = MockClient();
      final container = ProviderContainer(overrides: [
        imdbApiClientProvider.overrideWithValue(mockClient),
      ]);
      const String url =
          'https://imdb-api.com/en/API/Title/aaa111/t123456/';

      when(mockClient.get(Uri.tryParse(url)))
          .thenAnswer((realInvocation) async {
        return http.Response(movieDetailResponse, 200);
      });

      MovieDetailResponse response = await container
          .read(imdbApiProvider)
          .getMovieDetail('t123456', 'aaa111');
      expect(response.title, 'Star Wars: Episode IV - A New Hope');
    });

    test('error returned', () async {
      final mockClient = MockClient();
      final container = ProviderContainer(overrides: [
        imdbApiClientProvider.overrideWithValue(mockClient),
      ]);
      const String url =
          'https://imdb-api.com/en/API/Title/aaa111/exception/';

      when(mockClient.get(Uri.tryParse(url)))
          .thenAnswer((realInvocation) async {
        return http.Response(errorSearchResponse, 200);
      });

      expect(() async {
        await container
            .read(imdbApiProvider)
            .getMovieDetail('exception', 'aaa111');
      }, throwsA(isA<ImdbApiException>()));
    });
  });
}

String titleSearchResponse = '''
{
"searchType": "Movie",
"expression": "star wars",
"results": [
  {
    "id": "tt0076759",
    "resultType": "Movie",
    "image": "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_Ratio0.6757_AL_.jpg",
    "title": "Star Wars: Episode IV - A New Hope",
    "description": "1977 Mark Hamill, Harrison Ford"
  },
  {
    "id": "tt3748528",
    "resultType": "Movie",
    "image": "https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_Ratio0.6757_AL_.jpg",
    "title": "Rogue One: A Star Wars Story",
    "description": "2016 Felicity Jones, Diego Luna"
  },
  {
    "id": "tt2527338",
    "resultType": "Movie",
    "image": "https://m.media-amazon.com/images/M/MV5BMDljNTQ5ODItZmQwMy00M2ExLTljOTQtZTVjNGE2NTg0NGIxXkEyXkFqcGdeQXVyODkzNTgxMDg@._V1_Ratio0.6757_AL_.jpg",
    "title": "Star Wars: Episode IX - The Rise of Skywalker",
    "description": "2019 Daisy Ridley, John Boyega"
  }
],
"errorMessage": ""
}
''';
String errorSearchResponse = '''
{
"searchType": "Movie",
"expression": "star wars",
"results": [],
"errorMessage": "There was an error"
}
''';

String movieDetailResponse = r'''
{
    "id": "tt0076759",
    "title": "Star Wars: Episode IV - A New Hope",
    "originalTitle": "Star Wars",
    "fullTitle": "Star Wars: Episode IV - A New Hope (1977)",
    "type": "Movie",
    "year": "1977",
    "image": "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_Ratio0.6762_AL_.jpg",
    "releaseDate": "1977-05-25",
    "runtimeMins": "121",
    "runtimeStr": "2h 1min",
    "plot": "Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire's world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth ...",
    "plotLocal": "",
    "plotLocalIsRtl": false,
    "awards": "Top rated movie #28 | Won 6 Oscars, 64 wins & 29 nominations total",
    "directors": "George Lucas",
    "directorList": [
        {
            "id": "nm0000184",
            "name": "George Lucas"
        }
    ],
    "writers": "George Lucas",
    "writerList": [
        {
            "id": "nm0000184",
            "name": "George Lucas"
        }
    ],
    "stars": "Mark Hamill, Harrison Ford, Carrie Fisher",
    "starList": [
        {
            "id": "nm0000434",
            "name": "Mark Hamill"
        },
        {
            "id": "nm0000148",
            "name": "Harrison Ford"
        },
        {
            "id": "nm0000402",
            "name": "Carrie Fisher"
        }
    ],
    "actorList": [
        {
            "id": "nm0000434",
            "image": "https://m.media-amazon.com/images/M/MV5BOGY2MjI5MDQtOThmMC00ZGIwLWFmYjgtYWU4MzcxOGEwMGVkXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_Ratio1.7857_AL_.jpg",
            "name": "Mark Hamill",
            "asCharacter": "Luke Skywalker"
        },
        {
            "id": "nm0000148",
            "image": "https://m.media-amazon.com/images/M/MV5BMTY4Mjg0NjIxOV5BMl5BanBnXkFtZTcwMTM2NTI3MQ@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Harrison Ford",
            "asCharacter": "Han Solo"
        },
        {
            "id": "nm0000402",
            "image": "https://m.media-amazon.com/images/M/MV5BMjM4ODU5MDY4MV5BMl5BanBnXkFtZTgwODY1MjQ5MDI@._V1_Ratio1.0000_AL_.jpg",
            "name": "Carrie Fisher",
            "asCharacter": "Princess Leia Organa"
        },
        {
            "id": "nm0000027",
            "image": "https://m.media-amazon.com/images/M/MV5BMTUyMjgzMjczOF5BMl5BanBnXkFtZTgwNzcyMzQyNDM@._V1_Ratio1.0000_AL_.jpg",
            "name": "Alec Guinness",
            "asCharacter": "Ben Obi-Wan Kenobi"
        },
        {
            "id": "nm0001088",
            "image": "https://m.media-amazon.com/images/M/MV5BNTM4NzE4NTIwNl5BMl5BanBnXkFtZTYwMTYxNzM2._V1_Ratio1.0000_AL_.jpg",
            "name": "Peter Cushing",
            "asCharacter": "Grand Moff Tarkin"
        },
        {
            "id": "nm0000355",
            "image": "https://m.media-amazon.com/images/M/MV5BMzg3MzU2NTUxMF5BMl5BanBnXkFtZTcwMTE1NjI4NA@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Anthony Daniels",
            "asCharacter": "C-3PO"
        },
        {
            "id": "nm0048652",
            "image": "https://m.media-amazon.com/images/M/MV5BMTg1OTA3MzU0NV5BMl5BanBnXkFtZTcwNjY2Njk4Nw@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Kenny Baker",
            "asCharacter": "R2-D2"
        },
        {
            "id": "nm0562679",
            "image": "https://m.media-amazon.com/images/M/MV5BNjg1NDUzMzM3NF5BMl5BanBnXkFtZTcwMDg4NTczMQ@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Peter Mayhew",
            "asCharacter": "Chewbacca"
        },
        {
            "id": "nm0001190",
            "image": "https://m.media-amazon.com/images/M/MV5BMTEyODc0MTUzODBeQTJeQWpwZ15BbWU4MDUyMjc3OTAx._V1_Ratio1.0000_AL_.jpg",
            "name": "David Prowse",
            "asCharacter": "Darth Vader"
        },
        {
            "id": "nm0114436",
            "image": "https://m.media-amazon.com/images/M/MV5BMDkxYTdkZjUtNDM4ZS00YTM3LWI2MzktODM1MTlhYjJkZjI5XkEyXkFqcGdeQXVyMjk3NTUyOTc@._V1_Ratio1.7857_AL_.jpg",
            "name": "Phil Brown",
            "asCharacter": "Uncle Owen"
        },
        {
            "id": "nm0292235",
            "image": "https://m.media-amazon.com/images/M/MV5BNjVjMTVkZWItZDIyMy00ZDM4LTlhMWQtNWM4NTg4MDY3MjBmXkEyXkFqcGdeQXVyMjk3NTUyOTc@._V1_Ratio1.7857_AL_.jpg",
            "name": "Shelagh Fraser",
            "asCharacter": "Aunt Beru"
        },
        {
            "id": "nm0701023",
            "image": "https://m.media-amazon.com/images/M/MV5BMTM3OTkwNjk0NF5BMl5BanBnXkFtZTcwNjQzNTk0OA@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Jack Purvis",
            "asCharacter": "Chief Jawa"
        },
        {
            "id": "nm0567018",
            "image": "https://m.media-amazon.com/images/M/MV5BMTVlNWNhZjEtOTA4Ny00MjZjLWFhNjUtZDQxNDY5ZDU2ODFjL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMjk3NTUyOTc@._V1_Ratio1.0000_AL_.jpg",
            "name": "Alex McCrindle",
            "asCharacter": "General Dodonna"
        },
        {
            "id": "nm0125952",
            "image": "https://m.media-amazon.com/images/M/MV5BMGIyZjcxMDUtMjdhNy00NTkxLWE2OTEtMDZmNjAwZjZjNjYzXkEyXkFqcGdeQXVyNTEzNDY5MjM@._V1_Ratio1.0000_AL_.jpg",
            "name": "Eddie Byrne",
            "asCharacter": "General Willard"
        },
        {
            "id": "nm0377120",
            "image": "https://m.media-amazon.com/images/M/MV5BNjA1OTMxNDg5N15BMl5BanBnXkFtZTgwMzUwMzg4MDI@._V1_Ratio2.3571_AL_.jpg",
            "name": "Drewe Henley",
            "asCharacter": "Red Leader"
        },
        {
            "id": "nm0493200",
            "image": "https://m.media-amazon.com/images/M/MV5BMTQyMDE3NjA0OF5BMl5BanBnXkFtZTcwNDY0MTUwOA@@._V1_Ratio1.0000_AL_.jpg",
            "name": "Denis Lawson",
            "asCharacter": "Red Two (Wedge)"
        },
        {
            "id": "nm0353796",
            "image": "https://m.media-amazon.com/images/M/MV5BMjA4Njk1ODY5OF5BMl5BanBnXkFtZTgwODcxNzAzMTE@._V1_Ratio1.0000_AL_.jpg",
            "name": "Garrick Hagon",
            "asCharacter": "Red Three (Biggs)"
        },
        {
            "id": "nm0458161",
            "image": "https://m.media-amazon.com/images/M/MV5BYmU1YzdjMTUtZjQ4My00Yjc5LTk1ZjgtMzUxNjIwZmY4ZTg5XkEyXkFqcGdeQXVyNjUxMjc1OTM@._V1_Ratio2.3571_AL_.jpg",
            "name": "Jack Klaff",
            "asCharacter": "Red Four (John D.)"
        }
    ],
    "fullCast": null,
    "genres": "Action, Adventure, Fantasy",
    "genreList": [
        {
            "key": "Action",
            "value": "Action"
        },
        {
            "key": "Adventure",
            "value": "Adventure"
        },
        {
            "key": "Fantasy",
            "value": "Fantasy"
        }
    ],
    "companies": "Lucasfilm, Twentieth Century Fox",
    "companyList": [
        {
            "id": "co0071326",
            "name": "Lucasfilm"
        },
        {
            "id": "co0000756",
            "name": "Twentieth Century Fox"
        }
    ],
    "countries": "USA",
    "countryList": [
        {
            "key": "USA",
            "value": "USA"
        }
    ],
    "languages": "English",
    "languageList": [
        {
            "key": "English",
            "value": "English"
        }
    ],
    "contentRating": "PG",
    "imDbRating": "8.6",
    "imDbRatingVotes": "1365037",
    "metacriticRating": "90",
    "ratings": null,
    "wikipedia": null,
    "posters": null,
    "images": null,
    "trailer": null,
    "boxOffice": {
        "budget": "$11,000,000 (estimated)",
        "openingWeekendUSA": "$1,554,475",
        "grossUSA": "$460,998,507",
        "cumulativeWorldwideGross": "$775,398,007"
    },
    "tagline": null,
    "keywords": "rebellion,galactic war,princess,lightsaber,space opera",
    "keywordList": [
        "rebellion",
        "galactic war",
        "princess",
        "lightsaber",
        "space opera"
    ],
    "similars": [
        {
            "id": "tt0080684",
            "title": "Star Wars: Episode V - The Empire Strikes Back",
            "image": "https://m.media-amazon.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "8.7"
        },
        {
            "id": "tt0086190",
            "title": "Star Wars: Episode VI - Return of the Jedi",
            "image": "https://m.media-amazon.com/images/M/MV5BOWZlMjFiYzgtMTUzNC00Y2IzLTk1NTMtZmNhMTczNTk0ODk1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "8.3"
        },
        {
            "id": "tt0121766",
            "title": "Star Wars: Episode III - Revenge of the Sith",
            "image": "https://m.media-amazon.com/images/M/MV5BNTc4MTc3NTQ5OF5BMl5BanBnXkFtZTcwOTg0NjI4NA@@._V1_Ratio0.7536_AL_.jpg",
            "imDbRating": "7.6"
        },
        {
            "id": "tt0121765",
            "title": "Star Wars: Episode II - Attack of the Clones",
            "image": "https://m.media-amazon.com/images/M/MV5BMDAzM2M0Y2UtZjRmZi00MzVlLTg4MjEtOTE3NzU5ZDVlMTU5XkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "6.6"
        },
        {
            "id": "tt0120915",
            "title": "Star Wars: Episode I - The Phantom Menace",
            "image": "https://m.media-amazon.com/images/M/MV5BYTRhNjcwNWQtMGJmMi00NmQyLWE2YzItODVmMTdjNWI0ZDA2XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "6.5"
        },
        {
            "id": "tt2488496",
            "title": "Star Wars: Episode VII - The Force Awakens",
            "image": "https://m.media-amazon.com/images/M/MV5BOTAzODEzNDAzMl5BMl5BanBnXkFtZTgwMDU1MTgzNzE@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "7.8"
        },
        {
            "id": "tt3748528",
            "title": "Rogue One: A Star Wars Story",
            "image": "https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "7.8"
        },
        {
            "id": "tt2527338",
            "title": "Star Wars: Episode IX - The Rise of Skywalker",
            "image": "https://m.media-amazon.com/images/M/MV5BMDljNTQ5ODItZmQwMy00M2ExLTljOTQtZTVjNGE2NTg0NGIxXkEyXkFqcGdeQXVyODkzNTgxMDg@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "6.5"
        },
        {
            "id": "tt2527336",
            "title": "Star Wars: Episode VIII - The Last Jedi",
            "image": "https://m.media-amazon.com/images/M/MV5BMjQ1MzcxNjg4N15BMl5BanBnXkFtZTgwNzgwMjY4MzI@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "6.9"
        },
        {
            "id": "tt0088763",
            "title": "Back to the Future",
            "image": "https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "8.5"
        },
        {
            "id": "tt0167261",
            "title": "The Lord of the Rings: The Two Towers",
            "image": "https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "8.8"
        },
        {
            "id": "tt0133093",
            "title": "The Matrix",
            "image": "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_Ratio0.6763_AL_.jpg",
            "imDbRating": "8.7"
        }
    ],
    "tvSeriesInfo": null,
    "tvEpisodeInfo": null,
    "errorMessage": ""
}
''';


String errorDetailResponse = '''
{
"errorMessage": "There was an error"
}
''';
