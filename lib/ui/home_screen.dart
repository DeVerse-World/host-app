import 'package:deverse_host_app/data/enums/page_section.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:deverse_host_app/ui/settings/settings_screen.dart';
import 'package:deverse_host_app/ui/setup/setup_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageSection currentSection = PageSection.setup;

  void _onSectionChanged(PageSection newSection) {
    setState(() {
      currentSection = newSection;
    });
    Navigator.pop(context); // close the drawer
  }

  Widget _renderAppBody() {
    Widget newBody;
    switch (currentSection) {
      case PageSection.setup:
        newBody = const SetupScreen();
        break;
      case PageSection.sessionManager:
        newBody = const SessionManagerScreen();
        break;
      case PageSection.settings:
        newBody = const SettingsScreen();
        break;
    }
    return newBody;
  }

  Drawer _renderAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/deverse-logo.png"),
                  alignment: Alignment.bottomRight),
              color: Colors.black,
            ),
            child: Text(''),
          ),
          ListTile(
            title: const Text('Setup server'),
            trailing: const Icon(Icons.phonelink_setup),
            onTap: () {
              _onSectionChanged(PageSection.setup);
            },
          ),
          ListTile(
            title: const Text('Session Manager'),
            trailing: const Icon(Icons.manage_accounts),
            onTap: () {
              _onSectionChanged(PageSection.sessionManager);
            },
          ),
          ListTile(
            title: const Text('Console Settings'),
            trailing: const Icon(Icons.settings),
            onTap: () {
              _onSectionChanged(PageSection.settings);
            },
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    var title = "";
    switch (currentSection) {
      case PageSection.setup:
        title = "Setup";
        break;
      case PageSection.sessionManager:
        title = "Session Manager";
        break;
      case PageSection.settings:
        title = "Settings";
        break;
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_getTitle()),
          centerTitle: true,
        ),
        drawer: _renderAppDrawer(),
        body: _renderAppBody());
  }
}
