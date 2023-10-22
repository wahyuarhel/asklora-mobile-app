import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<PlatformFile> decodeBase64ToPlatformFile(String base64String) async {
  final decodedBytes =
      base64Decode(base64String.replaceAll('data:image/png;base64,', ''));
  final directory = await getTemporaryDirectory();
  String fileName = 'temp_file_${DateTime.now().millisecondsSinceEpoch}.png';
  var fileImg = File('${directory.path}/$fileName')
    ..writeAsBytesSync(List.from(decodedBytes));
  return PlatformFile(name: fileName, size: 0, path: fileImg.path);
}

Future<void> openUrl(String url,
    {LaunchMode mode = LaunchMode.platformDefault}) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: mode);
  } else {
    throw Exception('Could not launch $url');
  }
}

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
