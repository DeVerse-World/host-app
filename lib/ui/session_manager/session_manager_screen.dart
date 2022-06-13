import 'package:deverse_host_app/data/models/sub_world_config.dart';
import 'package:deverse_host_app/data/models/sub_world_theme.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_model.dart';
import 'package:deverse_host_app/ui/session_manager/sub_world_config_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionManagerScreen extends StatefulWidget {
  const SessionManagerScreen({Key? key, required this.levels}) : super(key: key);
  static const route = '/gameManager';
  final List<SubWorldTheme> levels;

  @override
  State createState() => _SessionManagerScreenState();
}

class _SessionManagerScreenState extends State<SessionManagerScreen> {
  SessionManagerModel get _model {
    return Provider.of<SessionManagerModel>(context, listen: false);
  }

  TextEditingController _vernameController = TextEditingController();
  TextEditingController _playerCountController = TextEditingController();
  TextEditingController _portController = TextEditingController(text: "7777");
  TextEditingController _beaconController = TextEditingController(text: "7877");



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
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Select your level"),
                      Consumer<SessionManagerModel>(
                        builder: (context, model, child) {
                          return DropdownButton<SubWorldTheme>(
                              isExpanded: true,
                              hint: const Text("Tap to select..."),
                              value: _model.selectedLevel,
                              items: widget.levels.map((level) => DropdownMenuItem(value: level, child: Text(level.file_name))).toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  _model.onSelectLevel(newValue);
                                }
                              });
                        },
                      ),
                      Consumer<SessionManagerModel>(builder: (context, model, child) {
                        return Container(
                          color: Colors.white,
                          height: 100,
                          child: SubWorldConfigManagerView(data: model.savedConfigs, onApply: (item) {

                          }, onDelete: (item) {

                          })
                        ) ;
                      })
                    ],
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Verse name"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _vernameController,
                        decoration: const InputDecoration(hintText: "e.g: My awesome verse",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 36),
                      const Text("Max player count"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _playerCountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Port"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _portController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "7777", border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 36),
                      const Text("Beacon port"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _beaconController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Launch Verse"),
                    onPressed: () {
                      _model.onLaunchVerse(_vernameController.text, _playerCountController.text, _portController.text, _beaconController.text);
                    },
                  )
                ],
              ),
              const SizedBox(height: 36),
              _buildSessionTable(),
            ],
            // Row(
            //   children: [ElevatedButton(onPressed: () {}, child: const Text("Continue"))],
            // )
          ),
        ));
  }

  Widget _buildSessionTable() {
    return DataTable(
      columns: [
        DataColumn(label: const Text("Id")),
        DataColumn(label: const Text("Name")),
        DataColumn(label: const Text("Level")),
        DataColumn(label: const Text("Port")),
        DataColumn(label: const Text("Status")),
        DataColumn(label: const Text("Players")),
        DataColumn(label: const Text("Actions"))
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("1")),
          DataCell(Text("Awesome world")),
          DataCell(Text("Blizzard")),
          DataCell(Text("7777")),
          DataCell(Text("Active")),
          DataCell(Text("0/8")),
          DataCell(Text("Close"))
        ])
      ],
      border: TableBorder.all(),
    );
  }
}
