import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:tfgapp/src/models/movie.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';

class RecommendationUserBloc extends Bloc<MovieEvent, MovieState> {
  RecommendationUserBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = APIUserService();
    yield MovieLoading();
    try {
      List<Movie> movieList;
      if (movieId == 0) {
        movieList = await service.getRecommendationsUser();
      } else {}

      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      print(e);
      yield MovieError();
    }
  }
}
