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
                                );
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
  }) {
    final UserRepository userRepository = container<UserRepository>();
    final user = userRepository.user;
    final TextEditingController editNameController = TextEditingController();
    final currentName = (user?.name?.isEmpty ?? true)
        ? "You haven't set name yet"
        : 'Current name: ${user!.name!}';
    bool isLoading = false;
    String error = "";
    return StatefulBuilder(builder: (context, setState) {
      return ContentDialog(
        title: const Text('Update your profile'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(currentName),
              const SizedBox(
                height: 8,
              ),
              TextBox(
                controller: editNameController,
              ),
              error.isNotEmpty
                  ? Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
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
                            if(editNameController.text.isEmpty){
                              setState(() {
                                error = "Invalid name";
                              });
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final result = await _userRepository
                                .updateProfile(editNameController.text);
                            setState(() {
                              error = result.isFailure
                                  ? result.error.toString()
                                  : "";
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
