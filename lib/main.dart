import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String pageTitle = 'PhotoAI FlutterWebView';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotoAI FlutterWebView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewPage(title: pageTitle),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewPlus(
        onWebViewCreated: (controller) {
          controller.loadUrl('assets/index.html');
        },
        // javascriptを有効化
        javascriptMode: JavascriptMode.unrestricted,
        // javascriptChannels: {
        //   JavascriptChannel(
        //       name: "flutterApp", // （３）
        //       onMessageReceived: (JavascriptMessage result) {
        //         ScaffoldMessenger.of(context).showSnackBar(// （４）
        //             SnackBar(content: Text(result.message)));
        //       })
        // }
      ),
    );
  }
}

//   /// HTMLファイルを読み込む処理（非同期）
//   Future _loadHtmlFromAssets() async {
//     //HTMLファイルを読み込んでHTML要素を文字列で返す
//     final fileText = await rootBundle.loadString('assets/index.html');
//     await _controller.loadUrl(Uri.dataFromString(fileText,
//             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//         .toString());
//   }
// }
