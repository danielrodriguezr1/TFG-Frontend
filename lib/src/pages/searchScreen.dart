import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/popularTV_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/popular_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/topRated_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_event.dart';
import 'package:tfgapp/src/cubit/search_results_cubit.dart';
import 'package:tfgapp/src/pages/homeScreen.dart';
import 'package:tfgapp/src/pages/searchResult.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _paginaActual = 0;
  bool isMovie;
  bool isVisible = false;
  String urlProviders = "";
  String urlYears = "";

  //PLATAFORMAS
  Color netflixSelected = Colors.transparent;
  Color primeVideoSelected = Colors.transparent;
  Color hboMaxSelected = Colors.transparent;
  Color disneyPlusSelected = Colors.transparent;
  Color filminSelected = Colors.transparent;
  Color appleTVSelected = Colors.transparent;
  Color rakutenSelected = Colors.transparent;
  Color mubiSelected = Colors.transparent;

  //AÑO
  RangeValues values = RangeValues(1874, 2022);
  RangeLabels labels = RangeLabels('1874', '2022');

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
                if (_paginaActual == 2) {
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
                                    "Introduce los filtros necesarios para encontrar la película o serie que más se ajuste a tus preferencias",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: (Colors.white70)),
                                  ),
                                ),
                              ])),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isMovie = false;
                                isVisible = true;
                              });
                            },
                            child: Text(
                              "Película",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white70)),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isMovie = false;
                                isVisible = false;
                              });
                            },
                            child: Text(
                              "Serie",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white70)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Visibility(
                          visible: isVisible,
                          child: Column(
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                        shadowColor: primeVideoSelected,
                                        elevation: 8,
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              if (primeVideoSelected ==
                                                  Colors.transparent) {
                                                primeVideoSelected =
                                                    Colors.white;
                                                urlProviders += "|119";
                                              } else {
                                                primeVideoSelected =
                                                    Colors.transparent;
                                                urlProviders = urlProviders
                                                    .replaceAll("|119", "");
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
                                        shadowColor: hboMaxSelected,
                                        elevation: 8,
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              if (hboMaxSelected ==
                                                  Colors.transparent) {
                                                hboMaxSelected = Colors.white;
                                                urlProviders += "|384";
                                              } else {
                                                hboMaxSelected =
                                                    Colors.transparent;
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
                                        shadowColor: disneyPlusSelected,
                                        elevation: 8,
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              if (disneyPlusSelected ==
                                                  Colors.transparent) {
                                                disneyPlusSelected =
                                                    Colors.white;
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
                                            style:
                                                TextStyle(color: Colors.white)),
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
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
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              setState(() {
                                                if (appleTVSelected ==
                                                    Colors.transparent) {
                                                  appleTVSelected =
                                                      Colors.white;
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
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              setState(() {
                                                if (rakutenSelected ==
                                                    Colors.transparent) {
                                                  rakutenSelected =
                                                      Colors.white;
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
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              setState(() {
                                                if (mubiSelected ==
                                                    Colors.transparent) {
                                                  mubiSelected = Colors.white;
                                                  urlProviders += "|11";
                                                } else {
                                                  mubiSelected =
                                                      Colors.transparent;
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
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ]),
                              SizedBox(height: 60),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Elige el año",
                                      style: TextStyle(color: Colors.white70))
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                buildSideLabel(1874),
                                Expanded(
                                  child: RangeSlider(
                                    min: 1874,
                                    max: 2022,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.black12,
                                    values: values,
                                    divisions: 148,
                                    labels: labels,
                                    onChanged: (value) {
                                      setState(() {
                                        urlYears =
                                            "primary_release_date.gte=${value.start.toInt().toString()}-01-01&primary_release_date.lte=${value.end.toInt().toString()}-12-31";
                                        values = value;
                                        labels = RangeLabels(
                                            '${value.start.toInt().toString()}',
                                            '${value.end.toInt().toString()}');
                                      });
                                    },
                                  ),
                                ),
                                buildSideLabel(2022)
                              ]),
                              SizedBox(height: 20),
                              SizedBox(height: 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      print(urlProviders);
                                      print(values.start.toString());
                                      print(values.end.toString());
                                      if (urlProviders == "")
                                        urlProviders = "0";
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SearchResultsCubit()
                                                          ..init1(urlProviders,
                                                              urlYears),
                                                    child: SearchResults(
                                                        query: urlProviders),
                                                  )));
                                    },
                                    child: Text("BUSCAR",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ])),
          )),
    );
  }

  Widget buildSideLabel(double value) => Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      width: 45,
      child: Text(
        value.round().toString(),
        style: TextStyle(fontSize: 14, color: Colors.white70),
        textAlign: TextAlign.center,
      ));
}
