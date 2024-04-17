import 'dart:io';

bool checkFileExist(String? filePath) {
  return File(filePath ?? '').existsSync();
}

FileType getFileType(String? filePath) {
  if (checkFileExist(filePath)) {
    var ext = filePath!.split('.').last;
    if (ext == 'pdf') {
      return FileType.pdf;
    } else if (supportedImages.contains(ext)) {
      return FileType.image;
    }
  }

  return FileType.invalid;
}

var supportedImages = [
  'png',
  'jpg',
];

enum FileType {
  pdf,
  image,
  invalid,
}
