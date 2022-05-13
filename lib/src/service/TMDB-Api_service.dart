import 'package:dio/dio.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/tv.dart';

import 'IMDB-Api-service.dart';

class TMDBApiService {
  final Dio _dio = Dio();
  final String myUrl = "https://api-danielrodriguez.herokuapp.com";

  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = 'api_key=4da6190ae8146416740424c70e3a2b85';

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url = '$myUrl/getNowPlayingMovies';
      //final url = '$myUrl/movie/now_playing?$apiKey&language=es-ES&page=1&region=ES';
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
      final url = '$myUrl/getTopRatedMovie';
      //final url = '$baseUrl/discover/movie?$apiKey&language=es-ES&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1&vote_count.gte=4000&with_watch_monetization_types=flatrate';
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
      final url = '$myUrl/getPopularMovies';
      //final url = '$baseUrl/movie/popular?$apiKey&language=es-ES&page=1&region=ES';
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
      final url = '$myUrl/getPopularTV';
      //final url = '$baseUrl/tv/popular?$apiKey&language=es-ES&page=1&region=ES';
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

  Future<TV> getTV(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      var tv = response.data['results'];
      TV tv1 = tv.map((m) => TV.fromJson(m));
      print(tv1.id);
      return tv1;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<Movie>> findByTitle(String title) async {
    try {
      final url = '$myUrl/findByTitle/$title';
      //final url = '$baseUrl/search/movie?$apiKey&language=es-ES&query=$title&page=1&include_adult=true';
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

  Future<String> overvieyTVById(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String overview = response.data['overview'];
      //print(movieRuntime);
      return overview;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> runtimeFilmById(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String movieRuntime = response.data['runtime'].toString();
      //print(movieRuntime);
      return movieRuntime;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> episodeRuntime(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String episodeRuntime = response.data['episode_run_time'][0].toString();
      //print(movieRuntime);
      return episodeRuntime;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> numberOfSeasons(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String numSeasons = response.data['number_of_seasons'].toString();
      //print(movieRuntime);
      return numSeasons;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> numberOfEpisodes(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String numEpisodes = response.data['number_of_episodes'].toString();
      //print(movieRuntime);
      return numEpisodes;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> statusTV(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String status = response.data['status'].toString();
      //print(movieRuntime);
      return status;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> posterTV(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String status = response.data['poster_path'].toString();
      //print(movieRuntime);
      return status;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> genresFilmById(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> genres = (response.data['genres'] as List)
          .map((laung) => laung['name'])
          .toList();
      //print(movieRuntime);
      return genres;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> genresTVById(String id) async {
    try {
      final url = '$myUrl/getTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> genres = (response.data['genres'] as List)
          .map((laung) => laung['name'])
          .toList();
      //print(movieRuntime);
      return genres;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> cast(String id) async {
    try {
      final url = '$myUrl/cast/$id';
      //final url = '$baseUrl/movie/$id/credits?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> cast = response.data['cast'].toList();
      //print(movieRuntime);
      return cast;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> castTV(String id) async {
    try {
      final url = '$myUrl/castTV/$id';
      //final url = '$baseUrl/tv/$id/credits?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> cast = response.data['cast'].toList();
      //print(movieRuntime);
      return cast;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> crew(String id) async {
    try {
      final url = '$myUrl/crew/$id';
      //final url = '$baseUrl/movie/$id/credits?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> crew = response.data['crew'].toList();
      //print(movieRuntime);
      return crew;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> crewTV(String id) async {
    try {
      final url = '$myUrl/crewTV/$id';
      //final url = '$baseUrl/tv/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> crew = response.data['created_by'].toList();
      return crew;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> platformBuyTV(String id) async {
    try {
      final url = '$myUrl/platformsTV/$id';
      //final url = '$baseUrl/tv/$id/watch/providers?$apiKey';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> platforms;
      if (response.data['results']['ES'] != null) {
        if (response.data['results']['ES']['buy'] != null)
          platforms = response.data['results']['ES']['buy'].toList();
      }
      //print('ES ESTO $platforms.length');
      return platforms;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> platformFlatrateTV(String id) async {
    try {
      final url = '$myUrl/platformsTV/$id';
      //final url = '$baseUrl/tv/$id/watch/providers?$apiKey';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> platforms;
      if (response.data['results']['ES'] != null) {
        if (response.data['results']['ES']['flatrate'] != null)
          platforms = response.data['results']['ES']['flatrate'].toList();
      }
      //print('ES ESTO $platforms.length');
      return platforms;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> platformBuyFilm(String id) async {
    try {
      final url = '$myUrl/platformsMovie/$id';
      //final url = '$baseUrl/movie/$id/watch/providers?$apiKey';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> platforms;
      if (response.data['results']['ES'] != null) {
        if (response.data['results']['ES']['buy'] != null)
          platforms = response.data['results']['ES']['buy'].toList();
      }
      //print('ES ESTO $platforms.length');
      return platforms;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> platformFlatrateFilm(String id) async {
    try {
      final url = '$myUrl/platformsMovie/$id';
      //final url = '$baseUrl/movie/$id/watch/providers?$apiKey';
      print('Api Call: $url');
      final response = await _dio.get(url);
      List<dynamic> platforms;
      if (response.data['results']['ES'] != null) {
        if (response.data['results']['ES']['flatrate'] != null)
          platforms = response.data['results']['ES']['flatrate'].toList();
      }
      //print('ES ESTO $platforms.length');
      return platforms;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteIMDB(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteIMDB(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteFilmAffinity(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteFilmAffinity(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteMetacritic(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteMetacritic(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteRottenTomatoes(String id) async {
    try {
      final url = '$myUrl/getMovie/$id';
      //final url = '$baseUrl/movie/$id?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteRottenTomatoes(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVIMDB(String id) async {
    try {
      final url = '$myUrl/external_idsTV/$id';
      //final url = '$baseUrl/tv/$id/external_ids?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteTVIMDB(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVFilmAffinity(String id) async {
    try {
      final url = '$myUrl/external_idsTV/$id';
      //final url = '$baseUrl/tv/$id/external_ids?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteTVFilmAffinity(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVMetacritic(String id) async {
    try {
      final url = '$myUrl/external_idsTV/$id';
      //final url = '$baseUrl/tv/$id/external_ids?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteTVMetacritic(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> voteTVRottenTomatoes(String id) async {
    try {
      final url = '$myUrl/external_idsTV/$id';
      //final url = '$baseUrl/tv/$id/external_ids?$apiKey&language=es-ES';
      print('Api Call: $url');
      final response = await _dio.get(url);
      String imdbid = response.data['imdb_id'].toString();

      final String vote = await IMDBApiService().voteTVRottenTomatoes(imdbid);
      print('ES ESTOOOO $vote');
      return vote;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }
}
