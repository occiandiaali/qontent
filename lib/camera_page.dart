import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:supabase_teleprompter/custom_widgets/video_script_scroll.dart';
//import 'package:supabase_teleprompter/custom_widgets/script_overlay.dart';
import 'package:supabase_teleprompter/main.dart';
import 'package:supabase_teleprompter/video_page.dart';
//import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';


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

  String _pickedFilePath = '';
  String videoScript = '';

  Future<void> pickDoc() async {
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
  }

  void setVideoScript() {
    pickDoc();
    final PdfDocument document =
        PdfDocument(inputBytes: File(_pickedFilePath).readAsBytesSync());
    videoScript = PdfTextExtractor(document).extractText();
    document.dispose();
  }

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
      final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => VideoPage(filePath: file.path));
      if (!mounted) return;
        Navigator.push(context, route);
    } else {
      try {
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
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(
                _cameraController,
              child: Offstage(
                offstage: !_isRecording,
               child: ScrollLoopAutoScroll(
                 scrollDirection: Axis.vertical,
                 gap: 50,
                 delay: Duration(seconds: 35),
                 duration: Duration(minutes: 50),
                 child: Text(videoScript,
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                       color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),),
               ),
               // child: const ScriptOverlay(),
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
                          child: const Icon(Icons.file_open_sharp),
                          label: 'Add script',
                          backgroundColor: Colors.green,
                          visible: videoScript == '',
                          onTap: () => setVideoScript()
                        ),
                        SpeedDialChild(
                            child: const Icon(Icons.delete_outline),
                            label: 'Remove script',
                          backgroundColor: Colors.red,
                            visible: videoScript != '',
                            onTap: () => setState(() {
                              _pickedFilePath = '';
                              videoScript = '';
                            })
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
