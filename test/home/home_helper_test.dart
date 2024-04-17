import 'package:flutter_test/flutter_test.dart';
import 'package:image_viewer/home/home_helper.dart';

void main() {
  String validImageFilePath =
      'C:\\Users\\rjbal\\OneDrive\\Documents\\Untitled-3.png';
  String validPdfFilePath = 'C:\\Users\\rjbal\\OneDrive\\Documents\\sample.pdf';
  String nonValidfilePath =
      'C:\\Users\\rjbal\\OneDrive\\Documents\\Untitled-300.png';

  group('File Path Validity -', () {
    testWidgets('Check if file exist if file path is null',
        (WidgetTester tester) async {
      var result = checkFileExist('');

      expect(result, false);
    });

    testWidgets('Check if file exist if file path is valid',
        (WidgetTester tester) async {
      var result = checkFileExist(validImageFilePath);

      expect(result, true);
    });

    testWidgets('Check if file exist if file path is not valid',
        (WidgetTester tester) async {
      var result = checkFileExist(nonValidfilePath);

      expect(result, false);
    });
  });

  group('Check extension retrieval -', () {
    test('Getting file invalid if file path is null', () {
      var result = getFileType('');

      expect(result, FileType.invalid);
    });

    test('Getting file invalid if file path does not exist', () {
      var result = getFileType(nonValidfilePath);

      expect(result, FileType.invalid);
    });

    test('Getting file ext pdf file path is leading to pdf', () {
      var result = getFileType(validPdfFilePath);

      expect(result, FileType.pdf);
    });

    test('Getting file ext image file path is leading to png', () {
      var result = getFileType(validImageFilePath);

      expect(result, FileType.image);
    });
  });
}
