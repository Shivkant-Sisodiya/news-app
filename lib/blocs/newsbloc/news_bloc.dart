import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/blocs/newsbloc/Repository/news_repository.dart';
import 'news_events.dart';
import 'news_states.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepositoty;
  NewsBloc({required NewsStates initialState, required this.newsRepositoty})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    List<ArticleModel> _articleList = [];
    List<ArticleModel> _filterList = [];
    _articleList = await newsRepositoty.fetchNews();

    if (event is StartEvent) {
      try {
        yield NewsLoadingState();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e.toString());
      }
    }
    if (event is FilterEvent) {
      try {
        yield NewsLoadingState();
        //_filterList = await newsRepositoty.fetchNews();
        _filterList = _articleList
          // .where((element) => DateTime.now()
          //     .subtract(Duration(days: 1))
          //     .isBefore(element.created_utc))
          // .toList();
          // .where((element) => DateTime.now()
          //     .subtract(Duration(hours: DateTime.now().hour))
          //     .isBefore(element.created_utc))
          // .toList();
          // ..sort(
          //     (element1, element2) => element1.title.compareTo(element2.title));
          ..sort((element1, element2) =>
              element1.created_utc.compareTo(element2.created_utc))
          ..reversed;

        yield NewsFilterState(filterArticleList: _filterList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e.toString());
      }
    }
  }
}
