import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:noticeboard_app/methods/zefyr_methods.dart';
import 'package:noticeboard_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  void _saveDocument(BuildContext context, String uid) async {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly

    final contents = jsonEncode(_controller.document);

 //pretty print s

    var object = json.decode(contents);
    var prettyString = JsonEncoder.withIndent('  ').convert(object);

    print(prettyString);
    // And show a snack bar on success.
    await DatabaseService().addNoticeData(contents, uid);

    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));

  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    String _uid = Provider.of<String>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Editor page"),
      actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDocument(context, _uid),
            ),
          )
        ],
      ),

      body: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
          imageDelegate: MyAppZefyrImageDelegate(),
        ),
      ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }
}
