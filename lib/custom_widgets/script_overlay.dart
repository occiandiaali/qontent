import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScriptOverlay extends StatefulWidget {
   const ScriptOverlay({super.key, required this.videoScript});
   final String videoScript;

  @override
  State<ScriptOverlay> createState() => _ScriptOverlayState();
}

class _ScriptOverlayState extends State<ScriptOverlay> {
  final _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 30;

  _scroll() {
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
    return Center(
      child: NotificationListener(
        onNotification: (notif) {
          if (notif is ScrollEndNotification && scroll) {
            Timer(const Duration(seconds: 1), () => _scroll());
          }
          return true;
        },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4.0),
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
              child: GestureDetector(
                onTap: () => _toggleScrolling(),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black.withOpacity(0.4)),
                  child: Text(
                    """
                  
                  
                  ${widget.videoScript}
                    """,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.fade,
                    // maxLines: 500,
                    style: const TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              offset: Offset(2.0, 2.0)
                          )
                        ],
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )

          )),
    );
  }
}
