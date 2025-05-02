import 'package:flutter/material.dart';
import 'package:testflutter/views/Player/myCustomControls.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:testflutter/color.dart';

class VideoPlayerPage extends StatefulWidget {
  final Map<String, String> videoUrls;
  final String title;

  const VideoPlayerPage({
    super.key,
    required this.videoUrls,
    required this.title,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late String _currentQuality;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _currentQuality = widget.videoUrls.keys.first;
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    final url = widget.videoUrls[_currentQuality]!;
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.cyanAccent,
        handleColor: Colors.cyan,
        backgroundColor: primaryGrey,
        bufferedColor: primaryWhite,
      ),
    );

    setState(() {});
  }

  Future<void> changeQuality(String quality) async {
    setState(() {
      _currentQuality = quality;
    });

    await _videoPlayerController?.pause();
    await _chewieController?.pause();

    await _videoPlayerController?.dispose();
    _chewieController?.dispose();

    await initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          DropdownButton<String>(
            dropdownColor: primaryBlack,
            value: _currentQuality,
            underline: SizedBox(),
            icon: Icon(Icons.settings, color: Colors.white),
            items:
                widget.videoUrls.keys.map((quality) {
                  return DropdownMenuItem(
                    value: quality,
                    child: Text(
                      quality,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
            onChanged: (newQuality) {
              if (newQuality != null && newQuality != _currentQuality) {
                changeQuality(newQuality);
              }
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body:
          _chewieController != null &&
                  _videoPlayerController!.value.isInitialized
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chewie(controller: _chewieController!),
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
