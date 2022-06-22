// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  late WebViewPlusController _webViewPlusController;
  List<String> _urlList = [
    'assets/index.html',
    'https://www.yahoo.co.jp/',
    'https://qiita.com/'
  ];

  bool isLoading = true;

  final key = UniqueKey();

  // BottomNavigation 切り替えで動作
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _webViewPlusController.loadUrl(_urlList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Sample'),
      ),
      body: Stack(children: <Widget>[
        WebViewPlus(
          initialUrl: _urlList[_selectedIndex],
          key: key,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) {
            webViewController.loadUrl(_urlList[_selectedIndex]);
          },
          onPageStarted: (finish) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        // ページ読み込み中の時はIndicatorを出す
        isLoading ? Center(child: CircularProgressIndicator()) : Stack(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
