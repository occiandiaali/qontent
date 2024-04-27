import 'package:flutter/material.dart';

class TempVideoHistory extends StatefulWidget {
  const TempVideoHistory({super.key});

  @override
  State<TempVideoHistory> createState() => _TempVideoHistoryState();
}

class _TempVideoHistoryState extends State<TempVideoHistory> {
  _openModal () {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        // isDismissible: false,
        // enableDrag: false,
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 400,
            child: Column(
              children: [
                Image.asset(
                  width: 150,
                  height: 150,
                  "assets/images/app_logo_light.png", fit: BoxFit.cover,),
                const SizedBox(height: 24.0,),
                const Text('Page Feature Modal', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),),
                const Text('Content Here..')
              ],
            ),
          );

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _openModal(),
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
