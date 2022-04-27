import 'package:dio/dio.dart';

class IMDBApiService {
  final Dio _dio = Dio();
  final String myUrl = "https://api-danielrodriguez.herokuapp.com";

  final String baseUrl = "https://imdb-api.com/es/API";
  final String apiKey = 'k_yp2sap51';

  Future<String> voteIMDB(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['imDb'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteFilmAffinity(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['filmAffinity'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteMetacritic(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['metacritic'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteRottenTomatoes(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['rottenTomatoes'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVIMDB(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['imDb'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVFilmAffinity(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['filmAffinity'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVMetacritic(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['metacritic'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVRottenTomatoes(String id) async {
    try {
      final url = '$myUrl/getRatings/$id';
      //final url = '$baseUrl/Ratings/$apiKey/$id';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String vote = response.data['rottenTomatoes'];
      print('ES ESTO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }
}
