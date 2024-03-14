import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/confirmation_alert/completion_confirmation.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final dynamic title;
  final dynamic videoUrl;
  final dynamic unitNumber;

  const CustomVideoPlayer(
      {super.key,
      required this.title,
      required this.videoUrl,
      required this.unitNumber});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _timer;
  Duration _progress = Duration.zero;

  @override
  void initState() {
    super.initState();
    String videoUrl = '${AppConfig.baseUrl}/${widget.videoUrl}';
    _controller = VideoPlayerController.network(videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _progress = _controller.value.position;
        });
      }
    });

    _initializeVideoPlayerFuture.then((_) {
      if (mounted) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            // Video ended, show alert
            CompletionConfirmation.completionConfirmationAlert(
                context, widget.unitNumber);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'PressStart2P',
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      ),
      body: Column(
        children: [
          // Video Player
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${_formatDuration(_progress)} / ${_formatDuration(_controller.value.duration)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Controls Box
          Container(
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 37, 97),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.seekTo(_controller.value.position -
                          const Duration(seconds: 5));
                    },
                    child: const Icon(
                      Icons.replay_5,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.seekTo(_controller.value.position +
                          const Duration(seconds: 5));
                    },
                    child: const Icon(
                      Icons.forward,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
  }
}
