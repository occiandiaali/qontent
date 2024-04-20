import 'dart:async';

import 'package:flutter/material.dart';

class ScriptOverlay extends StatefulWidget {
  // const ScriptOverlay({super.key, required this.videoScript});
  //
  // final String videoScript;
  const ScriptOverlay({super.key});

  @override
  State<ScriptOverlay> createState() => _ScriptOverlayState();
}

class _ScriptOverlayState extends State<ScriptOverlay> {
  final ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;

  void _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDiff = maxExtent - _scrollController.offset;
    double durationDouble = distanceDiff / speedFactor;

    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);
  }

  _toggleScrolling() {
    setState(() {
      scroll = !scroll;
    });
    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(
          _scrollController.offset,
          duration: const Duration(seconds: 1),
          curve: Curves.linear);
    }
  }


  @override
  Widget build(BuildContext context) {
    String val = '''
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
bunch of text here bunch of text here
''';
    return Center(
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && scroll) {
            Timer(const Duration(seconds: 1), () => _scroll());
          }
          return true;
        },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 200,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                child: Text(
                  // widget.videoScript,
                  textAlign: TextAlign.center,
                  val,
                  maxLines: 500,
                  style: const TextStyle(color: Colors.white, fontSize: 34.0, fontWeight: FontWeight.bold),
                ),
              )

          )),
    );
  }
}
