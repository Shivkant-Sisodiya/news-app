import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/new_news_bloc/new_news_bloc.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/widgets/details_news.dart';
import 'package:flutter_news_app/blocs/geolocation/screen/location_screen.dart';
import 'package:flutter_news_app/blocs/app_theme/screen/setting_screen.dart';
import 'package:flutter_news_app/widgets/custom_list.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
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
              child: BlocBuilder<NewNewsBloc, NewNewsStates>(
                builder: (BuildContext context, NewNewsStates state) {
                  if (state is NewNewsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is NewNewsLoadedState) {
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
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              // margin: EdgeInsets.only(top: height * 0.08),
              child: BlocBuilder<NewNewsBloc, NewNewsStates>(
                builder: (BuildContext context, NewNewsStates state) {
                  if (state is NewNewsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NewNewsLoadedState) {
                    return CustomList(articleList: state.articleList);
                  } else if (state is NewNewsErrorState) {
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
}
