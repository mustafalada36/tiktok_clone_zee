import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoItem extends StatefulWidget {
  final String videoUrl;
  final String username;
  final String caption;

  const VideoItem({
    super.key,
    required this.videoUrl,
    required this.username,
    required this.caption,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoController,
            looping: true,
            autoPlay: true,
            showControls: false,
          );
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _chewieController != null
            ? Chewie(controller: _chewieController!)
            : const Center(child: CircularProgressIndicator()),
        Positioned(
          left: 16,
          bottom: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('@${widget.username}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(widget.caption, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
