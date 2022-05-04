part of 'search_bloc.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  List<ArticleModel> searchNews;
  SearchLoaded({required this.searchNews});
  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
