import 'package:dio/dio.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/people.dart';
import 'package:tfgapp/src/models/tv.dart';

class TMDBApiServiceSearchResults {
  final Dio _dio = Dio();
  final String myUrl = "https://api-danielrodriguez.herokuapp.com";

  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = 'api_key=4da6190ae8146416740424c70e3a2b85';

  Future<List<dynamic>> getmovies(String query, int page) async {
    try {
      final url = '$myUrl/getMovies/:$query/:${page.toString()}';
      //final url = '$baseUrl/search/movie?$apiKey&language=es-ES&query=$query&page=${page.toString()}';
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

  Future<List<dynamic>> getmovies1(String query, int page) async {
    try {
      final url =
          '$baseUrl/discover/movie?$apiKey&language=es-ES&sort_by=vote_average.desc&include_adult=false&include_video=false&page=${page.toString()}&$query';
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
    try {
      final url = '$myUrl/getTVShows/:$query/:${page.toString()}';
      //final url = '$baseUrl/search/tv?$apiKey&language=es-ES&query=$query&page=${page.toString()}';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var tv = response.data['results'] as List;
      List<TV> tvList = tv.map((m) => TV.fromJson(m)).toList();
      return [tvList, response.data['total_pages']];
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> getPersons(String query, int page) async {
    try {
      final url = '$myUrl/getPersons/:$query/:${page.toString()}';
      //final url = '$baseUrl/search/person?$apiKey&language=es-ES&query=$query&page=${page.toString()}';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var people = response.data['results'] as List;
      List<People> peopleList = people.map((m) => People.fromJson(m)).toList();
      return [peopleList, response.data['total_pages']];
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }
}
