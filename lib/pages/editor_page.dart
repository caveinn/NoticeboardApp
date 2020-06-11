import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({
    Key key,
  }) : super(key: key);

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final pdfPath = arguments['pdfPath'];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,

      body: PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog   (
                        title: Text('Alert'),
                        content: Text('Sample'),
                      );
                    }
                    );
              },
            ),
          ],
        ),
          path:'/data/user/0/com.caveinn.noticeboard/app_flutter/sample2.pdf'),
          // pdfPath
    );
  }
}
