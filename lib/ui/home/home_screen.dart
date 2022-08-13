import 'package:deverse_host_app/data/models/sub_world_template.dart';
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
  SubWorldTemplate? _selectedTemplate;

  HomeModel get _model {
    return Provider.of<HomeModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).initData();
  }

  Widget _buildTemplateList(List<SubWorldTemplate> templates) {
    return Column(
      children: templates
          .map((template) => RadioListTile<SubWorldTemplate>(
                title: Text(template.display_name),
                value: template,
                groupValue: _selectedTemplate,
                onChanged: (value) {
                  setState(() {
                    _selectedTemplate = value;
                  });
                },
              ))
          .toList(),
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
              const Text("Select original subworld theme"),
              SizedBox(
                width: 200,
                child: Consumer<HomeModel>(
                  builder: (context, model, child) {
                    if (model.isAuthenticated) {
                      return _buildTemplateList(model.templates);
                    }
                    return Text("Please login first");
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedTemplate != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SessionManagerScreen(rootTemplate: _selectedTemplate!)));
                  }
                },
                child: const Text("Move on"),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    _model.reAuthenticate();
                  },
                  child: const Text("Invalidate"))
            ],
          ),
        ));
  }
}
