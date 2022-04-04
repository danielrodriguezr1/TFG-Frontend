class TV {
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  //final int popularity;
  final String posterPath;
  final String releaseDate;
  final String name;
  final bool video;
  final int voteCount;
  final String voteAverage;

  String error;

  TV(
      {this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalName,
      this.overview,
      //this.popularity,
      this.posterPath,
      this.releaseDate,
      this.name,
      this.video,
      this.voteCount,
      this.voteAverage});

  factory TV.fromJson(dynamic json) {
    if (json == null) {
      return TV();
    }

    return TV(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        //popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        name: json['name'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString());
  }
}
