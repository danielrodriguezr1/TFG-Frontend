class TV {
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  //final int popularity;
  final String releaseDate;
  final String name;
  final bool video;
  final int voteCount;
  final String voteAverage;
  final String poster;

  String error;

  TV(
      {this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalName,
      this.overview,
      //this.popularity,
      this.releaseDate,
      this.name,
      this.video,
      this.voteCount,
      this.voteAverage,
      this.poster});

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
        releaseDate: json['first_air_date'] ?? '',
        name: json['name'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString(),
        poster: json['poster_path'] != null
            ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
            : "https://images.pexels.com/photos/11760757/pexels-photo-11760757.png?auto=compress&cs=tinysrgb&h=750&w=1260");
  }
}
