import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_viewer/core/gandalf.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
    this.transformationController,
    this.turns,
    this.mouseCursor, {
    required this.onInteractionEnd,
    super.key,
  });

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
            File(Gandalf.filePath!),
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
