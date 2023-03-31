// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_image_progression/flutter_image_progression.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ImageProgressionDemo(),
    ),
  );
}

class ImageProgressionDemo extends StatefulWidget {
  const ImageProgressionDemo({super.key});

  @override
  State<ImageProgressionDemo> createState() => _ImageProgressionDemoState();
}

class _ImageProgressionDemoState extends State<ImageProgressionDemo> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ImageProgression(
                  progress: _progress,
                  images: const [
                    ImageProgress(
                      image: AssetImage(
                        'assets/container_empty.png',
                      ),
                    ),
                    ImageProgress(
                      image: AssetImage(
                        'assets/container_filled.png',
                      ),
                      startImage: 0.1,
                      endImage: 0.8,
                    ),
                    ImageProgress(
                      image: AssetImage(
                        'assets/garbage_top.png',
                      ),
                      depth: 0,
                      startImage: 1.0,
                    ),
                    ImageProgress(
                      image: AssetImage(
                        'assets/garbage_side.png',
                      ),
                      depth: 1,
                      startImage: 1.0,
                    ),
                    ImageProgress(
                      image: AssetImage(
                        'assets/garbage_front.png',
                      ),
                      depth: 4,
                      startImage: 1.0,
                    ),
                  ],
                  stops: const [
                    0.0,
                    1 / 7 * 6,
                    1 / 7 * 6.3,
                    1 / 7 * 6.6,
                    1.0,
                  ],
                ),
              ),
            ),

            // vertical slider to change the progress
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.2,
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Slider(
                  thumbColor: const Color(
                    0xFFBBD10D,
                  ),
                  activeColor: const Color(
                    0xFFBBD10D,
                  ),
                  inactiveColor: const Color(0xFF9C9C9B),
                  value: _progress,
                  onChanged: (value) {
                    setState(() {
                      _progress = value;
                    });
                  },
                  min: 0.0,
                  max: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
