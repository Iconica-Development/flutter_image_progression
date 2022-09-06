import 'package:flutter/material.dart';

class ImageProgress {
  /// Model for a single image in the progression
  /// With [startImage] and [endImage] you can specify which range of the image
  ///  is relevant for the progression
  const ImageProgress({
    required this.image,
    this.startImage = 0.0,
    this.endImage = 1.0,
    this.offset = Offset.zero,
    this.depth,
  });

  /// The image to be displayed
  final ImageProvider<Object> image;

  /// The percentage of the image that should be displayed from the start
  final double startImage;

  /// the percentage of the image that should be displayed from the end
  final double endImage;

  /// The offset of the image in the [ImageProgression] widget
  final Offset offset;

  /// Optional depth to indicate the order of the images
  final int? depth;
}
