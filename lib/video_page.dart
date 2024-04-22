import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:supabase_teleprompter/video_edit_page.dart';
import 'package:video_player/video_player.dart';
import 'package:share_extend/share_extend.dart';
import 'package:video_editor/video_editor.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  const VideoPage({super.key, required this.filePath});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  // String text = '';
  // String subject = '';


  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _openModal() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          // return Center(
          //   child: Container(
          //     height: 500,
          //     color: Colors.black12,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       mainAxisSize: MainAxisSize.min,
          //       //  crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           'Edit video',
          //           style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0),
          //         ),
          //         const Divider(color: Colors.blueGrey,),
          //         const Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Icon(Icons.ac_unit, size: 46, color: Colors.deepPurple),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Icon(Icons.access_alarm_outlined, size: 46, color: Colors.deepPurple),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Icon(Icons.accessibility_new_outlined, size: 46, color: Colors.deepPurple),
          //             ),
          //           ],
          //         ),
          //         const Divider(color: Colors.blueGrey,),
          //         ElevatedButton(
          //             onPressed: () => Navigator.pop(context),
          //             child: const Text('Close'))
          //       ],
          //     ),
          //   ),
          // );
          return Center();

        }
    );
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  void _getUpgrade(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
              'Upgrade to Premium to save your videos.',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26, color: Colors.redAccent),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  _editVideo() async {
    if (widget.filePath.isNotEmpty) {
      File file = File(widget.filePath);
      final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => VideoEditor(file: file));
      if (!mounted) return;
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
              icon: const Icon(Icons.video_settings_outlined, color: Colors.white, size: 32,),
              onPressed: () => _editVideo()
          ),
          const SizedBox(width: 6,),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white, size: 32),
            onPressed: () => ShareExtend.share(widget.filePath, 'video')
          ),
          const SizedBox(width: 6),
          IconButton(
            icon: const Icon(Icons.save_outlined, color: Colors.white,size: 32),
            onPressed: () => _getUpgrade(context),
          ),
          const SizedBox(width: 12,)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        child: FutureBuilder(
            future: _initVideoPlayer(),
            builder: (context, state) {
              if (state.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return VideoPlayer(_videoPlayerController);
              }
            }),
       // onTap: () => _openModal(),
      ),
    );
  }
}
