import 'package:flutter/material.dart';

class NotificationModel extends ChangeNotifier{
  String _notificationTitle = '';
  String _notificationFile = '';
  String _notificationCloudPath = null;


  void setTitle(String title){
    _notificationTitle = title;
    notifyListeners();
  }

  void addFile(String path){
    
  }






  String get title{
    return _notificationTitle;
  }

}
