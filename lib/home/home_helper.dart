import 'dart:io';

import 'package:image_viewer/core/gandalf.dart';

bool checkFileExist() {
  return File(Gandalf.filePath ?? '').existsSync();
}
