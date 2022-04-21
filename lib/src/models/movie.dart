class Movie {
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  //final int popularity;
  final String releaseDate;
  final String title;
  final bool video;
  final int voteCount;
  final String voteAverage;
  final int runtime;
  //final List genres;
  final String imdb_id;
  final String poster;

  String error;

  Movie(
      {this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      //this.popularity,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount,
      this.voteAverage,
      this.runtime,
      //this.genres,
      this.imdb_id,
      this.poster});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        //popularity: json['popularity'],
        releaseDate: json['release_date'] ?? '',
        title: json['title'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString(),
        runtime: json['runtime'],
        //genres: (json['genres'] as List).map((laung) => laung['name']).toList(),
        imdb_id: json['imdb_id'],
        poster: json['poster_path'] != null
            ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
            : "https://images.pexels.com/photos/11760757/pexels-photo-11760757.png?auto=compress&cs=tinysrgb&h=750&w=1260");
  }
}

class CastInfo {
  final String name;
  final String character;
  final String image;
  final String id;
  CastInfo({
    this.name,
    this.character,
    this.image,
    this.id,
  });
  factory CastInfo.fromJson(json) {
    return CastInfo(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      image: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['profile_path']
          : "",
    );
  }
}

class CastInfoList {
  final List<CastInfo> castList;
  CastInfoList({
    this.castList,
  });
  factory CastInfoList.fromJson(json) {
    return CastInfoList(
      castList: ((json['cast'] ?? []) as List)
          .map((cast) => CastInfo.fromJson(cast))
          .toList(),
    );
  }
}
