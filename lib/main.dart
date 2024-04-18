import 'package:flutter/material.dart';
import 'package:supabase_teleprompter/camera_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'qontent',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/images/applogo.jpg", fit: BoxFit.cover,),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.camera),
            onPressed: () {
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => const CameraPage())
              );
            }
        ),
      ),
    );
  }
}
