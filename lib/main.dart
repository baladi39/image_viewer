import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/core/gandalf.dart';

import 'home/home_view.dart';

void main(List<String> arg) {
  if (arg.isNotEmpty) {
    Gandalf.filePath = arg.first;
  }

  runApp(const App());

  doWhenWindowReady(() {
    const initialSize = Size(600, 1000);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Image Viewer';
    appWindow.show();
  });
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
