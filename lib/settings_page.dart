import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 60, color: Colors.pink,),
                  Text('@user3000',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.deepPurpleAccent),
                  )
                ],
              ),
              Icon(Icons.settings, size: 280, color: Colors.deepPurple,),
              Text('Your app settings will show here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.deepPurpleAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
