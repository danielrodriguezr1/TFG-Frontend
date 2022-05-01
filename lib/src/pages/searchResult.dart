import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '../../../animation.dart';
import 'package:tfgapp/src/widgets/movie_card.dart';
import 'package:tfgapp/src/widgets/no_results_found.dart';
//import '../../cast_info_screen/cast_info_screen.dart';
import 'package:tfgapp/src/cubit/search_results_cubit.dart';

class SearchResults extends StatefulWidget {
  final String query;
  final String urlProviders;
  final String urlYears;
  final String urlRuntimeEpisodeTV;
  final String urlCountries;
  final String urlGenres;
  final String urlVoteCount;
  final String urlVoteAverage;
  final String urlStatusTV;
  final bool discover;
  final bool buttonsBool;
  const SearchResults({
    Key key,
    this.query,
    this.urlProviders,
    this.urlYears,
    this.urlRuntimeEpisodeTV,
    this.urlCountries,
    this.urlGenres,
    this.urlVoteCount,
    this.urlVoteAverage,
    this.urlStatusTV,
    this.discover,
    this.buttonsBool,
  }) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  ScrollController movieController = ScrollController();
  ScrollController tvController = ScrollController();
  ScrollController personController = ScrollController();
  int currentPage;

  PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(
      initialPage: (widget.discover == true) ? 1 : 0,
    );
    movieController.addListener(movieScrollListener);
    tvController.addListener(tvScrollListener);
    personController.addListener(personScrollListener);
  }

  void movieScrollListener() {
    if (movieController.offset >= movieController.position.maxScrollExtent &&
        !movieController.position.outOfRange) {
      BlocProvider.of<SearchResultsCubit>(context).loadNextMoviePage();
    }
  }

  void tvScrollListener() {
    if (tvController.offset >= tvController.position.maxScrollExtent &&
        !tvController.position.outOfRange) {
      BlocProvider.of<SearchResultsCubit>(context).loadNextTvPage();
    }
  }

  void personScrollListener() {
    if (personController.offset >= personController.position.maxScrollExtent &&
        !personController.position.outOfRange) {
      BlocProvider.of<SearchResultsCubit>(context).loadNextPersonPage();
    }
  }

  @override
  void dispose() {
    personController.dispose();
    movieController.dispose();
    tvController.dispose();
    pageViewController.dispose();

    super.dispose();
  }

  var buttons = ['Películas', 'Series', 'Personas'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
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
            ])));
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<SearchResultsCubit, SearchResultsState>(
        builder: (context, state) {
      return Stack(
        children: [
          PageView(
            pageSnapping: true,
            onPageChanged: (i) {
              setState(() {
                currentPage = i;
              });
              if (i == 1) {
                if (state.shows.isEmpty) {
                  if (widget.discover == false)
                    BlocProvider.of<SearchResultsCubit>(context)
                        .initTv(widget.query);
                  else
                    BlocProvider.of<SearchResultsCubit>(context).initTV1(
                        widget.urlProviders,
                        widget.urlYears,
                        widget.urlRuntimeEpisodeTV,
                        widget.urlCountries,
                        widget.urlGenres,
                        widget.urlVoteCount,
                        widget.urlVoteAverage,
                        widget.urlStatusTV);
                }
              }
              if (i == 2) {
                if (state.people.isEmpty) {
                  BlocProvider.of<SearchResultsCubit>(context)
                      .initPeople(widget.query);
                }
              }
            },
            controller: pageViewController,
            children: [
              state.movieStatus != MovieStatus.loading
                  ? ListView(
                      controller: movieController,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        if (state.movies.isEmpty) const NoResultsFound(),
                        ...state.movies.map(
                          (movie) => HorizontalMovieCard(
                            movie: movie,
                            backdrop: movie.backdropPath,
                            color: Colors.white,
                            date: (movie.releaseDate != '')
                                ? movie.releaseDate.substring(0, 4)
                                : movie.releaseDate,
                            isMovie: true,
                            id: movie.id.toString(),
                            name: movie.title,
                            poster: movie.poster,
                            rate: (double.parse(movie.voteAverage) != 0)
                                ? movie.voteAverage
                                : '',
                          ),
                        ),
                        if (state.movieStatus == MovieStatus.adding)
                          Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade700,
                              //color: Theme.of(context).primaryColor,
                            ),
                          )
                      ],
                    )
                  : state.movieStatus == MovieStatus.loading
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              //color: Colors.grey.shade700,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : const Center(
                          child: ErrorPage(),
                        ),
              state.tvStatus != TvStatus.loading
                  ? ListView(
                      controller: tvController,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        if (state.shows.isEmpty) const NoResultsFound(),
                        ...state.shows.map(
                          (movie) => HorizontalMovieCard(
                            backdrop: movie.backdropPath,
                            color: Colors.white,
                            date: (movie.releaseDate != '')
                                ? movie.releaseDate.substring(0, 4)
                                : movie.releaseDate,
                            isMovie: false,
                            id: movie.id.toString(),
                            name: movie.name,
                            poster: movie.poster,
                            rate: (double.parse(movie.voteAverage) != 0)
                                ? movie.voteAverage
                                : '',
                          ),
                        ),
                        if (state.tvStatus == TvStatus.adding)
                          Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade700,
                              //color: Theme.of(context).primaryColor,
                            ),
                          )
                      ],
                    )
                  : state.tvStatus == TvStatus.loading
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              //color: Colors.grey.shade700,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : const Center(
                          child: ErrorPage(),
                        ),
              state.peopleStatus != PeopleStatus.loading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: GridView(
                        controller: personController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 9 / 16,
                          crossAxisCount: 2,
                        ),
                        children: [
                          if (state.people.isEmpty) const NoResultsFound(),
                          ...state.people.map((movie) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InkWell(
                                  onTap: () {
                                    /*pushNewScreen(
                                        context,
                                        CastInFoScreen(
                                            id: movie.id, backdrop: ''));*/
                                  },
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AspectRatio(
                                          aspectRatio: 9 / 14,
                                          child: CachedNetworkImage(
                                            imageUrl: movie.profile,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              color: Colors.grey.shade900,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          strokeWidth: 1,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        movie.name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          if (state.peopleStatus == PeopleStatus.adding)
                            Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey.shade700,
                              ),
                            )
                        ],
                      ),
                    )
                  : state.peopleStatus == PeopleStatus.loading
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              //color: Colors.grey.shade700,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : const Center(child: ErrorPage()),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF042725),
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade900, width: .6))),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          widget.buttonsBool == true
                              ? Text(
                                  'Resultados para "${widget.query}"',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.buttonsBool == true
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ...buttons.map(
                                    (button) => Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: currentPage ==
                                                  buttons.indexOf(button)
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey.shade700,
                                          width: .6,
                                        ),
                                        color: currentPage ==
                                                buttons.indexOf(button)
                                            ? Colors.cyanAccent
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 4),
                                          child: Text(
                                            button,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: currentPage ==
                                                      buttons.indexOf(button)
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            currentPage =
                                                buttons.indexOf(button);
                                          });

                                          pageViewController.animateToPage(
                                              currentPage,
                                              duration: const Duration(
                                                  microseconds: 1000),
                                              curve: Curves.bounceInOut);
                                          if (currentPage == 1) {
                                            if (state.shows.isEmpty) {
                                              BlocProvider.of<
                                                          SearchResultsCubit>(
                                                      context)
                                                  .initTv(widget.query);
                                            }
                                          }
                                          if (currentPage == 2) {
                                            if (state.people.isEmpty) {
                                              BlocProvider.of<
                                                          SearchResultsCubit>(
                                                      context)
                                                  .initPeople(widget.query);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
