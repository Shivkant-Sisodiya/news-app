part of 'new_news_bloc.dart';

abstract class NewNewsStates extends Equatable {
  const NewNewsStates();

  @override
  List<Object> get props => [];
}

class NewNewsInitState extends NewNewsStates {}

class NewNewsLoadingState extends NewNewsStates {}

class NewNewsLoadedState extends NewNewsStates {
  final List<ArticleModel> articleList;
  NewNewsLoadedState({required this.articleList});
}

class NewNewsErrorState extends NewNewsStates {
  final String errorMessage;
  NewNewsErrorState({required this.errorMessage});
}
