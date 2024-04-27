import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class CropPage extends StatefulWidget {
  const CropPage({super.key, required this.controller});

  final VideoEditorController controller;

  @override
  State<CropPage> createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.edit_attributes_outlined, size: 32,)
        ],
      ),
      body: Center(
        child: Text('Controller: ${widget.controller}'),
      ),
    );
  }
}
