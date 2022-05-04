import 'package:flutter/material.dart';

class ArticleModel {
  final String title;
  final String thumbnail;
  final DateTime created_utc;
  final String selftext;
  late double lat;
  late double lon;

  ArticleModel({
    required this.thumbnail,
    required this.title,
    required this.created_utc,
    required this.selftext,
    required this.lat,
    required this.lon,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    debugPrint(DateTime.fromMillisecondsSinceEpoch(
            (json['created_utc']).toInt() * 1000)
        .toLocal()
        .toString());
    return ArticleModel(
        title: json['title'],
        thumbnail: (json['thumbnail'] != null &&
                json['thumbnail'] != 'self' &&
                json['thumbnail'] != 'default')
            ? json['thumbnail']
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU',
        created_utc: DateTime.fromMillisecondsSinceEpoch(
                (json['created_utc']).toInt() * 1000)
            .toLocal(),
        selftext:
            (json['selftext'] != '') ? json['selftext'] : 'text not available',
        lat: 12.34,
        lon: 12.342);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'created_utc': created_utc,
      };
}
// (json['thumbnail'] != null && json['thumbnail'] != 'self') ? json['thumbnail'] : "https://......";