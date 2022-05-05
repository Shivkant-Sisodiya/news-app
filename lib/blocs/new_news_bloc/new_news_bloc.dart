import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/blocs/new_news_bloc/Repository/new_news_repository.dart';

part 'new_news_event.dart';
part 'new_news_state.dart';

class NewNewsBloc extends Bloc<NewNewsEvents, NewNewsStates> {
  NewNewsRepository newsRepositoty;
  NewNewsBloc(
      {required NewNewsStates initialState, required this.newsRepositoty})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewNewsStates> mapEventToState(NewNewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewNewsLoadingState();
        _articleList = await newsRepositoty.fetchNews();
        yield NewNewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewNewsErrorState(errorMessage: e.toString());
      }
    }
  }
}
