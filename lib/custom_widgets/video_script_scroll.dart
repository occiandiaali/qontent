import 'package:flutter/material.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class VideoScriptScroll extends StatelessWidget {
  const VideoScriptScroll({super.key, required this.videoScript});

  final String videoScript;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 140,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
        child: ScrollLoopAutoScroll(
          scrollDirection: Axis.vertical,
          gap: 35,
          delay: const Duration(seconds: 10),
          child: Text(videoScript,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
