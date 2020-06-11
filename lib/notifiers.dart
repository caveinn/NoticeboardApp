import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'models/user.dart';
import 'services/database.dart';

class NotificationModel extends ChangeNotifier{
  String _notificationTitle = '';
  String _notificationFile = '';
  String _notificationCloudPath = null;


  void setTitle(String title){
    _notificationTitle = title;
    notifyListeners();
  }

  void getFiles(){

  }

  void addFile(String path, User user) async {
    final file = File(path);
    final bytes = file.readAsBytesSync() ;
    final pdf = base64Encode(bytes);
    print('uploading \n\n\n\n\n\n');


    var response = await http.post('https://api.cloudinary.com/v1_1/${DotEnv().env['cloud_name']}/raw/upload',body: { "file": "data:raw;base64,$pdf", "upload_preset": DotEnv().env['upload_preset'],} );
    var uploadedUrl = json.decode(response.body)['url'];
    print('\n\n\n\n\n');
    var getPdf = await http.get(uploadedUrl);
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    final directory = await getApplicationDocumentsDirectory();
    final path2 = directory.path;
    File file2 = new File(path2+'/sample2.pdf');
    print(path2+'/sample2.pdf');
    await file2.writeAsBytes(getPdf.bodyBytes);
     print(getPdf.bodyBytes);
    print('printed some stuff \n\n\n\n\n\n\n');

   await DatabaseService().addNoticeData(uploadedUrl, user.id, 'Sample');
    notifyListeners();
  }

  String get notificationTitle {
    return _notificationTitle;
  }

}
