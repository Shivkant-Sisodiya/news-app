import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/models/article_model.dart';

abstract class NewsStates extends Equatable {
  const NewsStates();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<ArticleModel> articleList;
  NewsLoadedState({required this.articleList});
}

class NewsErrorState extends NewsStates {
  final String errorMessage;
  NewsErrorState({required this.errorMessage});
}

class NewsFilterState extends NewsStates {
  final List<ArticleModel> filterArticleList;
  NewsFilterState({required this.filterArticleList});
}
