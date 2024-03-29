import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/ui/home/home_model.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:deverse_host_app/ui/settings/settings_screen.dart';
import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Checkbox, Colors, IconButton, Icon;
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

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text("Home"),
        leading: const Center(
          child: Icon(FluentIcons.home),
        ),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: IconButton(
                icon: const Icon(FluentIcons.settings, size: 24),
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingsScreen.route);
                },
              ),
            )
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<HomeModel>(builder: (context, model, child) {
              if (model.isAuthenticated) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select root subworld theme",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: theme.borderInputColor, width: 0.1),
                          color: theme.scaffoldBackgroundColor),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Consumer<HomeModel>(
                                builder: (context, model, child) {
                                  if (!model.isAuthenticated) {
                                    return const Text("Please login first");
                                  }
                                  return Wrap(
                                    direction: Axis.vertical,
                                    spacing: 12,
                                    children: model.templates
                                        .map((template) => RadioButton(
                                            // style: RadioButtonThemeData(
                                            //   checkedDecoration: ButtonState.resolveWith((states) => {
                                            //
                                            //   })
                                            // ),
                                            checked: _selectedTemplate?.id ==
                                                template.id,
                                            content:
                                                Text(template.display_name),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedTemplate = template;
                                              });
                                            }))
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
                if (!model.isAuthenticated) {
                  return Button(
                      onPressed: () {
                        _model.authenticate(true);
                      },
                      child: const Text("Authenticate"));
                }
                return Row(children: [
                  SizedBox(
                    width: 80,
                    child: FilledButton(
                      onPressed: () {
                        if (_selectedTemplate != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SessionManagerScreen(
                                  rootTemplate: _selectedTemplate!)));
                        }
                      },
                      child: const Text("Next"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 80,
                    child: Button(
                      onPressed: () {
                        _model.logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ]);
              },
            ),
            const Expanded(child: SizedBox()),
            const ConsoleView()
          ],
        ),
      ),
    );
  }
}
