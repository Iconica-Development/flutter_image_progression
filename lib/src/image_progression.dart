import 'dart:math';

import 'package:flutter/material.dart';

import 'models/progress_image.dart';

class ImageProgression extends StatelessWidget {
  const ImageProgression({
    required this.progress,
    required this.images,
    required this.stops,
    super.key,
  });

  final double progress;

  final List<double> stops;

  final List<ImageProgress> images;

  @override
  Widget build(BuildContext context) {
    // search through the stops until progress < stop

    var amountOfDisplayedImages = _getAmountOfDisplayedImages();
    return Stack(
      children: [
        for (var i = 0; i < amountOfDisplayedImages; i++) ...[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: images[i].image,
              fit: BoxFit.cover,
            ),
          ),
        ],
        if (stops[min(max(amountOfDisplayedImages - 1, 0), images.length - 1)] <
            progress) ...[
          // show partial percentage of the image coming from the bottom
          Align(
            alignment: Alignment.bottomCenter,
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
        ]
      ],
    );
  }

  double _getPartialImagePercentage() {
    return progress -
        stops[
            min(max(_getAmountOfDisplayedImages() - 1, 0), images.length - 1)];
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
