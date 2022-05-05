import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_news_app/blocs/search/search_bloc.dart';
import 'package:flutter_news_app/widgets/details_news.dart';

class SearchNews extends SearchDelegate<List> {
  SearchBloc searchBloc;
  late String queryString;

  SearchNews({required this.searchBloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    queryString = query;
    searchBloc.add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(
            child: Text('Failed To Load'),
          );
        }
        if (state is SearchLoaded) {
          if (state.searchNews.isEmpty) {
            return Center(
              child: Text('No Results'),
            );
          }
          return ListView.builder(
              itemCount: state.searchNews.length,
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
                            articleModel: state.searchNews[index]),
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
                                state.searchNews[index].thumbnail,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Container(
                          height: height * 0.15,
                          width: width * 0.55,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Text(
                            state.searchNews[index].title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        return Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
