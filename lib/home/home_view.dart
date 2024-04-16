import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/home/home_helper.dart';

import 'widgets/custom_title_bar.dart';
import 'widgets/error_image.dart';
import 'widgets/floating_buttons.dart';
import 'widgets/image_viewer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TransformationController transformationController;
  late Matrix4 defaultMatrix;
  late double currentScale;
  late bool isFileExist;
  late MouseCursor mouseCursor;
  int turns = 0;

  @override
  void initState() {
    isFileExist = checkFileExist();
    transformationController = TransformationController();
    defaultMatrix = transformationController.value;
    super.initState();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentScale = transformationController.value.storage.first;
    mouseCursor =
        showResetButton() ? SystemMouseCursors.move : MouseCursor.defer;

    return Scaffold(
      appBar: const CustomTitleBar(),
      body: WindowBorder(
        color: Colors.transparent,
        child: isFileExist
            ? ImageViewer(
                transformationController,
                turns,
                mouseCursor,
                onInteractionEnd: (e) {
                  setState(() {
                    currentScale = transformationController.value.storage.first;
                  });
                },
              )
            : const ErrorImage(),
      ),
      floatingActionButton: isFileExist
          ? FloatingButtons(
              rotate: () {
                setState(() {
                  turns == 3 ? turns = 0 : turns++;
                });
              },
              zoomIn: () {
                if (currentScale < 2) {
                  transformationController.value = Matrix4.identity()
                    ..scale(currentScale + 0.1);
                  setState(() {
                    currentScale = transformationController.value.storage.first;
                  });
                }
              },
              zoomOut: () {
                if (currentScale > 1) {
                  transformationController.value = Matrix4.identity()
                    ..scale(currentScale - 0.1);
                  setState(() {
                    currentScale = transformationController.value.storage.first;
                  });
                }
              },
              showResetImage: showResetButton(),
              resetImage: () {
                setState(() {
                  turns = 0;
                  transformationController.value = defaultMatrix;
                });
              },
            )
          : null,
    );
  }

  bool showResetButton() => currentScale != 1 || turns != 0;
}
