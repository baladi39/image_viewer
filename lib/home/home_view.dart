import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/core/custom_app_bar.dart';
import 'package:image_viewer/core/gandalf.dart';
import 'package:image_viewer/home/home_helper.dart';

import 'widgets/error_image.dart';
import 'widgets/floating_buttons.dart';
import 'widgets/image_viewer.dart';
import 'widgets/pdf_viewer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TransformationController transformationController;
  late Matrix4 defaultMatrix;
  late double currentScale;
  late FileType fileType;
  late MouseCursor mouseCursor;
  int turns = 0;

  @override
  void initState() {
    fileType = getFileType(Gandalf.filePath);
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
      appBar: const CustomAppBar(),
      body: WindowBorder(
        color: Colors.transparent,
        child: fileType == FileType.invalid
            ? const ErrorImage()
            : fileType == FileType.image
                ? ImageViewer(
                    File(Gandalf.filePath!),
                    transformationController,
                    turns,
                    mouseCursor,
                    onInteractionEnd: (e) {
                      setState(() {
                        currentScale =
                            transformationController.value.storage.first;
                      });
                    },
                  )
                : PdfViewer(File(Gandalf.filePath!)),
      ),
      floatingActionButton: isFileTypeImage()
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

  bool isFileTypeImage() => fileType != FileType.invalid;
  bool showResetButton() => currentScale != 1 || turns != 0;
}
