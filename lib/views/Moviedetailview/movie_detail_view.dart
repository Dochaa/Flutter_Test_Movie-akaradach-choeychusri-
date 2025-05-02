// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testflutter/views/Player/videoPlayerPage.dart';
import 'package:testflutter/color.dart';
import 'package:testflutter/models/movie_model.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MovieDetailView extends StatefulWidget {
  final MovieModel movie;
  const MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late String _currentQuality;

  @override
  void initState() {
    super.initState();
    _currentQuality = widget.movie.video.keys.first;
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    final url = widget.movie.video[_currentQuality]!;
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.cyanAccent,
        handleColor: Colors.cyan,
        backgroundColor: primaryGrey,
        bufferedColor: primaryWhite,
      ),
      aspectRatio: _videoPlayerController.value.aspectRatio,
      showControls: true,
    );

    setState(() {});
  }

  Future<void> _changeQuality(String quality) async {
    if (_currentQuality == quality) return;

    // 🔸 ซ่อนวิดีโอก่อนชั่วคราว
    setState(() {
      _chewieController = null;
    });

    _currentQuality = quality;

    await _videoPlayerController.pause();
    await _chewieController?.pause();
    await _videoPlayerController.dispose();
    _chewieController?.dispose();

    final url = widget.movie.video[_currentQuality]!;
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController.initialize();

    final newChewie = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.cyanAccent,
        handleColor: Colors.cyan,
        backgroundColor: primaryGrey,
        bufferedColor: primaryWhite,
      ),
      aspectRatio: _videoPlayerController.value.aspectRatio,
      showControls: true,
    );

    // ✅ ค่อยอัปเดตหลังสร้าง controller ใหม่เสร็จ
    setState(() {
      _chewieController = newChewie;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: primarybackground,
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            color: Colors.black,
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'Quality',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  ...widget.movie.video.keys.map(
                    (quality) => PopupMenuItem<String>(
                      value: quality,
                      child: Row(
                        children: [
                          if (quality == _currentQuality)
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.cyanAccent,
                            ),
                          if (quality != _currentQuality)
                            const SizedBox(width: 16),
                          const SizedBox(width: 8),
                          Text(
                            quality,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
            onSelected: (selected) {
              _changeQuality(selected);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  (_chewieController != null &&
                          _chewieController!
                              .videoPlayerController
                              .value
                              .isInitialized)
                      ? SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Chewie(controller: _chewieController!),
                      )
                      : Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.fullLine,
              style: const TextStyle(color: primaryGrey, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _infoRow(Icons.calendar_month, 'Year', movie.year.toString()),
            _infoRow(Icons.person, 'Director', movie.director),
            _infoRow(Icons.account_box, 'Character', movie.character),
            _infoRow(Icons.access_time, 'Timecode', movie.timestamp),
            _infoRow(Icons.timer, 'Duration', movie.movieDuration),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: primaryGrey, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              color: primaryGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: primaryGrey)),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:testflutter/views/Player/videoPlayerPage.dart';
// import 'package:testflutter/color.dart';
// import 'package:testflutter/models/movie_model.dart';


// class MovieDetailView extends StatelessWidget {
//   final MovieModel movie;
//   const MovieDetailView({super.key, required this.movie});

//   @override
//   Widget build(BuildContext context) {
//     final videoOptions = movie.video.entries.toList(); // e.g., [MapEntry("1080p", url), ...]

//     return Scaffold(
//       backgroundColor: primarybackground,
//       appBar: AppBar(
//         title: Text(movie.title),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 movie.poster,
//                 width: double.infinity,
//                 height: 250,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(movie.fullLine, style: const TextStyle(color: primaryGrey, fontSize: 16)),
//             const SizedBox(height: 12),
//             _infoRow(Icons.calendar_month, 'Year', movie.year.toString()),
//             _infoRow(Icons.person, 'Director', movie.director),
//             _infoRow(Icons.account_box, 'Character', movie.character),
//             _infoRow(Icons.access_time, 'Timecode', movie.timestamp),
//             _infoRow(Icons.timer, 'Duration', movie.movieDuration),
//             const SizedBox(height: 24),
//             // Text('Watch Video', style: TextStyle(color: primaryBlue, fontSize: 18)),
//             // const SizedBox(height: 12),
//             // ...videoOptions.map((entry) => Padding(
//             //       padding: const EdgeInsets.symmetric(vertical: 4),
//             //       child: ElevatedButton.icon(
//             //         style: ElevatedButton.styleFrom(backgroundColor: primaryBlue),
//             //         onPressed: () {
//             //           Get.to(() => VideoPlayerPage(videoUrls: movie.video, title: movie.title,));
//             //         },
//             //         icon: const Icon(Icons.play_circle, color: Colors.black),
//             //         label: Text('Play ${entry.key}', style: const TextStyle(color: Colors.black)),
//             //       ),
//             //     )),
//             // const SizedBox(height: 16),
//             // ElevatedButton.icon(
//             //   onPressed: () => Get.to(() => VideoPlayerPage(videoUrls: movie.video,title: movie.title,)),
//             //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white12),
//             //   icon: const Icon(Icons.audiotrack),
//             //   label: const Text('Play Audio'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Icon(icon, color: primaryGrey, size: 20),
//           const SizedBox(width: 8),
//           Text('$label: ', style: const TextStyle(color: primaryGrey, fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value, style: const TextStyle(color: primaryGrey))),
//         ],
//       ),
//     );
//   }
// }
