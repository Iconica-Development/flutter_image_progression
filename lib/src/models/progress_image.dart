// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

@immutable
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
    this.colorFilter,
  });

  /// The image to be displayed
  final ImageProvider<Object> image;

  /// The percentage of the image that should be displayed from the start
  /// 0.1 means first 10% of the image will immediately be displayed
  final double startImage;

  /// the percentage of the image that should be displayed from the end
  /// 0.6 means the progression goes from start to 60% of the image
  final double endImage;

  /// The offset of the image in the [ImageProgression] widget
  /// offset is from the bottom left corner of the widget
  final Offset offset;

  /// Optional depth to indicate the order of the images
  /// The image with the highest depth will be displayed on top
  /// If no depth is specified, the order of the images will be the index
  final int? depth;

  /// Optional color to add opacity to the image
  final Color? colorFilter;

  ImageProgress copyWith({
    ImageProvider<Object>? image,
    double? startImage,
    double? endImage,
    Offset? offset,
    int? depth,
    Color? colorFilter,
  }) =>
      ImageProgress(
        image: image ?? this.image,
        startImage: startImage ?? this.startImage,
        endImage: endImage ?? this.endImage,
        offset: offset ?? this.offset,
        depth: depth ?? this.depth,
        colorFilter: colorFilter ?? this.colorFilter,
      );
}
