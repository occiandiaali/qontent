import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;

  _openSettingModal () {
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
                const Text('Settings Modal'),
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
              onPressed: () => _openSettingModal(),
              icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        children: [
          const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 18,),
          Expanded(
            child: ListView(
              children: [
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                const ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                const ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text('Confidentiality'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                const ListTile(
                  leading: Icon(Icons.health_and_safety_outlined),
                  title: Text('Safety'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Notifications'),
                    trailing: Switch(
                        value: _darkMode,
                        onChanged: (value) => setState(() => _darkMode = value))
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
