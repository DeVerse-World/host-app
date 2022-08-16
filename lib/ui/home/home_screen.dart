import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/ui/home/home_model.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubWorldTemplate? _selectedTemplate;
  int _selectedTemplateIndex = -1;

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
            .map((template) => RadioButton(
                checked: _selectedTemplate?.id == template.id,
                content: Text(template.display_name),
                onChanged: (value) {
                  setState(() {
                    _selectedTemplate = template;
                  });
                }))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        content: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<HomeModel>(builder: (context, model, child) {
            if (model.isAuthenticated) {
              return Column(
                children: [
                  const Text("Select original subworld theme"),
                  SizedBox(
                    width: 200,
                    child: Consumer<HomeModel>(
                      builder: (context, model, child) {
                        if (model.isAuthenticated) {
                          return _buildTemplateList(model.templates);
                        }
                        return const Text("Please login first");
                      },
                    ),
                  ),
                  Button(
                    onPressed: () {
                      if (_selectedTemplate != null) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SessionManagerScreen(rootTemplate: _selectedTemplate!)));
                      }
                    },
                    child: const Text("Next"),
                  ),
                ],
              );
            }
            return const Text("Please login first");
          }),

          const SizedBox(
            height: 20,
          ),
          Consumer<HomeModel>(
            builder: (context, model, child) {
              if (model.isAuthenticated) {
                return Button(
                    onPressed: () {
                      _model.logout();
                    },
                    child: const Text("Log out"));
              }
              return Button(
                  onPressed: () {
                    _model.authenticate(true);
                  },
                  child: const Text("Authenticate"));
            },
          ),
          const ConsoleView()
        ],
      ),
    ));
  }
}
