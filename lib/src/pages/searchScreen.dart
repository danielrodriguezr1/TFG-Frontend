import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:tfgapp/src/bloc/moviebloc/popularTV_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/popular_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/topRated_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_event.dart';
import 'package:tfgapp/src/cubit/search_results_cubit.dart';
import 'package:tfgapp/src/models/country.dart';
import 'package:tfgapp/src/models/genre.dart';
import 'package:tfgapp/src/models/provider.dart';
import 'package:tfgapp/src/pages/countries.dart';
import 'package:tfgapp/src/pages/genresMovie.dart';
import 'package:tfgapp/src/pages/genresTV.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/providers.dart';
import 'package:tfgapp/src/pages/recommendationScreen.dart';
import 'package:tfgapp/src/pages/searchResult.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tfgapp/src/pages/userProfile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _paginaActual = 0;
  bool isMovie = true;
  String urlProviders = "";
  String urlProviders2 = "";
  String urlYears = "";
  String urlRuntime = "";
  String urlRuntimeEpisodeTV = "";
  String urlNumberOfSeasonsTV = "";
  String urlCountries = "";
  String urlGenres = "";
  String urlVoteCount = "vote_count.gte=500";
  String urlVoteAverage = "";
  String urlStatusTV = "";

  //PLATAFORMAS
  Color netflixSelected = Colors.transparent;
  Color primeVideoSelected = Colors.transparent;
  Color hboMaxSelected = Colors.transparent;
  Color disneyPlusSelected = Colors.transparent;
  Color filminSelected = Colors.transparent;
  Color appleTVSelected = Colors.transparent;
  Color rakutenSelected = Colors.transparent;
  Color mubiSelected = Colors.transparent;

  static List<Provider> providers = Providers.providers;
  final _itemsProviders = providers
      .map((provider) => MultiSelectItem(provider, provider.name))
      .toList();
  List<dynamic> _selectedProviders = [];

  //AÑO
  RangeValues valuesYear = RangeValues(1874, 2022);
  RangeLabels labelsYear = RangeLabels('1874', '2022');

  //DURACION
  RangeValues valuesRuntime = RangeValues(0, 180);
  RangeLabels labelsRuntime = RangeLabels('0', '180');

  RangeValues valuesRuntimeEpisodeTV = RangeValues(0, 90);
  RangeLabels labelsRuntimeEpisodeTV = RangeLabels('0', '90');

  RangeValues valuesNumberOfSeasonsTV = RangeValues(0, 10);
  RangeLabels labelsNumberOfSeasonsTV = RangeLabels('0', '10');

  //PAIS
  static List<Country> countries = Countries.countries;
  final _itemsCountries = countries
      .map((country) => MultiSelectItem(country, country.name))
      .toList();
  List<dynamic> _selectedCountries = [];

  //GENEROS
  static List<Genre> genres = GenresMovie.genres;
  final _itemsGenres =
      genres.map((genre) => MultiSelectItem(genre, genre.name)).toList();
  List<dynamic> _selectedGenresMovies = [];

  static List<Genre> genresTV = GenresTV.genres;
  final _itemsGenresTV =
      genresTV.map((genre) => MultiSelectItem(genre, genre.name)).toList();
  List<dynamic> _selectedGenresTV = [];

  //VOTOS MINIMOS
  RangeValues valuesVoteCount = RangeValues(500, 5000);
  RangeLabels labelsVoteCount = RangeLabels('500', '5000');

  //VALORACION MEDIA
  RangeValues valuesVoteAverage = RangeValues(0.0, 10.0);
  RangeLabels labelsVoteAverage = RangeLabels('0.0', '10.0');

  //TOGGLEs
  int initialIndex1 = 0;
  int initialIndex2 = 0;

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
                if (_paginaActual == 1) {
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
                          pageBuilder: (_, __, ___) => UserProfileScreen()));
                } else if (_paginaActual == 0) {}
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
                  icon: Icon(Icons.recommend, size: 20), label: "Recomendado"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  ),
                  label: "Inicio"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, size: 20), label: "Watchlist"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_rounded,
                    size: 20,
                  ),
                  label: "Perfil")
            ],
            selectedLabelStyle: TextStyle(fontSize: 12),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SizedBox(
                //height: MediaQuery.of(context).size.height,
                //width: MediaQuery.of(context).size.width,
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
                                                    query: query,
                                                    buttonsBool: true,
                                                    discover: false,
                                                  ),
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
                                                    query: query,
                                                    buttonsBool: true,
                                                    discover: false,
                                                  ),
                                                )));
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 50, left: 8, right: 8),
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "¿Buscas algo en concreto?".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ])),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Introduce los filtros necesarios para encontrar la película o serie que más se ajuste a tus preferencias.",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: (Colors.white70)),
                                  ),
                                ),
                              ])),
                      SizedBox(height: 10),

                      //ELEGIR PELICULA O SERIE
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleSwitch(
                              minWidth: 100.0,
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)
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
                            )
                          ]),
                      SizedBox(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige tus plataformas",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 20),

                          //PLATAFORMAS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Container(
                                      child: Material(
                                    color: Colors.transparent,
                                    shadowColor: netflixSelected,
                                    elevation: 8,
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          if (netflixSelected ==
                                              Colors.transparent) {
                                            netflixSelected = Colors.white;
                                            urlProviders += "|8";
                                          } else {
                                            netflixSelected =
                                                Colors.transparent;
                                            urlProviders = urlProviders
                                                .replaceAll("|8", "");
                                          }
                                        });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/netflix.jpg'),
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text("Netflix",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Container(
                                      child: Material(
                                    color: Colors.transparent,
                                    shadowColor: primeVideoSelected,
                                    elevation: 8,
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          if (primeVideoSelected ==
                                              Colors.transparent) {
                                            primeVideoSelected = Colors.white;
                                            urlProviders += "|119|9";
                                          } else {
                                            primeVideoSelected =
                                                Colors.transparent;
                                            urlProviders = urlProviders
                                                .replaceAll("|119|9", "");
                                          }
                                        });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/primevideo.jpg'),
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text("Prime Video",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Container(
                                      child: Material(
                                    color: Colors.transparent,
                                    shadowColor: hboMaxSelected,
                                    elevation: 8,
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          if (hboMaxSelected ==
                                              Colors.transparent) {
                                            hboMaxSelected = Colors.white;
                                            urlProviders += "|384";
                                          } else {
                                            hboMaxSelected = Colors.transparent;
                                            urlProviders = urlProviders
                                                .replaceAll("|384", "");
                                          }
                                        });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/hbomax.jpg'),
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text("HBO Max",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Container(
                                      child: Material(
                                    color: Colors.transparent,
                                    shadowColor: disneyPlusSelected,
                                    elevation: 8,
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          if (disneyPlusSelected ==
                                              Colors.transparent) {
                                            disneyPlusSelected = Colors.white;
                                            urlProviders += "|337";
                                          } else {
                                            disneyPlusSelected =
                                                Colors.transparent;
                                            urlProviders = urlProviders
                                                .replaceAll("|337", "");
                                          }
                                        });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/disney.jpg'),
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text("Disney Plus",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    Container(
                                        child: Material(
                                      color: Colors.transparent,
                                      shadowColor: filminSelected,
                                      elevation: 8,
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (filminSelected ==
                                                Colors.transparent) {
                                              filminSelected = Colors.white;
                                              urlProviders += "|63";
                                            } else {
                                              filminSelected =
                                                  Colors.transparent;
                                              urlProviders = urlProviders
                                                  .replaceAll("|63", "");
                                            }
                                          });
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/filmin.png'),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Text("Filmin",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  children: [
                                    Container(
                                        child: Material(
                                      color: Colors.transparent,
                                      shadowColor: appleTVSelected,
                                      elevation: 8,
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (appleTVSelected ==
                                                Colors.transparent) {
                                              appleTVSelected = Colors.white;
                                              urlProviders += "|350";
                                            } else {
                                              appleTVSelected =
                                                  Colors.transparent;
                                              urlProviders = urlProviders
                                                  .replaceAll("|350", "");
                                            }
                                          });
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/appletv.png'),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Text("Apple TV",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  children: [
                                    Container(
                                        child: Material(
                                      color: Colors.transparent,
                                      shadowColor: rakutenSelected,
                                      elevation: 8,
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (rakutenSelected ==
                                                Colors.transparent) {
                                              rakutenSelected = Colors.white;
                                              urlProviders += "|35";
                                            } else {
                                              rakutenSelected =
                                                  Colors.transparent;
                                              urlProviders = urlProviders
                                                  .replaceAll("|35", "");
                                            }
                                          });
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/rakutentv.png'),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Text("Rakuten",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  children: [
                                    Container(
                                        child: Material(
                                      color: Colors.transparent,
                                      shadowColor: mubiSelected,
                                      elevation: 8,
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (mubiSelected ==
                                                Colors.transparent) {
                                              mubiSelected = Colors.white;
                                              urlProviders += "|11";
                                            } else {
                                              mubiSelected = Colors.transparent;
                                              urlProviders = urlProviders
                                                  .replaceAll("|11", "");
                                            }
                                          });
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/mubi.jpg'),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Text("Mubi",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ]),
                          SizedBox(height: 30),
                          Builder(
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MultiSelectDialogField(
                                    searchable: true,
                                    searchTextStyle:
                                        TextStyle(color: Colors.white),
                                    searchIcon:
                                        Icon(Icons.search, color: Colors.white),
                                    searchHint: "Buscar plataforma...",
                                    searchHintStyle:
                                        TextStyle(color: Colors.white),
                                    closeSearchIcon:
                                        Icon(Icons.close, color: Colors.white),
                                    backgroundColor: Color(0xFF282828),
                                    checkColor: Colors.black,
                                    selectedItemsTextStyle:
                                        TextStyle(color: Colors.white),
                                    itemsTextStyle:
                                        TextStyle(color: Colors.white70),
                                    items: _itemsProviders,
                                    confirmText: Text("Aceptar"),
                                    cancelText: Text("Cancelar"),
                                    title: Text("Plataformas",
                                        style: TextStyle(color: Colors.white)),
                                    selectedColor: Colors.white70,
                                    unselectedColor: Colors.white70,
                                    chipDisplay: MultiSelectChipDisplay(
                                      textStyle: TextStyle(color: Colors.white),
                                      chipColor: Colors.grey,
                                      alignment: Alignment.center,
                                      scrollBar: HorizontalScrollBar(),
                                      scroll: true,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    buttonIcon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                    buttonText: Text(
                                      "Selecciona otra plataforma",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm: (results) {
                                      _selectedProviders = results;
                                      setState(() {
                                        urlProviders2 = "";
                                        for (int i = 0;
                                            i < _selectedProviders.length;
                                            i++) {
                                          String codeProvider =
                                              _selectedProviders[i]
                                                  .toString()
                                                  .replaceAll(
                                                      new RegExp(r'[^0-9]'),
                                                      '');
                                          urlProviders2 += "|$codeProvider";
                                        }
                                      });
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(height: 60),

                          //AÑO
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige el año",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            buildSideLabel("1874"),
                            Expanded(
                              child: RangeSlider(
                                min: 1874,
                                max: 2022,
                                activeColor: Colors.white,
                                inactiveColor: Colors.black12,
                                values: valuesYear,
                                divisions: 148,
                                labels: labelsYear,
                                onChanged: (value) {
                                  setState(() {
                                    if (isMovie) {
                                      urlYears =
                                          "primary_release_date.gte=${value.start.toInt().toString()}-01-01&primary_release_date.lte=${value.end.toInt().toString()}-12-31";
                                      valuesYear = value;
                                      labelsYear = RangeLabels(
                                          '${value.start.toInt().toString()}',
                                          '${value.end.toInt().toString()}');
                                    } else {
                                      urlYears =
                                          "first_air_date.gte=${value.start.toInt().toString()}-01-01&first_air_date.lte=${value.end.toInt().toString()}-12-31";
                                      valuesYear = value;
                                      labelsYear = RangeLabels(
                                          '${value.start.toInt().toString()}',
                                          '${value.end.toInt().toString()}');
                                    }
                                  });
                                },
                              ),
                            ),
                            buildSideLabel("2022")
                          ]),
                          SizedBox(height: 60),

                          //DURACION
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (isMovie == true)
                                  ? Text("Elige la duración",
                                      style: TextStyle(color: Colors.white70))
                                  : Text(
                                      "Elige la duración media de los capítulos",
                                      style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          // DURACION PELICULAS
                          (isMovie == true)
                              ? Row(children: [
                                  buildSideLabel("0"),
                                  Expanded(
                                    child: RangeSlider(
                                      min: 0,
                                      max: 180,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.black12,
                                      values: valuesRuntime,
                                      divisions: 36,
                                      labels: labelsRuntime,
                                      onChanged: (value) {
                                        setState(() {
                                          var valueEnd =
                                              value.end.toInt().toString();
                                          if (valueEnd == "180") valueEnd = "";
                                          urlRuntime =
                                              // ignore: unnecessary_brace_in_string_interps
                                              "with_runtime.gte=${value.start.toInt().toString()}&with_runtime.lte=${valueEnd}";
                                          valuesRuntime = value;
                                          labelsRuntime = RangeLabels(
                                              '${value.start.toInt().toString()}',
                                              '${value.end.toInt().toString()}');
                                        });
                                      },
                                    ),
                                  ),
                                  buildSideLabel("+180")
                                ])
                              :

                              //DURACION CAPITULOS SERIES

                              Row(children: [
                                  buildSideLabel("0"),
                                  Expanded(
                                    child: RangeSlider(
                                      min: 0,
                                      max: 90,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.black12,
                                      values: valuesRuntimeEpisodeTV,
                                      divisions: 45,
                                      labels: labelsRuntimeEpisodeTV,
                                      onChanged: (value) {
                                        setState(() {
                                          var valueEnd =
                                              value.end.toInt().toString();
                                          if (valueEnd == "90") valueEnd = "";
                                          urlRuntimeEpisodeTV =
                                              // ignore: unnecessary_brace_in_string_interps
                                              "with_runtime.gte=${value.start.toInt().toString()}&with_runtime.lte=${valueEnd}";
                                          valuesRuntimeEpisodeTV = value;
                                          labelsRuntimeEpisodeTV = RangeLabels(
                                              '${value.start.toInt().toString()}',
                                              '${value.end.toInt().toString()}');
                                        });
                                      },
                                    ),
                                  ),
                                  buildSideLabel("+90")
                                ]),

                          SizedBox(height: 40),

                          //PAISES
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige el país",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          Builder(
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MultiSelectDialogField(
                                  searchable: true,
                                  searchTextStyle:
                                      TextStyle(color: Colors.white),
                                  searchIcon:
                                      Icon(Icons.search, color: Colors.white),
                                  searchHint: "Buscar país...",
                                  searchHintStyle:
                                      TextStyle(color: Colors.white),
                                  closeSearchIcon:
                                      Icon(Icons.close, color: Colors.white),
                                  backgroundColor: Color(0xFF282828),
                                  checkColor: Colors.black,
                                  selectedItemsTextStyle:
                                      TextStyle(color: Colors.white),
                                  itemsTextStyle:
                                      TextStyle(color: Colors.white70),
                                  items: _itemsCountries,
                                  confirmText: Text("Aceptar"),
                                  cancelText: Text("Cancelar"),
                                  title: Text("Países",
                                      style: TextStyle(color: Colors.white)),
                                  selectedColor: Colors.white70,
                                  unselectedColor: Colors.white70,
                                  chipDisplay: MultiSelectChipDisplay(
                                    textStyle: TextStyle(color: Colors.white),
                                    chipColor: Colors.grey,
                                    alignment: Alignment.center,
                                    scrollBar: HorizontalScrollBar(),
                                    scroll: true,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  buttonIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,
                                  ),
                                  buttonText: Text(
                                    "Seleccionar países",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    urlCountries = "";
                                    _selectedCountries = results;
                                    setState(() {
                                      for (int i = 0;
                                          i < _selectedCountries.length;
                                          i++) {
                                        String codeCountry =
                                            _selectedCountries[i]
                                                .toString()
                                                .substring(5, 7);
                                        urlCountries += "|$codeCountry";
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          //GENEROS
                          SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige el género",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          Builder(
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MultiSelectDialogField(
                                  searchable: true,
                                  searchTextStyle:
                                      TextStyle(color: Colors.white),
                                  searchIcon:
                                      Icon(Icons.search, color: Colors.white),
                                  searchHint: "Buscar género...",
                                  searchHintStyle:
                                      TextStyle(color: Colors.white),
                                  closeSearchIcon:
                                      Icon(Icons.close, color: Colors.white),
                                  backgroundColor: Color(0xFF282828),
                                  checkColor: Colors.black,
                                  selectedItemsTextStyle:
                                      TextStyle(color: Colors.white),
                                  itemsTextStyle:
                                      TextStyle(color: Colors.white70),
                                  items: (isMovie == true)
                                      ? _itemsGenres
                                      : _itemsGenresTV,
                                  confirmText: Text("Aceptar"),
                                  cancelText: Text("Cancelar"),
                                  title: Text("Géneros",
                                      style: TextStyle(color: Colors.white)),
                                  selectedColor: Colors.white70,
                                  unselectedColor: Colors.white70,
                                  chipDisplay: MultiSelectChipDisplay(
                                    textStyle: TextStyle(color: Colors.white),
                                    chipColor: Colors.grey,
                                    alignment: Alignment.center,
                                    scrollBar: HorizontalScrollBar(),
                                    scroll: true,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  buttonIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,
                                  ),
                                  buttonText: Text(
                                    "Seleccionar géneros",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    urlGenres = "";
                                    if (isMovie) {
                                      _selectedGenresMovies = results;
                                      setState(() {
                                        for (int i = 0;
                                            i < _selectedGenresMovies.length;
                                            i++) {
                                          String codeGenre =
                                              _selectedGenresMovies[i]
                                                  .toString()
                                                  .replaceAll(
                                                      new RegExp(r'[^0-9]'),
                                                      '');
                                          urlGenres += ",$codeGenre";
                                        }
                                      });
                                    } else {
                                      _selectedGenresTV = results;
                                      setState(() {
                                        for (int i = 0;
                                            i < _selectedGenresTV.length;
                                            i++) {
                                          String codeGenre =
                                              _selectedGenresTV[i]
                                                  .toString()
                                                  .replaceAll(
                                                      new RegExp(r'[^0-9]'),
                                                      '');
                                          urlGenres += ",$codeGenre";
                                        }
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          //VOTE COUNT
                          SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige el número de votos mínimos",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            buildSideLabel("0"),
                            Expanded(
                              child: RangeSlider(
                                min: 0,
                                max: 5000,
                                activeColor: Colors.white,
                                inactiveColor: Colors.black12,
                                values: valuesVoteCount,
                                divisions: 50,
                                labels: labelsVoteCount,
                                onChanged: (value) {
                                  setState(() {
                                    var valueEnd = value.end.toInt().toString();
                                    if (valueEnd == "5000") valueEnd = "";
                                    urlVoteCount =
                                        // ignore: unnecessary_brace_in_string_interps
                                        "vote_count.gte=${value.start.toInt().toString()}&vote_count.lte=${valueEnd}";
                                    valuesVoteCount = value;
                                    labelsVoteCount = RangeLabels(
                                        '${value.start.toInt().toString()}',
                                        '${value.end.toInt().toString()}');
                                  });
                                },
                              ),
                            ),
                            buildSideLabel("+5000")
                          ]),

                          //VOTE AVERAGE
                          SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Elige la valoración",
                                  style: TextStyle(color: Colors.white70))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            buildSideLabel("0"),
                            Expanded(
                              child: RangeSlider(
                                min: 0,
                                max: 10,
                                activeColor: Colors.white,
                                inactiveColor: Colors.black12,
                                values: valuesVoteAverage,
                                divisions: 20,
                                labels: labelsVoteAverage,
                                onChanged: (value) {
                                  setState(() {
                                    value.end.toInt().toString();
                                    urlVoteAverage =
                                        "vote_average.gte=${double.parse(value.start.toString())}&vote_average.lte=${double.parse(value.end.toString())}";
                                    valuesVoteAverage = value;
                                    labelsVoteAverage = RangeLabels(
                                        '${double.parse(value.start.toString())}',
                                        '${double.parse(value.end.toString())}');
                                  });
                                },
                              ),
                            ),
                            buildSideLabel("10")
                          ]),

                          (isMovie == false)
                              ? SizedBox(height: 50)
                              : SizedBox(height: 10),
                          //ESTADO SERIE
                          (isMovie == false)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Elige el estado de la serie",
                                        style: TextStyle(color: Colors.white70))
                                  ],
                                )
                              : SizedBox(
                                  height: 0,
                                ),

                          SizedBox(height: 20),
                          (isMovie == false)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ToggleSwitch(
                                      minWidth: 100,
                                      cornerRadius: 20.0,
                                      activeFgColor: Colors.white,
                                      inactiveBgColor: Colors.grey,
                                      inactiveFgColor: Colors.white,
                                      initialLabelIndex: initialIndex2,
                                      totalSwitches: 3,
                                      labels: [
                                        'En emisión',
                                        'Finlizada',
                                        'No importa'
                                      ],
                                      customTextStyles: [
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)
                                      ],
                                      activeBgColors: [
                                        [Color(0xFFF4C10F)],
                                        [Color(0xFFF4C10F)],
                                        [Color(0xFFF4C10F)]
                                      ],
                                      onToggle: (index) {
                                        print('switched to: $index');
                                        setState(() {
                                          initialIndex2 = index;
                                          if (index == 0)
                                            urlStatusTV = "with_status=0";
                                          else if (index == 1)
                                            urlStatusTV = "with_status=2";
                                        });
                                      },
                                    )
                                  ],
                                )
                              : SizedBox(height: 0),

                          //BOTON BUSCAR
                          (isMovie == false)
                              ? SizedBox(height: 50)
                              : SizedBox(height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.0,
                                margin: EdgeInsets.all(10),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: () {
                                    print(urlProviders);
                                    print(valuesYear.start.toString());
                                    print(valuesYear.end.toString());

                                    String urlProvidersEnd =
                                        (urlProviders + urlProviders2);
                                    if (urlProviders == "") urlProviders = "0";
                                    print("HOLAAAAAAAAA$urlProviders");
                                    if (isMovie) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SearchResultsCubit()
                                                          ..init1(
                                                              urlProvidersEnd,
                                                              urlYears,
                                                              urlRuntime,
                                                              urlCountries,
                                                              urlGenres,
                                                              urlVoteCount,
                                                              urlVoteAverage),
                                                    child: SearchResults(
                                                      query: urlProvidersEnd,
                                                      buttonsBool: false,
                                                      discover: false,
                                                    ),
                                                  )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SearchResultsCubit()
                                                          ..initTV1(
                                                              urlProvidersEnd,
                                                              urlYears,
                                                              urlRuntimeEpisodeTV,
                                                              urlCountries,
                                                              urlGenres,
                                                              urlVoteCount,
                                                              urlVoteAverage,
                                                              urlStatusTV),
                                                    child: SearchResults(
                                                      urlProviders:
                                                          urlProvidersEnd,
                                                      urlYears: urlYears,
                                                      urlRuntimeEpisodeTV:
                                                          urlRuntimeEpisodeTV,
                                                      urlCountries:
                                                          urlCountries,
                                                      urlGenres: urlGenres,
                                                      urlVoteCount:
                                                          urlVoteCount,
                                                      urlVoteAverage:
                                                          urlVoteAverage,
                                                      urlStatusTV: urlStatusTV,
                                                      discover: true,
                                                      buttonsBool: false,
                                                    ),
                                                  )));
                                    }
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
                                          maxWidth: 150.0, maxHeight: 40.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Buscar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ])),
          )),
    );
  }

  Widget buildSideLabel(String value) => Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      width: 50,
      child: Text(
        value,
        //value.round().toString(),
        style: TextStyle(fontSize: 14, color: Colors.white70),
        textAlign: TextAlign.center,
      ));
}
