import 'package:equatable/equatable.dart';
import 'package:tfgapp/src/models/tv.dart';

abstract class TVState extends Equatable {
  const TVState();

  @override
  List<Object> get props => [];
}

class TVLoading extends TVState {}

class TVLoaded extends TVState {
  final List<TV> tvList;
  const TVLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TVError extends TVState {}
