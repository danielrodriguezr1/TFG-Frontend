part of 'search_results_cubit.dart';

enum MovieStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allfetched,
}
enum TvStatus {
  initial,
  loading,
  loaded,
  adding,

  allfetched,
  error,
}
enum PeopleStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allfetched,
}

class SearchResultsState {
  final int moviePage;
  final int tvPage;
  final int peoplePage;
  final bool moviesFull;
  final bool tvFull;
  final bool peopleFull;
  final String query;
  final MovieStatus movieStatus;
  final PeopleStatus peopleStatus;
  final TvStatus tvStatus;
  final List<Movie> movies;
  final List<TV> shows;
  final List<People> people;
  SearchResultsState({
    this.moviePage,
    this.tvPage,
    this.peoplePage,
    this.moviesFull,
    this.tvFull,
    this.peopleFull,
    this.query,
    this.movieStatus,
    this.peopleStatus,
    this.tvStatus,
    this.movies,
    this.shows,
    this.people,
  });
  factory SearchResultsState.initial() => SearchResultsState(
        tvPage: 1,
        tvStatus: TvStatus.initial,
        shows: [],
        moviePage: 1,
        movieStatus: MovieStatus.initial,
        tvFull: false,
        moviesFull: false,
        peopleFull: false,
        movies: [],
        people: [],
        peoplePage: 1,
        peopleStatus: PeopleStatus.initial,
        query: '',
      );

  SearchResultsState copyWith({
    int moviePage,
    int tvPage,
    int peoplePage,
    bool moviesFull,
    bool tvFull,
    bool peopleFull,
    String query,
    MovieStatus movieStatus,
    PeopleStatus peopleStatus,
    TvStatus tvStatus,
    List<Movie> movies,
    List<TV> shows,
    List<People> people,
  }) {
    return SearchResultsState(
      moviePage: moviePage ?? this.moviePage,
      tvPage: tvPage ?? this.tvPage,
      peoplePage: peoplePage ?? this.peoplePage,
      moviesFull: moviesFull ?? this.moviesFull,
      tvFull: tvFull ?? this.tvFull,
      peopleFull: peopleFull ?? this.peopleFull,
      query: query ?? this.query,
      movieStatus: movieStatus ?? this.movieStatus,
      peopleStatus: peopleStatus ?? this.peopleStatus,
      tvStatus: tvStatus ?? this.tvStatus,
      movies: movies ?? this.movies,
      shows: shows ?? this.shows,
      people: people ?? this.people,
    );
  }
}
