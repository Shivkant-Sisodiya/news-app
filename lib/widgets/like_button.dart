import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final Key key;

  const LikeButton({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButtonStf(key: key);
  }
}

class LikeButtonStf extends StatefulWidget {
  final Key key;

  const LikeButtonStf({required this.key}) : super(key: key);

  @override
  State<LikeButtonStf> createState() => _LikeButtonStfState();
}

class _LikeButtonStfState extends State<LikeButtonStf> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return FavoriteButton(
      key: widget.key,
      valueChanged: (val) {
        {
          isLike = val;
        }
      },
      isFavorite: isLike,
      iconSize: 20,
    );
  }
}
