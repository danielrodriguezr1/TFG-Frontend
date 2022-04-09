import 'package:dio/dio.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/tv.dart';

class TMDBApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = 'api_key=4da6190ae8146416740424c70e3a2b85';

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url =
          '$baseUrl/movie/now_playing?$apiKey&language=es-ES&page=1&region=ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<Movie>> getTopRatedMovie() async {
    try {
      final url =
          '$baseUrl/discover/movie?$apiKey&language=es-ES&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1&vote_count.gte=4000&with_watch_monetization_types=flatrate';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final url =
          '$baseUrl/movie/popular?$apiKey&language=es-ES&page=1&region=ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<TV>> getPopularTV() async {
    try {
      final url = '$baseUrl/tv/popular?$apiKey&language=es-ES&page=1&region=ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var tv = response.data['results'] as List;
      List<TV> tvList = tv.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<Movie>> findByTitle(String title) async {
    try {
      final url =
          '$baseUrl/search/movie?$apiKey&language=es-ES&query=$title&page=1&include_adult=true';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var movie = response.data['results'] as List;
      List<Movie> movieList = movie.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }
}