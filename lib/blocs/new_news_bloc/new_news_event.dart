part of 'new_news_bloc.dart';

abstract class NewNewsEvents extends Equatable {
  const NewNewsEvents();

  @override
  List<Object> get props => [];
}

class StartEvent extends NewNewsEvents {}
