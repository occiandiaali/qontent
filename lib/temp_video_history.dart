import 'package:flutter/material.dart';

class TempVideoHistory extends StatefulWidget {
  const TempVideoHistory({super.key});

  @override
  State<TempVideoHistory> createState() => _TempVideoHistoryState();
}

class _TempVideoHistoryState extends State<TempVideoHistory> {
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
              Icon(Icons.video_collection_outlined, size: 280, color: Colors.deepPurple,),
              Text('Your saved videos will display here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.deepPurpleAccent),
              ),
              Text('Upgrade to PREMIUM to enjoy this and more.'),
            ],
          ),
        ),
      ),
    );
  }
}
