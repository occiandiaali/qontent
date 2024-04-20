import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:supabase_teleprompter/main.dart';
import 'package:supabase_teleprompter/video_page.dart';

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
            CameraPreview(_cameraController),
            Positioned(
              left: MediaQuery.of(context).size.width / 2.6,
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
                          child: Icon(_isRecording ? Icons.stop : Icons.video_camera_front_outlined),
                          label: _isRecording ? 'Stop video' : 'Record video',
                          backgroundColor: Colors.red,
                          onTap: () => _recordVideo(),
                        ),
                        SpeedDialChild(
                          child: const Icon(Icons.file_open_sharp),
                          label: 'Add script',
                          backgroundColor: Colors.green,
                        ),
                        SpeedDialChild(
                            child: const Icon(Icons.delete_outline),
                            label: 'Remove script',
                          backgroundColor: Colors.deepOrange,
                          onTap: () {},
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
