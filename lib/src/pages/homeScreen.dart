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
import 'package:tfgapp/src/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/pages/detailsMovieScreen.dart';
import 'package:tfgapp/src/pages/detailsTVScreen.dart';
import 'package:tfgapp/src/pages/recommendationScreen.dart';
import 'package:tfgapp/src/pages/searchScreen.dart';
import 'package:tfgapp/src/pages/userProfile.dart';
import 'package:tfgapp/src/pages/watchlistScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaActual = 2;
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
              } else if (_paginaActual == 3) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => WatchlistScreen()));
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
                child: _buildBody(context),
              )
            ])),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<PopularBloc, MovieState>(
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
                        CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie movie = movies[index];
                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsMovieScreen(
                                      movie: movie,
                                    ),
                                  )),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.poster}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      ))),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, left: 15),
                                      child: Text(
                                        movie.title.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(microseconds: 1000),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      child: Text('Hubo un error'),
                    );
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'Películas en tendencia'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center();
                  } else if (state is MovieLoaded) {
                    List<Movie> movieList = state.movieList;
                    return Container(
                      height: 300,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => VerticalDivider(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          Movie movie = movieList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsMovieScreen(
                                    movie: movie,
                                  ),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 190,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 190,
                                      height: 250,
                                      child: Center(
                                        child: Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 190,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 180,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      RatingBar.builder(
                                        itemSize: 8,
                                        initialRating:
                                            double.parse(movie.voteAverage) / 2,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        itemBuilder: (context, _) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          );
                                        },
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Text(
                                        movie.voteAverage,
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'Series en tendencia'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<PopularTVBloc, TVState>(
                builder: (context, state) {
                  if (state is TVLoading) {
                    return Center();
                  } else if (state is TVLoaded) {
                    List<TV> tvList = state.tvList;
                    return Container(
                      height: 300,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => VerticalDivider(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: tvList.length,
                        itemBuilder: (context, index) {
                          TV tv = tvList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsTVScreen(
                                    tvid: tv.id.toString(),
                                    name: tv.name,
                                    year: tv.releaseDate,
                                    backdropPath: tv.backdropPath,
                                    voteAverage: tv.voteAverage,
                                    //overview: tv.overview,
                                  ),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 190,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 190,
                                      height: 250,
                                      child: Center(
                                        child: Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 190,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 180,
                                  height: 12,
                                  child: Text(
                                    tv.name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      RatingBar.builder(
                                        itemSize: 8,
                                        initialRating:
                                            double.parse(tv.voteAverage) / 2,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        itemBuilder: (context, _) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          );
                                        },
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Text(
                                        tv.voteAverage,
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'Mejor valorado'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<TopRatedBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center();
                  } else if (state is MovieLoaded) {
                    List<Movie> movieList = state.movieList;
                    return Container(
                      height: 300,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => VerticalDivider(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          Movie movie = movieList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsMovieScreen(
                                    movie: movie,
                                  ),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 190,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 190,
                                      height: 250,
                                      child: Center(
                                        child: Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 190,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 180,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      RatingBar.builder(
                                        itemSize: 8,
                                        initialRating:
                                            double.parse(movie.voteAverage) / 2,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        itemBuilder: (context, _) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          );
                                        },
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Text(
                                        movie.voteAverage,
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
