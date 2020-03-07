import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';
import 'package:http/http.dart' as http;
 import 'package:path/path.dart' as p;


class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    // var bytes = utf8.encode("eager=w_400,h_300,c_pad|w_260,h_200,c_crop&public_id=sample_image&timestamp=1315060510abcd"); // data being hashed

    // var digest = sha1.convert(bytes);
    final bytes = file.readAsBytesSync() ;
    final image = base64Encode(bytes);

    // print("Digest as bytes: ${digest.bytes}");
    // print("Digest as hex string: $digest");
    print(image);
    final ext = p.extension(file.uri.toString()).substring(1);

    var response= await http.post('https://api.cloudinary.com/v1_1/${DotEnv().env['cloud_name']}/image/upload',body: { "file": "data:image/$ext;base64,$image", "upload_preset": DotEnv().env['upload_preset']} );
    print('\n\n\n\n\n\n\n\n\n');
    print(response.body);
    print(response.statusCode);
    print('\n\n  $image\n\n');
    print(p.extension(file.uri.toString()));

    print('\n\n\n\n\n\n\n\n\n');

    if (file == null) return null;
    // We simply return the absolute path to selected file.
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    final file = File.fromUri(Uri.parse(key));
    /// Create standard [FileImage] provider. If [key] was an HTTP link
    /// we could use [NetworkImage] instead.
    final image = FileImage(file);
    return Image(image: image);
  }

  @override
  ImageSource get cameraSource =>  ImageSource.camera;

  @override
  ImageSource get gallerySource =>  ImageSource.gallery;
}
