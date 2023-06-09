import 'dart:io';

import 'package:status_saver/models/video_thumbnail.dart';
import 'package:status_saver/theme/colors.dart';
import 'package:status_saver/common.dart';
import 'package:status_saver/screens/video_view.dart';
import 'package:status_saver/services/get_video_thumbnail.dart';

class VideoTile extends StatelessWidget {
  final String videoPath;
  const VideoTile({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoThumbnail>(
      future: getVideoThumbnail(videoPath),
      builder: ((_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Card(
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VideoView(
                    videoPath: videoPath,
                    height: snapshot.data!.videoHeight,
                    width: snapshot.data!.videoWidth,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: videoPath,
                    child: Image.file(
                      File(snapshot.data!.path),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                    ),
                  ),
                  const Positioned.fill(
                      child: Center(
                          child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 55,
                    color: videoPlayIconColor,
                  )))
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
