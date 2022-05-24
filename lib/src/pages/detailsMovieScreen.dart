import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';
import 'package:tfgapp/src/service/TMDB-Api_service.dart';

class DetailsMovieScreen extends StatefulWidget {
  final Movie movie;
  const DetailsMovieScreen({Key key, this.movie}) : super(key: key);

  @override
  _DetailsMovieScreenState createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //voteIMDB(movie.id.toString());

    cast(widget.movie.id.toString());
    platformBuyFilm(widget.movie.id.toString());

    return Scaffold(
        backgroundColor: Colors.black87,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height) * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}',
                        height: MediaQuery.of(context).size.height * 0.4 - 50,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                          image: AssetImage('assets/images/img_not_found.jpg'),
                        ))),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFBDBDBD).withOpacity(0.95),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 50,
                                color: Colors.black87.withOpacity(0.2))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //TMDB
                            /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset('assets/icons/tmdb.jpg',
                                        width: 50, height: 50)),
                                SizedBox(height: 5),
                                RichText(
                                    text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "${movie.voteAverage}/",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(text: "10\n"),
                                  ],
                                ))
                              ],
                            ),

                            //IMDB
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset('assets/icons/imdb.jpg',
                                        width: 50, height: 50)),
                                SizedBox(height: 5),
                                FutureBuilder(
                                    future: voteIMDB(movie.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return RichText(
                                            text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: "${snapshot.data}/",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: "10\n"),
                                          ],
                                        ));
                                      }
                                      return Container();
                                    }),
                              ],
                            ),

                            //METACRITIC
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        'assets/icons/metacritic.png',
                                        width: 50,
                                        height: 50)),
                                SizedBox(height: 5),
                                FutureBuilder(
                                    future: voteMetacritic(movie.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return RichText(
                                            text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: "${snapshot.data}/",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: "100\n"),
                                          ],
                                        ));
                                      }
                                      return Container();
                                    }),
                              ],
                            ),

                            //FILMAFFINITY
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        'assets/icons/filmaffinity.jpg',
                                        width: 50,
                                        height: 50)),
                                SizedBox(height: 5),
                                FutureBuilder(
                                    future:
                                        voteFilmAffinity(movie.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return RichText(
                                            text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: "${snapshot.data}/",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: "10\n"),
                                          ],
                                        ));
                                      }
                                      return Container();
                                    }),
                              ],
                            ),

                            //ROTTEN TOMATOES
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        'assets/icons/rottentomatoes.jpg',
                                        width: 50,
                                        height: 50)),
                                SizedBox(height: 5),
                                FutureBuilder(
                                    future:
                                        voteRottenTomatoes(movie.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return RichText(
                                            text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: "${snapshot.data}/",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(text: "100\n"),
                                          ],
                                        ));
                                      }
                                      return Container();
                                    }),
                              ],
                            )*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // TITULO y DURACION
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.movie.title,
                              style: TextStyle(
                                color: Color(0xEAFFFFFF),
                                fontSize: 24,
                              )),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              (widget.movie.releaseDate != '')
                                  ? Text(
                                      '${widget.movie.releaseDate.substring(0, 4)}',
                                      style: TextStyle(color: Colors.white54),
                                    )
                                  : Text(''),
                              SizedBox(width: 10),
                              FutureBuilder(
                                  future:
                                      runtimeById(widget.movie.id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}",
                                          style:
                                              TextStyle(color: Colors.white54));
                                    }
                                    return Container();
                                  })
                              /*Text(
                                '$runtime',
                                style: TextStyle(color: Colors.white54),
                              )*/
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(children: [
                            FutureBuilder(
                                future: getRatingByUser(widget.movie.id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return RatingBar.builder(
                                        itemSize: 27,
                                        initialRating: snapshot.data,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        unratedColor: Colors.grey,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.all(1.0),
                                        itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.yellow),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          addRating(widget.movie.id, rating);
                                        });
                                  }
                                  return Container();
                                })
                          ]),
                          SizedBox(height: 10),

                          // ignore: deprecated_member_use
                          Row(
                            children: [
                              FutureBuilder(
                                  future: existsInWatchlist(widget.movie.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data);
                                      if (snapshot.data == "404") {
                                        // ignore: deprecated_member_use
                                        return RaisedButton(
                                          onPressed: () {
                                            addToWatchlist(widget.movie.id);
                                            setState(() {});
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFF4C10F),
                                                    Color(0xFFF4C10F)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 150.0,
                                                  maxHeight: 40.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Añadir a watchlist",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        // ignore: deprecated_member_use
                                        return RaisedButton(
                                          onPressed: () {
                                            deleteFromWatchlist(
                                                widget.movie.id);
                                            setState(() {});
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF7a7a7a),
                                                    Color(0xffd6d6d6)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 150.0,
                                                  maxHeight: 40.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Eliminar de watchlist",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    return Container();
                                  })
                            ],
                          ),
                          SizedBox(height: 10),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF7a7a7a),
                                      Color(0xffd6d6d6)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 150.0, maxHeight: 40.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Recomendar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${widget.movie.poster}',
                        height: 230,
                        width: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                          image: AssetImage('assets/images/img_not_found.jpg'),
                        ))),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              ///GENEROS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 36,
                  child: FutureBuilder(
                      future: genresById(widget.movie.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<dynamic> genres = snapshot.data;
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: genres.length,
                              itemBuilder: (context, index) => Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white70),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      genres[index],
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ));
                        }
                        return Container();
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "Sinopsis",
                  style: TextStyle(
                    color: Color(0xEAFFFFFF),
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.movie.overview,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white70,
                    )),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Equipo",
                      style: TextStyle(
                        color: Color(0xEAFFFFFF),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          height: 160,
                          child: FutureBuilder(
                              future: crew(widget.movie.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<dynamic> crew = snapshot.data;
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: crew.length,
                                    itemBuilder: (context, index) =>
                                        CrewCardDirector(crew: crew[index]),
                                  );
                                }
                                return Container();
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //REPARTO
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Reparto",
                      style: TextStyle(
                        color: Color(0xEAFFFFFF),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 160,
                      child: FutureBuilder(
                          future: cast(widget.movie.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<dynamic> cast = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cast.length,
                                itemBuilder: (context, index) =>
                                    CastCard(cast: cast[index]),
                              );
                            }
                            return Container();
                          }),
                    )
                  ],
                ),
              ),

              //PLATAFORMAS
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Disponibilidad en plataformas",
                      style: TextStyle(
                        color: Color(0xEAFFFFFF),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Suscripción",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: FutureBuilder(
                          future:
                              platformFlatrateFilm(widget.movie.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              List<dynamic> platforms = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: platforms.length,
                                itemBuilder: (context, index) =>
                                    FlatratePlatform(
                                        platforms: platforms[index]),
                              );
                            }
                            return Container(
                              height: 200,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(children: [
                                Text(
                                  "Actualmente esta película no se encuentra disponible en ninguna plataforma por suscripción.",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                            );
                          }),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Comprar o alquilar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 160,
                      child: FutureBuilder(
                          future: platformBuyFilm(widget.movie.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              List<dynamic> platforms = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: platforms.length,
                                itemBuilder: (context, index) =>
                                    BuyPlatform(platforms: platforms[index]),
                              );
                            }
                            return Container(
                              height: 200,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(children: [
                                Text(
                                  "Actualmente esta película no se encuentra disponible en ninguna plataforma para comprar o alquilar.",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> addToWatchlist(int idMovie) async {
    await APIUserService().addToWatchlist(idMovie);
    print("ADDED TO WATCHLIST");
  }

  Future<void> deleteFromWatchlist(int idMovie) async {
    await APIUserService().deleteFromWatchlist(idMovie);
    print("REMOVED FROM WATCHLIST");
  }

  Future<String> existsInWatchlist(int idMovie) async {
    String code = await APIUserService().existsInWatchlist(idMovie);
    print("JEJE $code");
    return code;
  }

  Future<double> getRatingByUser(int idMovie) async {
    double rating = await APIUserService().getRatingByUser(idMovie);
    print("dfsdfsdf $rating");
    return rating;
  }

  Future<void> addRating(int idMovie, double rating) async {
    await APIUserService().addRating(idMovie, rating, 0);
    print("ADD RATING");
  }

  Future<String> runtimeById(String idMovie) async {
    String runtime =
        await TMDBApiService().runtimeFilmById(widget.movie.id.toString());
    final int hour = int.parse(runtime) ~/ 60;
    final int minutes = int.parse(runtime) % 60;
    return '${hour.toString()} h ${minutes.toString()} min';
    //return runtime;
  }

  Future<List<dynamic>> genresById(String idMovie) async {
    List<dynamic> genres =
        await TMDBApiService().genresFilmById(widget.movie.id.toString());
    return genres;
  }

  Future<List<dynamic>> cast(String idMovie) async {
    List<dynamic> cast =
        await TMDBApiService().cast(widget.movie.id.toString());
    return cast;
  }

  Future<List<dynamic>> crew(String idMovie) async {
    List<dynamic> cast =
        await TMDBApiService().crew(widget.movie.id.toString());
    cast.sort((a, b) => a["job"].compareTo(b["job"]));

    return cast;
  }

  Future<List<dynamic>> platformBuyFilm(String idMovie) async {
    List<dynamic> platforms =
        await TMDBApiService().platformBuyFilm(widget.movie.id.toString());
    return platforms;
  }

  Future<List<dynamic>> platformFlatrateFilm(String idMovie) async {
    List<dynamic> platforms =
        await TMDBApiService().platformFlatrateFilm(widget.movie.id.toString());
    return platforms;
  }

  Future<String> voteIMDB(String idMovie) async {
    String voteIMDB =
        await TMDBApiService().voteIMDB(widget.movie.id.toString());
    return voteIMDB;
  }

  Future<String> voteMetacritic(String idMovie) async {
    String voteMetacritic =
        await TMDBApiService().voteMetacritic(widget.movie.id.toString());
    return voteMetacritic;
  }

  Future<String> voteFilmAffinity(String idMovie) async {
    String voteFilmAffinity =
        await TMDBApiService().voteFilmAffinity(widget.movie.id.toString());
    return voteFilmAffinity;
  }

  Future<String> voteRottenTomatoes(String idMovie) async {
    String voteRottenTomatoes =
        await TMDBApiService().voteRottenTomatoes(widget.movie.id.toString());
    return voteRottenTomatoes;
  }
}

class CastCard extends StatelessWidget {
  final Map cast;
  const CastCard({Key key, this.cast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 80,
      child: Column(
        children: <Widget>[
          CircleAvatar(
              radius: 35,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                cast['profile_path'] != null
                    ? "https://image.tmdb.org/t/p/w500" + cast['profile_path']
                    : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
              )),
          /*ClipRRect(
            child: CachedNetworkImage(
              imageUrl: cast['profile_path'] != null
                  ? "https://image.tmdb.org/t/p/w500" + cast['profile_path']
                  : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
              height: 80,
              //width: MediaQuery.of(context).size.width,
              //fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage('assets/images/img_not_found.jpg'),
              ))),
            ),
            borderRadius: BorderRadius.circular(75),
          ),*/
          SizedBox(
            height: 10,
          ),
          Text(cast['name'],
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text(
            cast['character'] != null ? cast['character'] : '',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF9A9BB2)),
          )
        ],
      ),
    );
  }
}

class CrewCardDirector extends StatelessWidget {
  final Map crew;
  const CrewCardDirector({Key key, this.crew}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (crew['job'] == 'Director' ||
        crew['job'] == 'Screenplay' ||
        crew['job'] == 'Director of Photography' ||
        crew['job'] == 'Original Music Composer' ||
        crew['job'] == 'Novel' ||
        crew['job'] == 'Writer') {
      return Container(
        margin: EdgeInsets.only(right: 20),
        width: 80,
        child: Column(
          children: <Widget>[
            CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  crew['profile_path'] != null
                      ? "https://image.tmdb.org/t/p/w500" + crew['profile_path']
                      : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
                )),
            SizedBox(
              height: 10,
            ),
            Text(crew['name'],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(color: Colors.white70)),
            SizedBox(height: 10),
            Text(
              (crew['job'] == "Director")
                  ? "Director"
                  : (crew['job'] == "Director of Photography")
                      ? "Director de fotografía"
                      : (crew['job'] == "Novel")
                          ? "Novela"
                          : (crew['job'] == "Original Music Composer")
                              ? "Música"
                              : "Guion",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF9A9BB2)),
            )
          ],
        ),
      );
    }
    return Container();
  }
}

class BuyPlatform extends StatelessWidget {
  final Map platforms;
  const BuyPlatform({Key key, this.platforms}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (platforms != null) {
      return Container(
        margin: EdgeInsets.only(right: 20),
        width: 80,
        child: Column(
          children: <Widget>[
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  platforms['logo_path'] != null
                      ? "https://image.tmdb.org/t/p/w500" +
                          platforms['logo_path']
                      : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
                )),
            SizedBox(
              height: 10,
            ),
            Text(platforms['provider_name'],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(color: Colors.white70)),
            //SizedBox(height: 10),
          ],
        ),
      );
    }
    return Container();
  }
}

class FlatratePlatform extends StatelessWidget {
  final Map platforms;
  const FlatratePlatform({Key key, this.platforms}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (platforms != null) {
      return Container(
        margin: EdgeInsets.only(right: 20),
        width: 80,
        child: Column(
          children: <Widget>[
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  platforms['logo_path'] != null
                      ? "https://image.tmdb.org/t/p/w500" +
                          platforms['logo_path']
                      : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
                )),
            SizedBox(
              height: 10,
            ),
            Text(platforms['provider_name'],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(color: Colors.white70)),
            //SizedBox(height: 10),
          ],
        ),
      );
    } else
      return Container();
  }
}
