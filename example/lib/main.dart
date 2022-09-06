import 'package:flutter/material.dart';
import 'package:flutter_image_progression/flutter_image_progression.dart';

void main() {
  runApp(const MaterialApp(home: ImageProgressionDemo()));
}

class ImageProgressionDemo extends StatefulWidget {
  const ImageProgressionDemo({Key? key}) : super(key: key);

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
                  images: [
                    const ImageProgress(
                      image: AssetImage('assets/container_leeg.png'),
                    ),
                    const ImageProgress(
                      image: AssetImage('assets/container_vol.png'),
                    ),
                    ImageProgress(
                      image: const AssetImage(
                        'assets/Vuilniszakken.png',
                      ),
                      offset: Offset(
                        0,
                        MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                  ],
                  stops: [0.0, 0.7, 1.0],
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
