import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _webViewController;
  Color _appBarColor = Colors.blue; // Default color
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_webViewController != null && await _webViewController!.canGoBack()) {
          _webViewController!.goBack();
          return false; // Don't pop the screen
        } else {
          return true; // Pop the screen
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nexus Mobile'),
          backgroundColor: _appBarColor, // Use the dynamic color
          actions: [
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white, // Loader color
                  ),
                ),
              ),
          ],
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onPageStarted: (url) {
                setState(() {
                  _isLoading = true;
                  _errorMessage = ''; // Clear previous errors
                });
              },
              onPageFinished: (url) async {
                // Inject JavaScript to get the background color
                String bgColor = await _webViewController!.runJavascriptReturningResult(
                  "window.getComputedStyle(document.body, null).getPropertyValue('background-color');"
                );

                // Convert the JavaScript returned color to Flutter's Color
                setState(() {
                  _appBarColor = _convertCssColorToColor(bgColor);
                  _isLoading = false;
                });
              },
              onWebResourceError: (error) {
                setState(() {
                  _isLoading = false;
                  _errorMessage = 'Failed to load resource: ${error.description}';
                });
              },
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _convertCssColorToColor(String cssColor) {
    // Example: rgba(255, 255, 255, 1)
    final rgbaMatch = RegExp(r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([\d.]+))?\)').firstMatch(cssColor);
    if (rgbaMatch != null) {
      final r = int.parse(rgbaMatch.group(1)!);
      final g = int.parse(rgbaMatch.group(2)!);
      final b = int.parse(rgbaMatch.group(3)!);
      final a = rgbaMatch.group(4) != null ? double.parse(rgbaMatch.group(4)!) : 1.0;
      return Color.fromRGBO(r, g, b, a);
    }
    return Colors.blue; // Fallback color
  }
}
