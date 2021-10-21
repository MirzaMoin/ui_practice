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
  final url;
  PlayerScreen(this.url);

  @override
  _PlayerScreenState createState() => new _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final GlobalKey webViewKey = GlobalKey();
  bool isLoaded = false;

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
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "${widget.url}")),
                onWebViewCreated: (InAppWebViewController controller) async {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) async {
                  if (progress == 100) {
                    setState(() {
                      isLoaded = true;
                    });
                    print("Loaded : $progress");
                    String overrideJs = await jsInjectionString(
                        context, 'assets/css/custom.css');

                    _webViewController.evaluateJavascript(source: overrideJs);
                  }
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
