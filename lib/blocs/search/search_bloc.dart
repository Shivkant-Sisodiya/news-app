import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/blocs/newsbloc/Repository/news_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  NewsRepository searchRepository;
  SearchBloc({required this.searchRepository}) : super(SearchUninitialized());

  SearchState get initialState => SearchUninitialized();
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield SearchUninitialized();

      try {
        List<ArticleModel> searchNews =
            await searchRepository.fetchNews(query: event.query);
        yield SearchLoaded(searchNews: searchNews);
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
