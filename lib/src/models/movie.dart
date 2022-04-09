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
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString(),
        poster: json['poster_path'] != null
            ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
            : "https://images.pexels.com/photos/11760757/pexels-photo-11760757.png?auto=compress&cs=tinysrgb&h=750&w=1260");
  }
}
