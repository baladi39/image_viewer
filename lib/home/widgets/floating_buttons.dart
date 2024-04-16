import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
    required this.rotate,
    required this.zoomIn,
    required this.zoomOut,
    required this.resetImage,
    this.showResetImage = false,
    super.key,
  });

  final Function() rotate;
  final Function() zoomIn;
  final Function() zoomOut;
  final Function() resetImage;
  final bool showResetImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showResetImage)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: FloatingActionButton(
              onPressed: resetImage,
              child: const Icon(Icons.restore),
            ),
          ),
        FloatingActionButton(
          onPressed: rotate,
          child: const Icon(Icons.rotate_90_degrees_cw),
        ),
        floatingButtonSpacing(),
        FloatingActionButton(
          onPressed: zoomIn,
          child: const Icon(Icons.zoom_in),
        ),
        floatingButtonSpacing(),
        FloatingActionButton(
          onPressed: zoomOut,
          child: const Icon(Icons.zoom_out),
        ),
        floatingButtonSpacing(),
      ],
    );
  }

  floatingButtonSpacing() => const SizedBox(height: 24);
}
