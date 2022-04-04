import 'package:equatable/equatable.dart';

abstract class TVEvent extends Equatable {
  const TVEvent();
}

class TVEventStarted extends TVEvent {
  final int tvId;
  final String query;

  const TVEventStarted(this.tvId, this.query);

  @override
  List<Object> get props => [];
}
