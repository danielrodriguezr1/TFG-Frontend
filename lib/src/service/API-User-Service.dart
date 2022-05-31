import 'dart:io';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/storage/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class APIUserService {
  final Dio _dio = Dio();
  final String myUrl = "https://api-danielrodriguez.herokuapp.com";

  Future<List<Movie>> getRecommendations() async {
    try {
      List<Movie> movieList;
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/getRecommendations/$id/0';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var movies = response.data as List;
        movieList = movies.map((m) => Movie.fromJson(m)).toList();
      });
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<TV>> getRecommendationsTV() async {
    try {
      List<TV> tvList;
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/getRecommendations/$id/1';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var tv = response.data as List;
        tvList = tv.map((m) => TV.fromJson(m)).toList();
      });
      return tvList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> updateUser(String name, String lastname, String nickname,
      String email, String about, File profileImage) async {
    String userId = await SecureStorage.readSecureStorage('App_UserID');

    var uri = Uri.parse("$myUrl/users/$userId");

    var request = http.MultipartRequest('PATCH', uri)
      ..fields['new_name'] = name
      ..fields['new_lastname'] = lastname
      ..fields['new_nickname'] = nickname
      ..fields['new_email'] = email
      ..fields['new_about'] = about;

    if (profileImage != null) {
      // ignore: await_only_futures
      request.files.add(await http.MultipartFile('profileImage',
          profileImage.readAsBytes().asStream(), profileImage.lengthSync(),
          filename: "profileImage"));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {}
    return response.statusCode.toString();
  }

  Future<void> deleteUser() async {
    SecureStorage.readSecureStorage('App_UserID').then((id) {
      var url =
          Uri.parse("https://api-danielrodriguez.herokuapp.com/users/$id");
      http.delete(url).then((res) {
        print(res.statusCode);
        print(url.toString());

        if (res.statusCode != 400 && res.statusCode != 404) {
          print("delete");
        } else {
          print("MAAAL${res.statusCode}");
        }
      });
    });
  }

  Future<double> getRatingByUser(int movieId) async {
    try {
      double rating = 0;
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/getRatingByUser/$id/$movieId';
        print('Api Call: $url');
        final response = await _dio.get(url);
        if (response.data.toString() == "[]") {
          rating = 0;
        } else
          rating = response.data[0]["rating"].toDouble();
        print(rating);
      });
      return rating;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<void> addRating(int movieId, double rating, int type) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/addRating/$id';
        print('Api Call: $url');

        final response = await _dio.post(url,
            data: {'rating': rating, 'idFilmOrShow': movieId, 'type': type});
        return response;
      });
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> existsInWatchlist(int idFilmOrShow) async {
    try {
      String code;
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = Uri.parse('$myUrl/existsInWatchlist/$id/$idFilmOrShow');
        print('Api Call: $url');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          code = "200";
        } else {
          code = "404";
        }
      });
      return code;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<void> addToWatchlist(int idMovie) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/addFilmToWatchlist/$id';
        print('Api Call: $url');

        final response = await _dio.post(url, data: {'idFilm': idMovie});
        return response;
      });
    } catch (e) {}
  }

  Future<void> deleteFromWatchlist(int idMovie) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/deleteFilmWatchlist/$id/$idMovie';
        print('Api Call: $url');

        final response = await _dio.patch(url);
        return response;
      });
    } catch (e) {}
  }

  Future<List<Movie>> getWatchlistMovie() async {
    try {
      List<Movie> movieList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/getWatchlistFilm/$id/';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var movies = response.data["watchListFilm"] as List;
        for (var i = 0; i < movies.length; ++i) {
          var movie = (movies[i]["idFilm"]);
          try {
            final url = '$myUrl/getMovie/$movie';
            print('Api Call: $url');
            final response = await _dio.get(url);
            //print(movie1["overview"]);
            Movie movie1 = Movie.fromJson(response.data);

            movieList.add(movie1);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      print(movieList);
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<void> addToWatchlistTV(int idShow) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/addShowToWatchlist/$id';
        print('Api Call: $url');

        final response = await _dio.post(url, data: {'idShow': idShow});
        return response;
      });
    } catch (e) {}
  }

  Future<void> deleteFromWatchlistTV(int idShow) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/deleteShowWatchlist/$id/$idShow';
        print('Api Call: $url');

        final response = await _dio.patch(url);
        return response;
      });
    } catch (e) {}
  }

  Future<List<TV>> getWatchlistTV() async {
    try {
      List<TV> tvList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/getWatchlistShow/$id/';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var shows = response.data["watchListShow"] as List;
        for (var i = 0; i < shows.length; ++i) {
          var tv = (shows[i]["idShow"]);
          try {
            final url = '$myUrl/getTV/$tv';
            print('Api Call: $url');
            final response = await _dio.get(url);

            TV tv1 = TV.fromJson(response.data);

            tvList.add(tv1);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      print(tvList);
      return tvList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<Map<String, dynamic>> getUserByNickname(String nickname) async {
    try {
      final url = '$myUrl/userByNickname/$nickname/';
      print('Api Call: $url');
      final response = await _dio.get(url);
      Map<String, dynamic> user = response.data as Map<String, dynamic>;
      //print(user);
      //print(user["user"]["email"]);
      return user;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<Map<String, dynamic>> getUserByID(String id) async {
    try {
      final url = '$myUrl/users/$id/';
      print('Api Call: $url');
      final response = await _dio.get(url);
      Map<String, dynamic> user = response.data as Map<String, dynamic>;
      //print(user);
      //print(user["user"]["email"]);
      return user;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<void> followUser(String id1) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/$id1/follow';
        print('Api Call: $url');
        final response = await _dio.put(url, data: {"userId": id});
        print(response.data);
      });
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<void> unfollowUser(String id1) async {
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/$id1/unfollow';
        print('Api Call: $url');
        final response = await _dio.put(url, data: {"userId": id});
        print(response.data);
      });
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> checkIfFollow(String id1) async {
    try {
      String code;
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/checkIfFollow/$id1/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        //print(response.data);
        code = response.statusCode.toString();
      });
      return code;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> getMutuals() async {
    List<dynamic> mutuals = [];

    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/mutuallyFollows/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        mutuals = response.data["mutuallyFollows"] as List;
        print(mutuals);
      });
      print(mutuals);
      return mutuals;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> getMutualsNickname() async {
    List<dynamic> mutuals = [];
    try {
      List mutualsList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/mutuallyFollows/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        mutuals = response.data["mutuallyFollows"] as List;
        print("MUTUAAAAAAAAAALS $mutuals");
        for (var i = 0; i < mutuals.length; ++i) {
          var mutual = (mutuals[i]);
          print("MUTUAAAAAAAL11111 $mutual");
          try {
            final url = '$myUrl/users/$mutual';
            print('Api Call: $url');
            final response = await _dio.get(url);

            var mutualNickname = response.data["user"];
            print(mutualNickname["nickname"]);

            mutualsList.add(mutualNickname["nickname"]);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      print(mutualsList);
      return mutualsList;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<dynamic>> getMutualsImage() async {
    List<dynamic> mutuals = [];
    try {
      List mutualsList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/mutuallyFollows/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        mutuals = response.data["mutuallyFollows"] as List;
        print("MUTUAAAAAAAAAALS $mutuals");
        for (var i = 0; i < mutuals.length; ++i) {
          var mutual = (mutuals[i]);
          print("MUTUAAAAAAAL11111 $mutual");
          try {
            final url = '$myUrl/users/$mutual';
            print('Api Call: $url');
            final response = await _dio.get(url);

            var mutualNickname = response.data["user"];
            print(mutualNickname["profileImage"]);

            mutualsList.add(mutualNickname["profileImage"]);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      print(mutualsList);
      return mutualsList;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> addUserRecommendation(int idMovie, String idUser) async {
    String code;
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/movieRecommendation/$idUser';
        print('Api Call: $url');
        //final response = await _dio.get(url);
        final response =
            await _dio.put(url, data: {"userId": id, "idFilm": idMovie});
        code = response.statusCode.toString();
      });
      return code;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<String> addUserRecommendationShow(int idShow, String idUser) async {
    String code;
    try {
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/showRecommendation/$idUser';
        print('Api Call: $url');
        //final response = await _dio.get(url);
        final response =
            await _dio.put(url, data: {"userId": id, "idShow": idShow});
        code = response.statusCode.toString();
      });
      return code;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<Movie>> getRecommendationsUser() async {
    try {
      List<Movie> movieList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/users/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var movies = response.data["user"]["movieRecommendations"] as List;
        print(movies);
        for (var i = 0; i < movies.length; ++i) {
          var movie = (movies[i]);
          try {
            final url = '$myUrl/getMovie/$movie';
            print('Api Call: $url');
            final response = await _dio.get(url);

            Movie movie1 = Movie.fromJson(response.data);

            movieList.add(movie1);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
        //movieList = movies.map((m) => Movie.fromJson(m)).toList();
      });
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List<TV>> getRecommendationsUserTV() async {
    try {
      List<TV> showList = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/users/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        var shows = response.data["user"]["showRecommendations"] as List;
        print(shows);
        for (var i = 0; i < shows.length; ++i) {
          var show = (shows[i]);
          try {
            final url = '$myUrl/getTV/$show';
            print('Api Call: $url');
            final response = await _dio.get(url);

            TV tv1 = TV.fromJson(response.data);

            showList.add(tv1);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      return showList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List> getUserListRecommendations() async {
    try {
      List listUsers = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/users/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        print(response.data["user"]["movieReccomendationsUsers"]);
        var users = response.data["user"]["movieReccomendationsUsers"] as List;
        for (var i = 0; i < users.length; ++i) {
          var user = (users[i]);
          try {
            final url = '$myUrl/users/$user';
            print('Api Call: $url');
            final response = await _dio.get(url);

            var nickname = response.data["user"]["nickname"];

            listUsers.add(nickname);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      return listUsers;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }

  Future<List> getUserListRecommendationsTV() async {
    try {
      List listUsers = [];
      await SecureStorage.readSecureStorage('App_UserID').then((id) async {
        final url = '$myUrl/users/$id';
        print('Api Call: $url');
        final response = await _dio.get(url);
        print(response.data["user"]["showReccomendationsUsers"]);
        var users = response.data["user"]["showReccomendationsUsers"] as List;
        for (var i = 0; i < users.length; ++i) {
          var user = (users[i]);
          try {
            final url = '$myUrl/users/$user';
            print('Api Call: $url');
            final response = await _dio.get(url);

            var nickname = response.data["user"]["nickname"];

            listUsers.add(nickname);
          } catch (e) {
            throw Exception('Excepció ocurrida: $e ');
          }
        }
      });
      return listUsers;
    } catch (error, stacktrace) {
      throw Exception('Excepció ocurrida: $error amb trackace: $stacktrace');
    }
  }
}
