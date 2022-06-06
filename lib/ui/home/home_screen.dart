import 'package:deverse_host_app/ui/home/home_model.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeModel get _model {
    return Provider.of<HomeModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).initData();
  }

  Widget _buildLevelTable(HomeModel model) {
    return DataTable(
        columns: [
          DataColumn(label:
          Checkbox(value: model.isAllSelected, onChanged: (isChecked) {
            model.onToggleAllLevel(isChecked ?? false);
          })),
          const DataColumn(label: const Text("Name")),
        ],
        rows: model.verseLevels.map((level) {
          return DataRow(cells: [
            DataCell(Checkbox(
              value: model.isLevelSelected(level),
              onChanged: (isChecked) {
                model.onToggleSelection(level, isChecked ?? false);
              },
            )),
            DataCell(Text(level.name))
          ]);
        }).toList()
        // DataCell(Text("1")),
        // DataCell(Text("Awesome world")),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setup"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select your levels"),
              SizedBox(
                width: 200,
                child: Consumer<HomeModel>(
                  builder: (context, model, child) {
                    return _buildLevelTable(model);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_model.selectedLevels.isEmpty) {
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SessionManagerScreen(levels: _model.selectedLevels)));
                },
                child: const Text("Move on"),
              )
            ],
          ),
        ));
  }
}
