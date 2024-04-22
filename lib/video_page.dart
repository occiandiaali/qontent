import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  // String uri = '';

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _openModal() {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: 500,
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit video',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0),
                  ),
                  const Divider(color: Colors.blueGrey,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.ac_unit, size: 46, color: Colors.deepPurple),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.access_alarm_outlined, size: 46, color: Colors.deepPurple),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.accessibility_new_outlined, size: 46, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.blueGrey,),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'))
                ],
              ),
            ),
          );
        }
    );
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
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
              onPressed: () => _openModal()
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white, size: 32),
            onPressed: () => _openModal()
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined, color: Colors.white,size: 32),
            onPressed: () {
              if (kDebugMode) {
                print('do something with file...');
              }
            },
          ),
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
