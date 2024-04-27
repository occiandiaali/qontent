import 'package:flutter/material.dart';
import 'package:supabase_teleprompter/camera_page.dart';
import 'package:supabase_teleprompter/settings_page.dart';
import 'package:supabase_teleprompter/temp_video_history.dart';

import 'custom_widgets/action_button.dart';
import 'custom_widgets/expandable_fab_sunray.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Q.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

 // static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  // void _showAction(BuildContext context, int index) {
  //   showDialog<void>(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Text(_actionTitles[index]),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('CLOSE'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/images/app_logo_light.png", fit: BoxFit.cover,),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SettingsPage()));
    }, //_showAction(context, 0),
            icon: const Icon(Icons.settings),
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TempVideoHistory()));
            },//_showAction(context, 1),
            icon: const Icon(Icons.history_outlined),
          ),
          ActionButton(
          //  onPressed: () => _showAction(context, 2),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()));
            },
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}
