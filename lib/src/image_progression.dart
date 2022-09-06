import 'dart:math';

import 'package:flutter/material.dart';

import 'models/progress_image.dart';

class ImageProgression extends StatelessWidget {
  /// Creates a widget that displays a progression of images
  /// based on the [progress] value.
  /// The [images] are displayed in the order of the [stops].
  /// The [stops] are the values between 0.0 and 1.0 that indicate
  /// when the next image should be displayed.
  const ImageProgression({
    required this.progress,
    required this.images,
    required this.stops,
    super.key,
  }) : assert(
          images.length == stops.length,
          'The length of images and stops should be the same',
        );

  /// The progress of the images, should be between 0.0 and 1.0
  final double progress;

  /// The list of stops to indicate when the images should be displayed
  /// The stops should be between 0.0 and 1.0
  /// The stops should be in ascending order
  /// The stops should the same length as the images
  final List<double> stops;

  /// The list of images to be displayed
  final List<ImageProgress> images;

  @override
  Widget build(BuildContext context) {
    // TODO(freek): add support for depth system
    var amountOfDisplayedImages = _getAmountOfDisplayedImages();
    return Stack(
      children: [
        for (var i = 0; i < amountOfDisplayedImages; i++) ...[
          Padding(
            padding: EdgeInsets.only(
              bottom: images[i].offset.dy,
              left: images[i].offset.dx,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: images[i].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        if (_isPartialImage(amountOfDisplayedImages)) ...[
          // show partial percentage of the image coming from the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: images[amountOfDisplayedImages].offset.dy,
                left: images[amountOfDisplayedImages].offset.dx,
              ),
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: _getPartialImagePercentage(),
                  child: Image(
                    image: images[amountOfDisplayedImages].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

  /// Checks if there is a partial image displayed
  bool _isPartialImage(int amountOfDisplayedImages) {
    return stops[min(max(amountOfDisplayedImages - 1, 0), images.length - 1)] <
        progress;
  }

  double _getPartialImagePercentage() {
    var upperbound =
        stops[min(max(_getAmountOfDisplayedImages(), 0), images.length - 1)];
    var lowerbound = stops[
        min(max(_getAmountOfDisplayedImages() - 1, 0), images.length - 1)];
    return (progress - lowerbound) / (upperbound - lowerbound);
  }

  int _getAmountOfDisplayedImages() {
    var amountOfDisplayedImages = 0;
    for (var i = 0; i < stops.length; i++) {
      if (progress <= stops[i]) {
        amountOfDisplayedImages = progress == stops[i] ? i + 1 : i;
        break;
      }
    }
    return amountOfDisplayedImages;
  }
}
