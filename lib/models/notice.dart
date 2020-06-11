import 'package:noticeboard_app/models/user.dart';

class Notice{
  String title;
  String url;
  String userId;
  User user;
  Notice(this.title, this.url, this.user){
    this.userId = this.user.id;
  }
}
