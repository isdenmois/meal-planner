import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageWidget({this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return Container(color: Colors.red);

    return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover, width: width, height: height);
  }
}
