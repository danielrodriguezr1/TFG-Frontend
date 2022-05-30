import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';
import 'package:tfgapp/src/service/TMDB-Api_service.dart';

class DetailsTVScreen extends StatefulWidget {
  final String tvid, name, year, backdropPath, voteAverage; /*, overview*/
  const DetailsTVScreen({
    Key key,
    this.tvid,
    this.name,
    this.year,
    this.backdropPath,
    this.voteAverage,
    //this.overview,
  }) : super(key: key);

  @override
  _DetailsTVScreenState createState() => _DetailsTVScreenState();
}

class _DetailsTVScreenState extends State<DetailsTVScreen> {
  List<dynamic> mutuals = [];
  List<dynamic> mutualsNickname = [];
  List<dynamic> mutualsImage = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            'https://image.tmdb.org/t/p/original/${widget.backdropPath}',
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
                            Column(
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
                                        text:
                                            "${widget.voteAverage.substring(0, 3)}/",
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
                                    future: voteTVIMDB(widget.tvid),
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
                                    future: voteTVMetacritic(widget.tvid),
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
                                    future: voteTVFilmAffinity(widget.tvid),
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
                                    future: voteTVRottenTomatoes(widget.tvid),
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
                            )
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
                          Text(widget.name,
                              style: TextStyle(
                                color: Color(0xEAFFFFFF),
                                fontSize: 24,
                              )),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              (widget.year != '')
                                  ? Text(
                                      '${widget.year.substring(0, 4)}',
                                      style: TextStyle(color: Colors.white54),
                                    )
                                  : Text(''),
                              SizedBox(width: 10),
                              FutureBuilder(
                                  future: episodeRuntime(widget.tvid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}",
                                          style:
                                              TextStyle(color: Colors.white54));
                                    }
                                    return Container();
                                  }),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              FutureBuilder(
                                  future: numberOfSeasons(widget.tvid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}",
                                          style:
                                              TextStyle(color: Colors.white54));
                                    }
                                    return Container();
                                  }),
                              SizedBox(width: 10),
                              FutureBuilder(
                                  future: numberOfEpisodes(widget.tvid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}",
                                          style:
                                              TextStyle(color: Colors.white54));
                                    }
                                    return Container();
                                  }),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              FutureBuilder(
                                  future: statusTV(widget.tvid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}",
                                          style:
                                              TextStyle(color: Colors.white70));
                                    }
                                    return Container();
                                  }),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(children: [
                            FutureBuilder(
                                future: getRatingByUser(int.parse(widget.tvid)),
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
                                          addRating(
                                              int.parse(widget.tvid), rating);
                                        });
                                  }
                                  print("NO DATA");
                                  return Container();
                                })
                          ]),
                          SizedBox(height: 10),
                          Row(children: [
                            FutureBuilder(
                                future:
                                    existsInWatchlist(int.parse(widget.tvid)),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print(snapshot.data);
                                    if (snapshot.data == "404") {
                                      // ignore: deprecated_member_use
                                      return RaisedButton(
                                        onPressed: () {
                                          addToWatchlist(
                                              int.parse(widget.tvid));
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
                                                  BorderRadius.circular(30.0)),
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
                                          deleteFromWatchlistTV(
                                              int.parse(widget.tvid));
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
                                                  BorderRadius.circular(30.0)),
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
                                  } else
                                    return Container();
                                })
                          ]),

                          SizedBox(height: 10),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                      height: 400.0,
                                      width: 400.0,
                                      child: FutureBuilder(
                                          future: getMutuals(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (mutuals.length > 0) {
                                                return ListView.separated(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider();
                                                  },
                                                  itemCount: mutuals.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                        child: ListTile(
                                                      leading: Container(
                                                        width: 50,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                  mutualsImage[
                                                                      index],
                                                                ))),
                                                      ),
                                                      title: Text(
                                                        mutualsNickname[index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          //fontWeight: Constants.bolder,
                                                          //fontSize: Constants.l(context)
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        print(mutuals[index]
                                                            .toString());
                                                        addUserRecommendation(
                                                            int.parse(
                                                                widget.tvid),
                                                            mutuals[index]
                                                                .toString());
                                                        Navigator.pop(context);
                                                      },
                                                    ));
                                                  },
                                                );
                                              } else
                                                return Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25.0,
                                                            right: 25.0),
                                                    child: Text(
                                                        "No te sigues con ningun usuario mutuamente para poder recomendarle una película.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white70)),
                                                  ),
                                                );
                                            } else
                                              return Container();
                                          }),
                                    ),
                                  );
                                },
                              );
                            },
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
                      child: FutureBuilder(
                          future: posterTV(widget.tvid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${snapshot.data}',
                                height: 250,
                                width: 150,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img_not_found.jpg'),
                                ))),
                              );
                            } else
                              return Container();
                          }),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),

              ///GENEROS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 36,
                  child: FutureBuilder(
                      future: genresById(widget.tvid),
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
                child: FutureBuilder(
                    future: overviewByID(widget.tvid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("${snapshot.data}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white70));
                      }
                      return Container();
                    }),
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
                              future: crew(widget.tvid),
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
                          future: cast(widget.tvid),
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
                          future: platformFlatrateTV(widget.tvid),
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
                          future: platformBuyTV(widget.tvid),
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

  Future<void> addUserRecommendation(int idShow, String idUser) async {
    String code =
        await APIUserService().addUserRecommendationShow(idShow, idUser);
    print("CODEEEEEEEEEEEEE $code");
    if (code == "200")
      Fluttertoast.showToast(
        msg: 'Serie recomendada correctamente',
      );
    else
      Fluttertoast.showToast(
        msg: 'A este usuario ya se le ha recomendado esta serie',
      );
  }

  Future<List> getMutuals() async {
    List<dynamic> mutualsList = await APIUserService().getMutuals();
    print("MUTUALS");
    print(mutualsList);

    mutuals = mutualsList;

    await getMutualsNickname();
    return mutuals;
  }

  Future<List> getMutualsNickname() async {
    List<dynamic> mutualsList = await APIUserService().getMutualsNickname();
    print("MUTUALS");
    print(mutualsList);

    mutualsNickname = mutualsList;

    await getMutualsImage();
    return mutuals;
  }

  Future<List> getMutualsImage() async {
    List<dynamic> mutualsList = await APIUserService().getMutualsImage();
    print("MUTUALS");
    print(mutualsList);
    setState(() {
      mutualsImage = mutualsList;
    });
    return mutuals;
  }

  Future<void> addToWatchlist(int idMovie) async {
    await APIUserService().addToWatchlistTV(idMovie);
    print("ADDED TO WATCHLIST");
  }

  Future<void> deleteFromWatchlistTV(int idMovie) async {
    await APIUserService().deleteFromWatchlistTV(idMovie);
    print("REMOVED FROM WATCHLIST");
  }

  Future<String> existsInWatchlist(int idShow) async {
    String code = await APIUserService().existsInWatchlist(idShow);
    print("JEJE $code");
    return code;
  }

  Future<double> getRatingByUser(int idMovie) async {
    double rating = await APIUserService().getRatingByUser(idMovie);
    print("dfsdfsdf $rating");
    return rating;
  }

  Future<void> addRating(int idMovie, double rating) async {
    await APIUserService().addRating(idMovie, rating, 1);
    print("ADD RATING");
  }

  Future<TV> getTV(String idTV) async {
    TV tv = await TMDBApiService().getTV(idTV.toString());
    return tv;
  }

  Future<List<dynamic>> genresById(String idTV) async {
    List<dynamic> genres = await TMDBApiService().genresTVById(widget.tvid);
    return genres;
  }

  Future<List<dynamic>> crew(String idTV) async {
    List<dynamic> cast = await TMDBApiService().crewTV(widget.tvid);
    print(cast);
    //cast.sort((a, b) => a["job"].compareTo(b["job"]));

    return cast;
  }

  Future<List<dynamic>> cast(String idTV) async {
    List<dynamic> cast = await TMDBApiService().castTV(widget.tvid);
    return cast;
  }

  Future<List<dynamic>> platformBuyTV(String idTV) async {
    List<dynamic> platforms =
        await TMDBApiService().platformBuyTV(widget.tvid.toString());
    return platforms;
  }

  Future<List<dynamic>> platformFlatrateTV(String idTV) async {
    List<dynamic> platforms =
        await TMDBApiService().platformFlatrateTV(widget.tvid.toString());
    return platforms;
  }

  Future<String> overviewByID(String idTV) async {
    String overview = await TMDBApiService().overvieyTVById(widget.tvid);
    return overview;
  }

  Future<String> numberOfSeasons(String idTV) async {
    String numberSeasons = await TMDBApiService().numberOfSeasons(widget.tvid);
    return ('$numberSeasons temporadas');
  }

  Future<String> numberOfEpisodes(String idTV) async {
    String numberOfEpisodes =
        await TMDBApiService().numberOfEpisodes(widget.tvid);
    return ('$numberOfEpisodes episodios');
  }

  Future<String> posterTV(String idTV) async {
    String posterPath = await TMDBApiService().posterTV(widget.tvid);
    print(posterPath);
    return posterPath;
  }

  Future<String> episodeRuntime(String idTV) async {
    String episodeRuntime = await TMDBApiService().episodeRuntime(widget.tvid);
    return ('$episodeRuntime min');
  }

  Future<String> statusTV(String idTV) async {
    String status = await TMDBApiService().statusTV(widget.tvid);
    if (status == "Returning Series")
      return ('Serie en retorno.');
    else if (status == "In Production")
      return ('Serie en producción.');
    else if (status == "Ended")
      return ('Serie finalizada.');
    else if (status == "Canceled")
      return ('Serie cancelada.');
    else
      return ('En fase piloto.');
  }

  Future<String> voteTVIMDB(String idTV) async {
    String voteTVIMDB =
        await TMDBApiService().voteTVIMDB(widget.tvid.toString());
    return voteTVIMDB;
  }

  Future<String> voteTVMetacritic(String idTV) async {
    String voteTVMetacritic =
        await TMDBApiService().voteTVMetacritic(widget.tvid.toString());
    return voteTVMetacritic;
  }

  Future<String> voteTVFilmAffinity(String idTV) async {
    String voteTVFilmAffinity =
        await TMDBApiService().voteTVFilmAffinity(widget.tvid);
    return voteTVFilmAffinity;
  }

  Future<String> voteTVRottenTomatoes(String idTV) async {
    String voteTVRottenTomatoes =
        await TMDBApiService().voteTVRottenTomatoes(widget.tvid);
    return voteTVRottenTomatoes;
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
            "Creador",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF9A9BB2)),
          )
        ],
      ),
    );
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
