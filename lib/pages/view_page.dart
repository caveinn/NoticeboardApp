import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:noticeboard_app/models/user.dart';
import 'package:provider/provider.dart';

import '../notifiers.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({
    Key key,
  }) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final edit = arguments['edit'];
    final notification = Provider.of<NotificationModel>(context);
    final user = Provider.of<User>(context);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    print(notification.notificationFile + '\n\n\n\n\n\n\n\n\n');

    return Scaffold(
      key: _scaffoldKey,

      body: loading
          ? Center(
              child: Text('Loading'),
            )
          : PDFViewerScaffold(
              appBar: AppBar(
                title: Text(notification.notificationTitle),
                actions: <Widget>[
                  edit && edit != null
                      ? IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            this.setState(() {
                              loading = true;
                            });

                            notification.addFile(user).then((event) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/notices_list');
                            });
                          },
                        )
                      : SizedBox.shrink(),
                ],
              ),
              path: notification.notificationFile),
      // pdfPath
    );
  }
}
