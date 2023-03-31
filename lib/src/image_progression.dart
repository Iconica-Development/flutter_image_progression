// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image_progression/src/models/progress_image.dart';

class ImageProgression extends StatelessWidget {
  /// Creates a widget that displays a progression of images
  /// based on the [progress] value.
  /// The [images] are displayed order but the depth of each image
  ///  can be customized.
  /// The [stops] are the values between 0.0 and 1.0 that indicate
  /// when the next image should be displayed.
  const ImageProgression({
    required this.progress,
    required this.images,
    required this.stops,
    super.key,
  })  : assert(
          images.length == stops.length,
          'The length of images and stops should be the same',
        ),
        assert(
          progress >= 0 && progress <= 1,
          'progress should be within 0 and 1.0',
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
    // TODO(freek): make temporary list of images in their render order
    var amountOfDisplayedImages = _getAmountOfDisplayedImages();
    int? currentProgressedImage;
    if (_isPartialImage(amountOfDisplayedImages)) {
      currentProgressedImage = amountOfDisplayedImages;
    }

    var imagesWithoutDepth = images
        .sublist(
          0,
          amountOfDisplayedImages +
              ((currentProgressedImage != null &&
                      images[currentProgressedImage].depth == null)
                  ? 1
                  : 0),
        )
        .where((image) => image.depth == null)
        .toList(growable: false);
    var imagesWithCustomDepth = images
        .sublist(
          0,
          amountOfDisplayedImages +
              ((currentProgressedImage != null &&
                      images[currentProgressedImage].depth != null)
                  ? 1
                  : 0),
        )
        .where((image) => image.depth != null)
        .toList(growable: false);
    return Stack(
      children: [
        for (var i = 0;
            i <
                amountOfDisplayedImages +
                    (currentProgressedImage == null ? 0 : 1);
            i++) ...[
          _buildImage(
            context,
            imagesWithCustomDepth.firstWhere(
              (element) => element.depth == i,
              orElse: () => imagesWithoutDepth[i -
                  (imagesWithCustomDepth
                      .where((element) => element.depth! <= i)
                      .length)],
            ),
            currentProgressedImage ==
                images.indexOf(
                  imagesWithCustomDepth.firstWhere(
                    (element) => element.depth == i,
                    orElse: () => imagesWithoutDepth[i -
                        (imagesWithCustomDepth
                            .where((element) => element.depth! <= i)
                            .length)],
                  ),
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildImage(
    BuildContext context,
    ImageProgress image,
    bool isPartialImage,
  ) {
    if (isPartialImage) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: image.offset.dy,
            left: image.offset.dx,
          ),
          child: ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: _getPartialImagePercentage(),
              child: Image(
                image: image.image,
                fit: BoxFit.cover,
                color: image.colorFilter,
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          bottom: image.offset.dy,
          left: image.offset.dx,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image(
            image: image.image,
            fit: BoxFit.cover,
            color: image.colorFilter,
            colorBlendMode: BlendMode.modulate,
          ),
        ),
      );
    }
  }

  /// Checks if there is a partial image displayed
  bool _isPartialImage(int amountOfDisplayedImages) {
    return stops[min(max(amountOfDisplayedImages - 1, 0), images.length - 1)] <
        progress;
  }

  // get the percentage of the image that should be displayed
  double _getPartialImagePercentage() {
    var partialImage = images[_getAmountOfDisplayedImages()];
    var upperbound =
        stops[min(max(_getAmountOfDisplayedImages(), 0), images.length - 1)];
    var lowerbound = stops[
        min(max(_getAmountOfDisplayedImages() - 1, 0), images.length - 1)];
    var division = (progress - lowerbound) / (upperbound - lowerbound);
    // now get the percentage of the image that should be displayed
    // give possible lower and upper image start
    var percentage = partialImage.startImage +
        division * (partialImage.endImage - partialImage.startImage);
    return percentage;
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
