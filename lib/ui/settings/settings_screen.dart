import 'package:deverse_host_app/ui/settings/settings_model.dart';
import 'package:deverse_host_app/ui/widgets/icon_with_text.dart';
import 'package:deverse_host_app/utils/strings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../../repositories/user_repository.dart';
import '../../utils/injection_container.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const route = '/settings';

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserRepository _userRepository = container<UserRepository>();

  @override
  Widget build(BuildContext context) {
    final settingModel = context.watch<SettingsModel>();
    final _user = _userRepository.user;
    final theme = FluentTheme.of(context);
    return NavigationView(
      appBar: NavigationAppBar(
        // backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Setting"),
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
          _user != null
              ? Row(
                  children: [
                    const SizedBox(width: 8.0),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        "https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png", // Update when user have avatar
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user.name.orNull() ?? "Anonymous",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        _user.wallet_address.orNull() != null
                            ? Text(_user.wallet_address ?? "")
                            : const SizedBox(),
                        _user.custom_email.orNull() != null
                            ? Text(_user.custom_email ?? "")
                            : const SizedBox(),
                        const IconWithText(
                          icon: FluentIcons.pencil_reply,
                          title: "Edit profile",
                        ),
                      ],
                    )
                  ],
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: ListTile(
              tileColor: theme.menuColor,
              leading: const Icon(FluentIcons.pencil_reply),
              title: const Text("App theme"),
              subtitle: const Text("Toggle to switch theme"),
              trailing: Row(
                children: [
                  Text(settingModel.currentMode),
                  ToggleSwitch(
                    checked: settingModel.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      settingModel.setTheme(value);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
