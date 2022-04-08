import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/popularTV_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/popular_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:tfgapp/src/bloc/moviebloc/topRated_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_state.dart';
import 'package:tfgapp/src/cubit/search_results_cubit.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/searchResult.dart';
import 'package:tfgapp/src/service/TMDB-Api_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStarted(0, '')),
        ),
        BlocProvider<TopRatedBloc>(
          create: (_) => TopRatedBloc()..add(MovieEventStarted(1, '')),
        ),
        BlocProvider<PopularBloc>(
          create: (_) => PopularBloc()..add(MovieEventStarted(1, '')),
        ),
        BlocProvider<PopularTVBloc>(
          create: (_) => PopularTVBloc()..add(TVEventStarted(0, '')),
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
                child: Text("TÍTULO APP          ".toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _paginaActual = index;
              if (_paginaActual == 1) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen()));
              } else if (_paginaActual == 1) {}
            });
          },
          backgroundColor: Color(0xFF151C26),
          selectedItemColor: Color(0xFFF4C10F),
          unselectedItemColor: Color(0xFF5A606B),
          currentIndex: _paginaActual,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: "Buscar"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Watchlist"),
          ],
        ),
        body: SizedBox(
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
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Search Me");
                              },
                              child: Container(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white70,
                                ),
                                margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    hintText:
                                        "Buscar película, serie o persona"),
                                style: TextStyle(color: Colors.white70),
                                onSubmitted: (query) {
                                  if (query.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                      SearchResultsCubit()
                                                        ..init(query),
                                                  child: SearchResults(
                                                      query: query),
                                                )));

                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                      SearchResultsCubit()
                                                        ..init(query),
                                                  child: SearchResults(
                                                      query: query),
                                                )));
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
