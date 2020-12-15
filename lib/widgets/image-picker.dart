import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerEdit extends StatelessWidget {
  final picker = ImagePicker();
  final double size;
  final onChange;

  final File file;
  final String url;
  final String tag;

  ImagePickerEdit({@required this.onChange, @required this.size, this.file, this.url, this.tag});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: pickImage,
        child: tag != null ? Hero(tag: tag, child: rect(buildImage())) : rect(buildImage())
    );
  }

  Widget rect(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: child,
    );
  }

  Widget buildImage() {
    if (file != null) {
      return Image.file(file, width: size, height: size);
    }

    if (url != null) {
      return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover, width: size, height: size);
    }

    return Container(width: size, height: size, color: Colors.red);
  }

  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      onChange(file);
    }
  }
}
