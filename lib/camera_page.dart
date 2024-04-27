// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
//
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
// import 'package:supabase_teleprompter/custom_widgets/video_script_scroll.dart';
// //import 'package:supabase_teleprompter/custom_widgets/script_overlay.dart';
// import 'package:supabase_teleprompter/main.dart';
// import 'package:supabase_teleprompter/video_page.dart';
// //import 'package:flutter_lorem/flutter_lorem.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
//
//
// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});
//
//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   bool _isLoading = true;
//   bool _isRecording = false;
//   late CameraController _cameraController;
//   //final isDialOpen = ValueNotifier(false);
//
//   String _pickedFilePath = '';
//   String videoScript = '';
//
//   Future<void> pickDoc() async {
//     final path = await FlutterDocumentPicker.openDocument(
//       params: FlutterDocumentPickerParams(
//         allowedFileExtensions: ['pdf'],
//         invalidFileNameSymbols: ['/']
//       )
//     );
//     if (kDebugMode) {
//       print('InputFilePath: $path');
//     }
//     if (path != null) {
//       setState(() {
//         _pickedFilePath = path;
//       });
//     }
//   }
//
//   void setVideoScript() {
//     pickDoc();
//     final PdfDocument document =
//         PdfDocument(inputBytes: File(_pickedFilePath).readAsBytesSync());
//     if (videoScript.isEmpty) {
//       videoScript = PdfTextExtractor(document).extractText();
//     } else {
//       setState(() {
//         videoScript = '';
//       });
//     }
//     document.dispose();
//   }
//
//   @override
//   void initState() {
//     _initCamera();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }
//
//   _initCamera() async {
//     final cameras = await availableCameras();
//     final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
//     _cameraController = CameraController(front, ResolutionPreset.max);
//     await _cameraController.initialize();
//     setState(() => _isLoading = false);
//   }
//
//   _recordVideo() async {
//     if (_isRecording) {
//       final file = await _cameraController.stopVideoRecording();
//       setState(() => _isRecording = false);
//       setState(() => _pickedFilePath = '');
//       final route = MaterialPageRoute(
//           fullscreenDialog: true,
//           builder: (_) => VideoPage(filePath: file.path));
//       if (!mounted) return;
//         Navigator.push(context, route);
//     } else {
//       try {
//         await _cameraController.prepareForVideoRecording();
//         await _cameraController.startVideoRecording();
//         setState(() => _isRecording = true);
//       } on Exception catch (e) {
//         print('Exception: $e');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    // String loremText = lorem(paragraphs: 5, words: 200);
//     if (_isLoading) {
//       return Container(
//         color: Colors.white,
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       return Center(
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             CameraPreview(
//                 _cameraController,
//               child: Offstage(
//                 offstage: !_isRecording,
//                child: ScrollLoopAutoScroll(
//                  scrollDirection: Axis.vertical,
//                  gap: 50,
//                  delay: Duration(seconds: 35),
//                  duration: Duration(minutes: 50),
//                  child: Text(videoScript,
//                    textAlign: TextAlign.center,
//                    style: const TextStyle(
//                        color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),),
//                ),
//                // child: const ScriptOverlay(),
//               ),
//             ),
//             Positioned(
//               left: MediaQuery.of(context).size.width / 3,
//               child: Row(
//                 children: [
//                   GestureDetector(
//                       child: const Icon(Icons.home_outlined, size: 46, color: Colors.white,),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LandingScreen())
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(25),
//                     // child: FloatingActionButton(
//                     //   backgroundColor: Colors.red,
//                     //   child: Icon(_isRecording ? Icons.stop : Icons.circle),
//                     //   onPressed: () => _recordVideo(),
//                     // ),
//                     child: SpeedDial(
//                       animatedIcon: AnimatedIcons.menu_close,
//                       backgroundColor: Colors.pinkAccent,
//                       overlayColor: Colors.black,
//                       overlayOpacity: 0.4,
//                       spacing: 10,
//                     //  openCloseDial: isDialOpen,
//                       children: [
//                         SpeedDialChild(
//                           child: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record_rounded),
//                           label: _isRecording ? 'Stop video' : 'Record video',
//                           backgroundColor: Colors.deepOrange,
//                           visible: videoScript != '',
//                           onTap: () => _recordVideo(),
//                         ),
//                         SpeedDialChild(
//                           child: const Icon(Icons.file_open_sharp),
//                           label: 'Add script',
//                           backgroundColor: Colors.green,
//                           visible: videoScript == '',
//                           onTap: () => setVideoScript()
//                         ),
//                         SpeedDialChild(
//                             child: const Icon(Icons.delete_outline),
//                             label: 'Remove script',
//                           backgroundColor: Colors.red,
//                             visible: videoScript != '',
//                             onTap: () => setState(() {
//                               _pickedFilePath = '';
//                               videoScript = '';
//                             })
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

// ***************

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

import 'package:supabase_teleprompter/main.dart';
import 'package:supabase_teleprompter/video_page.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import 'custom_widgets/script_overlay.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  //final isDialOpen = ValueNotifier(false);
  final typeScriptController = TextEditingController();

  // To display video record timer
  Timer? _timer;
  int _remainingSeconds = 30;

  String _pickedFilePath = '';
  String videoScript = '';

  // void _startVideoRecordCountdown() {
  //   const oneSecond = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSecond, (timer) {
  //     if (_remainingSeconds <= 0) {
  //       setState(() => timer.cancel());
  //     } else {
  //       setState(() => _remainingSeconds--);
  //     }
  //   });
  // }

  Future<void> pickDoc() async {
    try {
      final path = await FlutterDocumentPicker.openDocument(
          params: FlutterDocumentPickerParams(
              allowedFileExtensions: ['pdf'],
              invalidFileNameSymbols: ['/']
          )
      );
      if (kDebugMode) {
        print('InputFilePath: $path');
      }
      if (path != null) {
        setState(() {
          _pickedFilePath = path;
        });
      }
    } on PlatformException catch (err) {
      if (mounted) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 15),
          padding: const EdgeInsets.all(8.0),
          content: const Text(
            'Unsupported filetype! Use only PDFs.',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          backgroundColor: (Colors.black),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      print('<<<<< Wrong file path! >>>>> $err');
      return;
    } catch (e) {
      print('Unsupported file $e');
    }
  }

  void setVideoScriptFromUpload() {
    pickDoc();
    final PdfDocument document =
    PdfDocument(inputBytes: File(_pickedFilePath).readAsBytesSync());
    if (videoScript.isEmpty) {
      videoScript = PdfTextExtractor(document).extractText();
    } else {
      setState(() {
        videoScript = '';
      });
    }
    document.dispose();
  }

  void _aiScriptDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Generate AI script', style: TextStyle(fontWeight: FontWeight.w900),),
            content: Column(
              children: [
                Image.asset(
                  width: 150,
                  height: 150,
                  "assets/images/app_logo_light.png", fit: BoxFit.cover,),
                const SizedBox(height: 14.0,),
                const Text(
                    'Only Premium subscribers can access AI assistant',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24, color: Colors.purple),
                ),
                const SizedBox(height: 24.0,),
                ElevatedButton(onPressed: () {}, child: const Text('Subscribe Now')),
                const SizedBox(height: 24.0,),
                TextButton(
                    onPressed: () => {
                      setState(() {

                      }),
                      Navigator.pop(context)
                    },
                    child: const Text('Dismiss')),
              ],
            )
          );
        });
  }

  void _showTypeScriptDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Type or paste your script',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24, color: Colors.purple),
            ),
            content: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  decoration: const InputDecoration.collapsed(hintText: 'Type/Paste here..'),
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  controller: typeScriptController,
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => setVideoScriptFromTextField(typeScriptController.text),
                  child: const Text('Done')),
              TextButton(
                  onPressed: () => {
                    setState(() {
                      typeScriptController.text = '';
                    }),
                    Navigator.pop(context)
                  },
                  child: const Text('Dismiss')),
            ],
          );
        });
  }

  int countScriptWords(String script) {
    var regExp = RegExp(r"\w+(\'\w+)?");
    int count = regExp.allMatches(script).length;
    return count;
  }

  void setVideoScriptFromTextField(String input) {
    int manyWords = countScriptWords(input);
    if (kDebugMode) {
      print('*** Words: $manyWords ***');
    }
    setState(() {
      videoScript = input;
      input = '';
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    typeScriptController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      setState(() => _pickedFilePath = '');

      setState(() => typeScriptController.clear());
      setState(() => videoScript = '');
      setState(() => _remainingSeconds = 30);
      if (kDebugMode) {
        print('<<<<< Controller txt: ${typeScriptController.text} >>>>>>');
      }

      final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => VideoPage(filePath: file.path));
      if (!mounted) return;
      Navigator.push(context, route);
    } else {
      try {
        //  _startVideoRecordCountdown();
        await _cameraController.prepareForVideoRecording();
        await _cameraController.startVideoRecording();
        setState(() => _isRecording = true);
      } on Exception catch (e) {
        print('Exception: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // String loremText = lorem(paragraphs: 5, words: 200);
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(
                _cameraController,
                child: Offstage(
                  offstage: !_isRecording,
                  child: ScrollLoopAutoScroll(
                    duplicateChild: 1,
                    scrollDirection: Axis.vertical,
                    gap: 50,
                    delay: Duration(seconds: 5),
                    duration: Duration(
                        seconds: countScriptWords(videoScript) < 200 ? 20 : 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        """
                        
                        
                        
                       $videoScript
                        """,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
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
                            fontWeight: FontWeight.bold),),
                    ),
                  ),
                  // child: ScriptOverlay(videoScript: videoScript),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.home_outlined, size: 46, color: Colors.white,),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LandingScreen())
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      // child: FloatingActionButton(
                      //   backgroundColor: Colors.red,
                      //   child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      //   onPressed: () => _recordVideo(),
                      // ),
                      child: SpeedDial(
                        animatedIcon: AnimatedIcons.menu_close,
                        backgroundColor: Colors.pinkAccent,
                        overlayColor: Colors.black,
                        overlayOpacity: 0.4,
                        spacing: 10,
                        //  openCloseDial: isDialOpen,
                        children: [
                          SpeedDialChild(
                            child: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record_rounded),
                            label: _isRecording ? 'Stop video' : 'Record video',
                            backgroundColor: Colors.deepOrange,
                            visible: videoScript != '',
                            onTap: () => _recordVideo(),
                          ),
                          SpeedDialChild(
                              child: const Icon(Icons.satellite_alt_outlined),
                              label: 'AI script',
                              backgroundColor: Colors.greenAccent,
                              visible: videoScript == '',
                              onTap: () => _aiScriptDialogue()
                          ),
                          SpeedDialChild(
                              child: const Icon(Icons.keyboard_alt_outlined),
                              label: 'Type script',
                              backgroundColor: Colors.lightGreen,
                              visible: videoScript == '',
                              onTap: () => _showTypeScriptDialogue()
                          ),
                          SpeedDialChild(
                              child: const Icon(Icons.file_open_sharp),
                              label: 'Upload script',
                              backgroundColor: Colors.green,
                              visible: videoScript == '',
                              onTap: () => setVideoScriptFromUpload()
                          ),
                          SpeedDialChild(
                              child: const Icon(Icons.delete_outline),
                              label: 'Remove script',
                              backgroundColor: Colors.red,
                              visible: (videoScript != '' && !_isRecording),
                              onTap: () => setState(() {
                                _pickedFilePath = '';
                                videoScript = '';
                                typeScriptController.text = '';
                              })
                          ),
                        ],
                      ),
                    ),
                    // Offstage(
                    //   offstage: !_isRecording,
                    //   child: Text(
                    //     '$_remainingSeconds',
                    //     style: const TextStyle(
                    //       color: Colors.white,
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
