import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
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
