import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final List<String> videoUrls = [
    'https://www.youtube.com/watch?v=pxBQLFLei70',
    'https://www.youtube.com/watch?v=WPni755-Krg',
    'https://www.youtube.com/watch?v=pxBQLFLei70',
    'https://www.youtube.com/watch?v=WPni755-Krg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final videoUrl = videoUrls[index];
          return GestureDetector(
            onTap: () {
              navigateToWebView(context, videoUrl);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      getThumbnailUrl(videoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Video $index',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getThumbnailUrl(String videoUrl) {
    // Extract video ID from YouTube URL
    final videoId = videoUrl.split('=')[1];
    return 'https://i.ytimg.com/vi/$videoId/maxresdefault.jpg';
  }

  void navigateToWebView(BuildContext context, String videoUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewPlayer(videoUrl: videoUrl),
      ),
    );
  }
}

class WebViewPlayer extends StatelessWidget {
  final String videoUrl;

  const WebViewPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: WebView(
        initialUrl: videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
