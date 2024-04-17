import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
    this.imageFile,
    this.transformationController,
    this.turns,
    this.mouseCursor, {
    required this.onInteractionEnd,
    super.key,
  });

  final File imageFile;
  final TransformationController transformationController;
  final int turns;
  final MouseCursor mouseCursor;
  final Function(ScaleEndDetails) onInteractionEnd;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: turns,
      child: InteractiveViewer(
        transformationController: transformationController,
        scaleEnabled: true,
        panEnabled: true,
        minScale: 1,
        maxScale: 2.5,
        onInteractionEnd: onInteractionEnd,
        child: MouseRegion(
          cursor: mouseCursor,
          child: Image.file(
            imageFile,
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
