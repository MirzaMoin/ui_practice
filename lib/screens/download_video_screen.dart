import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

class DownloadVideoScreen extends StatefulWidget {
  @override
  _DownloadVideoScreenState createState() => new _DownloadVideoScreenState();
}

class _DownloadVideoScreenState extends State<DownloadVideoScreen> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    downloadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            /*   InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://mega.nz/file/uoJBiADK#5c8nKB6xkqmfGJc_zWzkUsJaacbpkx5w_BANa05pbys")),
              onWebViewCreated: (InAppWebViewController controller) {},
              onConsoleMessage: (InAppWebViewController controller,
                  ConsoleMessage consoleMessage) {
                print("console message: ${consoleMessage.message}");
              },
            ),*/
            Container()
          ],
        ),
      ),
    );
  }

  String progress = "";
  Future<void> downloadFile() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir!.absolute.path;

    File file = File('$appDocPath/videos/test.txt');
    await file.create(recursive: true);
    var dio = Dio();

    final response = await dio.get(
      'https://mega.nz/embed/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k',
      onReceiveProgress: (rcv, total) {
        // print(
        //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
          print("Total Downloaded : $progress");
        });

        if (progress == '100') {
          setState(() {
            print("Downloaded");
          });
        } else if (double.parse(progress) < 100) {}
      },
    ).whenComplete(() => print("Download Completed"));

    /* final response = await dio.download(
      'https://mega.nz/embed/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k',
      "$appDocPath/videos/video.html",
      onReceiveProgress: (rcv, total) {
        // print(
        //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
          print("Total Downloaded : $progress");
        });

        if (progress == '100') {
          setState(() {
            print("Downloaded");
          });
        } else if (double.parse(progress) < 100) {}
      },
    );*/
    log("Response From API: ${response.data}");
  }

  Future<File> _createLevelFile() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir!.absolute.path;
    File file = File('$appDocPath/levels/level101.json');
    return await file.create(recursive: true);
  }
}
