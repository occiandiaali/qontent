import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class CropPage extends StatelessWidget {
  const CropPage({super.key, required this.controller});

  final VideoEditorController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Crop Video'),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black26,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit_attributes_outlined, size: 32, color: Colors.white,),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: IconButton(
                        onPressed: () =>
                        controller.rotate90Degrees(RotateDirection.left),
                        icon: const Icon(Icons.rotate_left, color: Colors.yellow,),
                      )),
                  Expanded(
                      child: IconButton(
                        onPressed: () =>
                            controller.rotate90Degrees(RotateDirection.right),
                        icon: const Icon(Icons.rotate_right, color: Colors.yellow),
                      )),
                ],
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: CropGridViewer.edit(
                  controller: controller,
                  rotateCropArea: false,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
