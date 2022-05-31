import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_event.dart';
import 'package:tfgapp/src/bloc/moviebloc/tv_bloc_state.dart';

import 'package:tfgapp/src/models/tv.dart';
import 'package:tfgapp/src/service/API-User-Service.dart';

class RecommendationUserBlocTV extends Bloc<TVEvent, TVState> {
  RecommendationUserBlocTV() : super(TVLoading());

  @override
  Stream<TVState> mapEventToState(TVEvent event) async* {
    if (event is TVEventStarted) {
      yield* _mapTVEventStateToState(event.tvId, event.query);
    }
  }

  Stream<TVState> _mapTVEventStateToState(int tvId, String query) async* {
    final service = APIUserService();
    yield TVLoading();
    try {
      List<TV> tvList;
      if (tvId == 0) {
        tvList = await service.getRecommendationsUserTV();
      } else {}

      yield TVLoaded(tvList);
    } on Exception catch (e) {
      print(e);
      yield TVError();
    }
  }
}
