import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:deverse_host_app/ui/home/home_model.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:flutter/material.dart';
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
    _model.initData();
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
              const Text("Select your level"),
              SizedBox(
                width: 200,
                child: Consumer<HomeModel>(
                  builder: (context, model, child) {
                    return DropdownButton<DLevel>(
                        isExpanded: true,
                        hint: const Text("Tap to select..."),
                        value: _model.selectedLevel,
                        items: model.verseLevels.map((level) => DropdownMenuItem(value: level, child: Text(level.name))).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            _model.selectLevel(newValue);
                          }
                        });
                  },
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SessionManagerScreen(levels: _model.verseLevels)));
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text("Move on"),
              )
            ],
          ),
        ));
  }
}
