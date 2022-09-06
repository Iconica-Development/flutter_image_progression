import 'package:flutter/material.dart';

class ImageProgress {
  const ImageProgress({
    required this.image,
    this.startImage = 0.0,
    this.endImage = 1.0,
  });

  final ImageProvider<Object> image;
  final double startImage;
  final double endImage;
}
