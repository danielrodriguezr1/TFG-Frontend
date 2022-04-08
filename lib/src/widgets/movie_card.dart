import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//import '../animation.dart';
//import '../constants.dart';
//import '../screens/movie_info_screen/movie_Info_screen.dart';
//import '../screens/tvshow_info_screen/tvshow_info_screen.dart';
//import 'star_icon_display.dart';

class MovieCard extends StatelessWidget {
  final String poster;
  final String name;
  final String backdrop;
  final String date;
  final String id;
  final Color color;
  final VoidCallback onTap;
  final bool isMovie;
  const MovieCard({
    Key key,
    this.poster,
    this.name,
    this.backdrop,
    this.date,
    this.id,
    this.color,
    this.onTap,
    this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 280),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade900,
                  boxShadow: kElevationToShadow[8],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: poster,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      /*style: normalText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),*/
                    ),
                    Text(
                      date,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      /*style: normalText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: color.withOpacity(.8),
                      ),*/
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalMovieCard extends StatelessWidget {
  final String poster;
  final String name;
  final String backdrop;
  final String date;
  final double rate;
  final String id;
  final Color color;
  final bool isMovie;
  const HorizontalMovieCard({
    Key key,
    this.poster,
    this.name,
    this.backdrop,
    this.date,
    this.id,
    this.color,
    this.isMovie,
    this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        /*onTap: () {
          if (isMovie) {
            pushNewScreen(
              context,
              MovieDetailsScreen(
                id: id,
                backdrop: backdrop,
              ),
            );
          } else {
            pushNewScreen(
              context,
              TvShowDetailScreen(
                backdrop: backdrop,
                id: id,
              ),
            );
          }
        },*/
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(boxShadow: kElevationToShadow[8]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 9 / 14,
                    child: CachedNetworkImage(
                      imageUrl: poster,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 5),
                    /*Row(
                      children: [
                        IconTheme(
                          data: const IconThemeData(
                            color: Colors.cyanAccent,
                            size: 20,
                          ),
                          child: StarDisplay(
                            value: ((rate * 5) / 10).round(),
                          ),
                        ),
                        Text(
                          "  " + rate.toString() + "/10",
                          style: normalText.copyWith(
                            color: Colors.amber,
                            letterSpacing: 1.2,
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
