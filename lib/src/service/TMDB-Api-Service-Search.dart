import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tfgapp/src/models/error.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/people.dart';
import 'package:tfgapp/src/models/tv.dart';

class TMDBApiServiceSearchResults {
  final Dio _dio = Dio();

  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = 'api_key=4da6190ae8146416740424c70e3a2b85';

  Future<List<dynamic>> getmovies(String query, int page) async {
    try {
      final url =
          '$baseUrl/search/movie?$apiKey&language=es-ES&query=$query&page=${page.toString()}';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return [movieList, response.data['total_pages']];
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> gettvShows(String query, int page) async {
    var res = await http.get(Uri.parse(baseUrl +
        '/search/tv?$apiKey&language=es-ES&query=$query&page=${page.toString()}'));

    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['data'] as List)
            .map((list) => TV.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw Exception('Excepció ocurrida');
    }
  }

  Future<List<dynamic>> getPersons(String query, int page) async {
    var res = await http.get(Uri.parse(
        baseUrl + '/search/person?text=$query&page=${page.toString()}'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['data'] as List)
            .map((list) => People.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw Exception('Excepció ocurrida');
    }
  }
}
