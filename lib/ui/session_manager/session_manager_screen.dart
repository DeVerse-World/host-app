import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionManagerScreen extends StatefulWidget {
  const SessionManagerScreen({Key? key, required this.levels}) : super(key: key);
  static const route = '/gameManager';
  final List<DLevel> levels;

  @override
  State createState() => _SessionManagerScreenState();
}

class _SessionManagerScreenState extends State<SessionManagerScreen> {
  SessionManagerModel get _model {
    return Provider.of<SessionManagerModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _model.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create your stuffs"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Verse name"),
                  const Text("TODO: put input field here"),
                  const SizedBox(height: 36),
                  const Text("Select your level"),
                  SizedBox(
                    width: 200,
                    child: Consumer<SessionManagerModel>(
                      builder: (context, model, child) {
                        return DropdownButton<DLevel>(
                            isExpanded: true,
                            hint: const Text("Tap to select..."),
                            value: _model.selectedLevel,
                            items: widget.levels.map((level) => DropdownMenuItem(value: level, child: Text(level.name))).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                _model.onSelectLevel(newValue);
                              }
                            });
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Text("hey")
                ],
              )
            ]),
          ),
        )
        );
  }
}
