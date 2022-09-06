import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ImageProgressionDemo()));
}

class ImageProgressionDemo extends StatelessWidget {
  const ImageProgressionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('ImageProgressionDemo'));
  }
}
