import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  static const String route = '/photo_view_screen';
  final ImageProvider imageProvider;

  const PhotoViewScreen(this.imageProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider,
    );
  }

  static void open(BuildContext context, ImageProvider imageProvider) =>
      Navigator.pushNamed(context, route, arguments: imageProvider);
}
