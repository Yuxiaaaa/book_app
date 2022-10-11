import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.network(widget.imageUrl),
          BackButton(),
        ],
      )),
    );
  }
}