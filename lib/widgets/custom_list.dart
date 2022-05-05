import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/widgets/details_news.dart';

import 'like_button.dart';

class CustomList extends StatefulWidget {
  List<ArticleModel> articleList = [];

  CustomList({Key? key, required this.articleList}) : super(key: key);

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: widget.articleList.length,
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
                      articleModel: widget.articleList[index]),
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
                          widget.articleList[index].thumbnail,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Container(
                    height: height * 0.15,
                    width: width * 0.55,
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Column(
                      children: [
                        Text(
                          widget.articleList[index].title,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Created at " +
                              widget.articleList[index].created_utc.toString(),
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
  }
}
