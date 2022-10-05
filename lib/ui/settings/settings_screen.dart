import 'package:deverse_host_app/ui/settings/settings_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const route = '/settings';

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingModel = context.watch<SettingsModel>();
    final theme = FluentTheme.of(context);
    return NavigationView(
      appBar: NavigationAppBar(
        // backgroundColor: theme.scaffoldBackgroundColor,
        title: Text("Setting"),
        leading: Center(
          child: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: ListTile(
              tileColor: theme.menuColor,
              leading: Icon(FluentIcons.pencil_reply),
              title: Text("Dark theme"),
              subtitle: Text("Click to switch themes"),
              trailing: ToggleSwitch(
                checked: settingModel.getThemeMode() == ThemeMode.dark,
                onChanged: (value) {
                  settingModel.setDarkTheme(value);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
