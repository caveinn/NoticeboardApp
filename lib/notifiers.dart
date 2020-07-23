import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'models/user.dart';
import 'services/database.dart';

class NotificationModel extends ChangeNotifier {
  String _notificationTitle = '';
  String _notificationFile = '';
  String _notificationCloudPath = '';

  void setAll(
      {String notificationTitle,
      String notificationFile,
      String notificationCloudPath}) {
    _notificationTitle = notificationTitle;
    _notificationFile = notificationFile;
    _notificationCloudPath = notificationCloudPath;
  }

  void setTitle(String title) {
    _notificationTitle = title;
    notifyListeners();
  }

  void setFile(String title) {
    _notificationFile = title;
    notifyListeners();
  }

  void setCloudPath(String title) {
    _notificationCloudPath = title;
    notifyListeners();
  }

  Future addFile(User user) async {
    final file = File(_notificationFile);
    final bytes = file.readAsBytesSync();
    final pdf = base64Encode(bytes);
    print('uploading \n\n\n\n\n\n');

    var response = await http.post(
        'https://api.cloudinary.com/v1_1/${DotEnv().env['cloud_name']}/raw/upload',
        body: {
          "file": "data:raw;base64,$pdf",
          "upload_preset": DotEnv().env['upload_preset'],
        });
    var uploadedUrl = json.decode(response.body)['url'];
    var getPdf = await http.get(uploadedUrl);
    final directory = await getApplicationDocumentsDirectory();
    final path2 = directory.path;
    File file2 = new File(path2 + '/sample2.pdf');
    print(path2 + '/sample2.pdf');
    await file2.writeAsBytes(getPdf.bodyBytes);
    print(getPdf.bodyBytes);
    print('printed some stuff \n\n\n\n\n\n\n');

    await DatabaseService()
        .addNoticeData(uploadedUrl, user.id, _notificationTitle);
    notifyListeners();
  }

Future saveFileFromCloud() async {
   var cloudPdf = await http.get(_notificationCloudPath);
   final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    _notificationFile = path + '/' +_notificationTitle + '.pdf';
    File file = new File(_notificationFile);
    await file.writeAsBytes(cloudPdf.bodyBytes);
    print('saved '+ _notificationFile+'\n\n\n\n\n\n\n\n');

 }

  String get notificationTitle {
    return _notificationTitle;
  }

  String get notificationFile {
    return _notificationFile;
  }

  String get notificationPath {
    return _notificationCloudPath;
  }
}
