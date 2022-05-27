import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_state.dart';
import 'package:tfgapp/src/bloc/moviebloc/watchlistTV_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/watchlist_bloc.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/pages/detailsMovieScreen.dart';
import 'package:tfgapp/src/pages/detailsTVScreen.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/recommendationScreen.dart';
import 'package:tfgapp/src/pages/searchScreen.dart';
import 'package:tfgapp/src/pages/userProfile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with TickerProviderStateMixin {
  int _paginaActual = 3;
  int initialIndex1 = 0;
  int initialIndex2 = 0;
  bool isMovie = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistBloc>(
          create: (_) => WatchlistBloc()..add(MovieEventStarted(0, '')),
        ),
        BlocProvider<WatchlistTVBloc>(
          create: (_) => WatchlistTVBloc()..add(TVEventStarted(0, '')),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF19191B),
        extendBody: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Icon(Icons.menu, color: Colors.white70),
            title: Center(
                child: Text("NOMBRE APP          ".toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _paginaActual = index;
              if (_paginaActual == 0) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SearchScreen()));
              } else if (_paginaActual == 1) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => RecommendationScreen()));
              } else if (_paginaActual == 2) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen()));
              } else if (_paginaActual == 4) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => UserProfileScreen("0")));
              }
            });
          },
          backgroundColor: Color(0xFF151C26),
          selectedItemColor: Color(0xFFF4C10F),
          unselectedItemColor: Color(0xFF5A606B),
          currentIndex: _paginaActual,
          //showSelectedLabels: true,
          //showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                  size: 20,
                ),
                label: "Buscar"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.recommend,
                  size: 20,
                ),
                label: "Recomendado"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 20,
                ),
                label: "Watchlist"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                  size: 20,
                ),
                label: "Perfil"),
          ],
          selectedLabelStyle: TextStyle(fontSize: 12),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF09FBD3),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFE53BB).withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 166,
                  width: 166,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF08F7FE).withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  ToggleSwitch(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    initialLabelIndex: initialIndex1,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Película', 'Serie'],
                    icons: [Icons.movie, Icons.tv],
                    customTextStyles: [
                      TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)
                    ],
                    activeBgColors: [
                      [Color(0xFFF4C10F)],
                      [Color(0xFFF4C10F)]
                    ],
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        initialIndex1 = index;
                        if (index == 0)
                          isMovie = true;
                        else
                          isMovie = false;
                      });
                    },
                  ),
                  (isMovie)
                      ? BlocBuilder<WatchlistBloc, MovieState>(
                          builder: (context, state) {
                            if (state is MovieLoading) {
                              return Center(
                                child: Platform.isAndroid
                                    ? CircularProgressIndicator()
                                    : CupertinoActivityIndicator(),
                              );
                            } else if (state is MovieLoaded) {
                              List<Movie> movies = state.movieList;
                              print(movies.length);
                              return Column(
                                children: [
                                  ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: movies.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Movie movie = movies[index];
                                      return InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsMovieScreen(
                                                movie: movie,
                                              ),
                                            )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // alignment: Alignment.bottomLeft,
                                          children: <Widget>[
                                            ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/original/${movie.poster}',
                                                height: 180,
                                                width: 120,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Platform
                                                        .isAndroid
                                                    ? CircularProgressIndicator()
                                                    : CupertinoActivityIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.jpg'),
                                                ))),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 25),
                                                  Text(
                                                    movie.title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    (movie.releaseDate != '')
                                                        ? movie.releaseDate
                                                            .substring(0, 4)
                                                        : movie.releaseDate,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      (movie.voteAverage != '')
                                                          ? RatingBar.builder(
                                                              itemSize: 8,
                                                              initialRating:
                                                                  double.parse(movie
                                                                          .voteAverage) /
                                                                      2,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              unratedColor:
                                                                  Colors.grey,
                                                              itemCount: 5,
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          2),
                                                              itemBuilder:
                                                                  (context, _) {
                                                                return const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                );
                                                              },
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            )
                                                          : Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          0)),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        (movie.voteAverage ==
                                                                '')
                                                            ? movie.voteAverage
                                                            : double.parse(movie
                                                                    .voteAverage)
                                                                .toStringAsFixed(
                                                                    1),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                child: Text('Hubo un error'),
                              );
                            }
                          },
                        )
                      : BlocBuilder<WatchlistTVBloc, TVState>(
                          builder: (context, state) {
                            if (state is TVLoading) {
                              return Center(
                                child: Platform.isAndroid
                                    ? CircularProgressIndicator()
                                    : CupertinoActivityIndicator(),
                              );
                            } else if (state is TVLoaded) {
                              List<TV> shows = state.tvList;
                              print(shows.length);
                              return Column(
                                children: [
                                  ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: shows.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      TV tv = shows[index];
                                      return InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsTVScreen(
                                                tvid: tv.id.toString(),
                                                name: tv.name,
                                                year: tv.releaseDate,
                                                backdropPath: tv.backdropPath,
                                                voteAverage: tv.voteAverage,
                                              ),
                                            )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // alignment: Alignment.bottomLeft,
                                          children: <Widget>[
                                            ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/original/${tv.poster}',
                                                height: 180,
                                                width: 120,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Platform
                                                        .isAndroid
                                                    ? CircularProgressIndicator()
                                                    : CupertinoActivityIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.jpg'),
                                                ))),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 25),
                                                  Text(
                                                    tv.name,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    (tv.releaseDate != '')
                                                        ? tv.releaseDate
                                                            .substring(0, 4)
                                                        : tv.releaseDate,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      (tv.voteAverage != '')
                                                          ? RatingBar.builder(
                                                              itemSize: 8,
                                                              initialRating:
                                                                  double.parse(tv
                                                                          .voteAverage) /
                                                                      2,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              unratedColor:
                                                                  Colors.grey,
                                                              itemCount: 5,
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          2),
                                                              itemBuilder:
                                                                  (context, _) {
                                                                return const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                );
                                                              },
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            )
                                                          : Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          0)),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        (tv.voteAverage == '')
                                                            ? tv.voteAverage
                                                            : double.parse(tv
                                                                    .voteAverage)
                                                                .toStringAsFixed(
                                                                    1),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                child: Text('Hubo un error'),
                              );
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ]));
  }
}
