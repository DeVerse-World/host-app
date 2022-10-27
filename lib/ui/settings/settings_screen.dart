import 'dart:io';
import 'package:deverse_host_app/ui/settings/settings_model.dart';
import 'package:deverse_host_app/ui/widgets/icon_with_text.dart';
import 'package:deverse_host_app/utils/strings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../../data/api/response_body.dart';
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

  Future<bool> _updateProfile(String name) async {
    print(name);
    await Future.delayed(const Duration(seconds: 4));
    return true;
  }

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
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return _profileDialog(
                                    context: context,
                                    updateProfile: _updateProfile,
                                    user: _user);
                              },
                            );
                          },
                          child: const IconWithText(
                            icon: FluentIcons.pencil_reply,
                            title: "Edit profile",
                          ),
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

  Widget _profileDialog({
    required BuildContext context,
    User? user,
    required Future<bool> Function(String) updateProfile,
  }) {
    final TextEditingController editNameController = TextEditingController();
    final currentName = user?.name.orNull() ?? "Anonymous";
    bool isLoading = false;
    return StatefulBuilder(builder: (context, setState) {
      return ContentDialog(
        title: const Text('Update your profile'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Current name: $currentName'),
              const SizedBox(
                height: 8,
              ),
              TextBox(
                controller: editNameController,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !isLoading
                      ? TextButton(
                          child: const Text('Next'),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await updateProfile.call(editNameController.text);
                            setState(() {
                              isLoading = false;
                            });
                          },
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: ProgressRing(),
                          ),
                        ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
