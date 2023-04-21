import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:status_saver/common.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String videoPath;
  const VideoView({super.key, required this.videoPath});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final ChewieController? _chewieController; 

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(File(widget.videoPath)),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 5/6,
      errorBuilder: (_, errorMessage) {
        return Text(errorMessage);
      }
      );
  }

  @override
  void dispose() {
    _chewieController!.pause();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(
        controller: _chewieController!,
      ),
    );
  }
}