import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_bloc.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_events.dart';
import 'package:flutter_news_app/blocs/newsbloc/news_states.dart';
import 'package:flutter_news_app/blocs/search/search_bloc.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/settings/like_button.dart';

import 'package:flutter_news_app/views/details_news.dart';
import 'package:flutter_news_app/views/location_screen.dart';
import 'package:flutter_news_app/views/news_search.dart';
import 'package:flutter_news_app/views/setting_screen.dart';

class HotScreen extends StatefulWidget {
  @override
  _HotScreenState createState() => _HotScreenState();
}

class _HotScreenState extends State<HotScreen> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: height * 0.01,
            //       ),
            //       Container(
            //         margin: EdgeInsets.only(left: width * 0.03),
            //         child: Text(
            //           "Bloc News".toUpperCase(),
            //           style: TextStyle(
            //               fontSize: 22, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       SizedBox(
            //         height: height * 0.01,
            //       ),
            //       Container(
            //         height: 1,
            //         color: Colors.grey.withOpacity(0.7),
            //         width: width,
            //         margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            //       )
            //     ],
            //   ),
            // ),
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
                    return ListView.builder(
                        itemCount: _articleList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => LocationScreen(
                                  //   articleList: _articleList,
                                  // ),
                                  builder: (context) => DetailNews(
                                      key: Key('$index'),
                                      articleModel: _articleList[index]),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: Colors.grey,
                                        offset: Offset(0, 2),
                                        spreadRadius: 1)
                                  ]),
                              height: height * 0.15,
                              margin: EdgeInsets.only(
                                bottom: height * 0.01,
                                top: height * 0.01,
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.3,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          _articleList[index].thumbnail,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  Container(
                                    height: height * 0.15,
                                    width: width * 0.55,
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                    child: Column(
                                      children: [
                                        Text(
                                          _articleList[index].title,
                                          overflow: TextOverflow.clip,
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          _articleList[index]
                                              .created_utc
                                              .toString(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        LikeButton(
                                          key: Key('$index'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (state is NewsFilterState) {
                    List<ArticleModel> _articleList = [];
                    _articleList = state.filterArticleList;
                    return ListView.builder(
                        itemCount: _articleList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => LocationScreen(
                                  //   articleList: _articleList,
                                  // ),
                                  builder: (context) => DetailNews(
                                      key: Key('$index'),
                                      articleModel: _articleList[index]),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: Colors.grey,
                                        offset: Offset(0, 2),
                                        spreadRadius: 1)
                                  ]),
                              height: height * 0.15,
                              margin: EdgeInsets.only(
                                bottom: height * 0.01,
                                top: height * 0.01,
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.3,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          _articleList[index].thumbnail,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  Container(
                                    height: height * 0.15,
                                    width: width * 0.55,
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                    child: Column(
                                      children: [
                                        Text(
                                          _articleList[index].title,
                                          overflow: TextOverflow.clip,
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          _articleList[index]
                                              .created_utc
                                              .toString(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
