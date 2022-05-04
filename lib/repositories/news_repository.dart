import 'dart:convert';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<ArticleModel>> fetchNews({String? query}) async {
    var response =
        await http.get(Uri.parse("https://ww.reddit.com/r/Android/hot/.json"));
    // ?limit=5

    var data = jsonDecode(response.body);

    List<ArticleModel> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["data"]['children']) {
        ArticleModel _artcileModel = ArticleModel.fromJson(item['data']);
        _articleModelList.add(_artcileModel);
      }
      if (query != null) {
        _articleModelList = _articleModelList
            .where((element) =>
                element.title.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }
      return _articleModelList;
    } else {
      return _articleModelList; // empty list
    }
  }
}
