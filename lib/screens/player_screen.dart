import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => new _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.dispose();
  }

  // Build the javascript injection string to override css
  Future<String> jsInjectionString(BuildContext context, String asset) async {
    print("Called");
    String cssOverride = await rootBundle.loadString(asset);
    log("CSS $cssOverride ");
    String modified = cssOverride.replaceFirst("videoname", "S1 Episode 1");
    return "const cssOverrideStyle = document.createElement('style');"
        "cssOverrideStyle.textContent = `$modified`;"
        "document.head.append(cssOverrideStyle);";
  }

  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        return true;
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://mega.nz/embed/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k!1a")),
                /*    initialData: InAppWebViewInitialData(data: """
<!doctype html>
<html lang="en">
      <head>
      <style>
      </style>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width,height=device-height user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
          <title>Flutter InAppBrowser</title>
      </head>
      <body style="height:100%;padding:0px;margin:0px">
          <iframe src="https://mega.nz/embed/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k!1a" width="100%" height="100%" style="position:absolute" frameborder="0" allow="autoplay; fullscreen"></iframe>
      </body>
</html>"""),*/
                onWebViewCreated: (InAppWebViewController controller) async {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) async {
                  if (progress == 100) {
                    print("Loaded : $progress");
                    String overrideJs = await jsInjectionString(
                        context, 'assets/css/custom.css');

                    _webViewController.evaluateJavascript(source: overrideJs);
                  }
                  setState(() {
                    print("Loaded : $progress");
                  });
                },
                onConsoleMessage: (InAppWebViewController controller,
                    ConsoleMessage consoleMessage) {
                  print("console message: ${consoleMessage.message}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
