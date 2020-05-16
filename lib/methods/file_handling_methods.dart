// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class Pdf {
//   Future<String> localPath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     print(directory.path);
//     return directory.path;
//   }
// }

import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Pdf {
  Future<String> getPdf() async{
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    return file.path;
  }
}
