import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/widgets/like_button.dart';

class DetailNews extends StatefulWidget {
  final ArticleModel articleModel;
  final Key key;

  DetailNews({required this.key, required this.articleModel});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              children: [LikeButton(key: widget.key)],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Text(
                    widget.articleModel.title,
                    style: TextStyle(fontSize: 26),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellowAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(widget.articleModel.thumbnail),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(widget.articleModel.selftext),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
