import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_bloc.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_events.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_states.dart';
import 'package:flutter_news_app/blocs/search/search_bloc.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/widgets/custom_list.dart';
import 'package:flutter_news_app/blocs/geolocation/screen/location_screen.dart';
import 'package:flutter_news_app/widgets/news_search.dart';
import 'package:flutter_news_app/blocs/app_theme/screen/setting_screen.dart';

class HotScreen extends StatefulWidget {
  @override
  _HotScreenState createState() => _HotScreenState();
}

class _HotScreenState extends State<HotScreen> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Hot News'),
          centerTitle: false,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: SearchNews(
                        searchBloc: BlocProvider.of<SearchBloc>(context),
                      ));
                }),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
            ),
            Container(
              // margin: EdgeInsets.only(top: height * 0.08),
              child: BlocBuilder<NewsBloc, NewsStates>(
                builder: (BuildContext context, NewsStates state) {
                  if (state is NewsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is NewsLoadedState) {
                    List<ArticleModel> _articleList = [];
                    _articleList = state.articleList;
                    _articleList[1].lat = 26.0298602;
                    _articleList[1].lon = 79.4137783;
                    _articleList[2].lat = 26.0200774;
                    _articleList[2].lon = 79.4136100;
                    _articleList[3].lat = 26.0300638;
                    _articleList[3].lon = 79.4132379;
                    _articleList[4].lat = 26.0287862;
                    _articleList[4].lon = 79.4112504;
                    _articleList[5].lat = 26.0247220;
                    _articleList[5].lon = 79.4057840;
                    return IconButton(
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(articleList: _articleList),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
            ),
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('filter 1')),
                PopupMenuItem<int>(value: 1, child: Text('filter 2')),
              ],
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              // margin: EdgeInsets.only(top: height * 0.08),
              child: BlocBuilder<NewsBloc, NewsStates>(
                builder: (BuildContext context, NewsStates state) {
                  if (state is NewsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NewsLoadedState) {
                    List<ArticleModel> _articleList = [];
                    _articleList = state.articleList;
                    return CustomList(articleList: state.articleList);
                  } else if (state is NewsFilterState) {
                    List<ArticleModel> _articleList = [];
                    _articleList = state.filterArticleList;
                    return CustomList(articleList: state.filterArticleList);
                  } else if (state is NewsErrorState) {
                    String error = state.errorMessage;
                    return Center(child: Text(error));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  handleClick(int item) {
    switch (item) {
      case 0:
        {
          BlocProvider.of<NewsBloc>(context).add(FilterEvent());
          break;
        }

      case 1:
        BlocProvider.of<NewsBloc>(context).add(FilterEvent());
        break;
    }
  }
}
