import 'package:deverse_host_app/data/models/sub_world_config.dart';
import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_model.dart';
import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:deverse_host_app/ui/widgets/table_row_content.dart';
import 'package:deverse_host_app/ui/widgets/table_row_title.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class SessionManagerScreen extends StatefulWidget {
  const SessionManagerScreen({Key? key, required this.rootTemplate})
      : super(key: key);
  static const route = '/gameManager';
  final SubWorldTemplate? rootTemplate;

  @override
  State createState() => _SessionManagerScreenState();
}

class _SessionManagerScreenState extends State<SessionManagerScreen> {
  SessionManagerModel get _model {
    return Provider.of<SessionManagerModel>(context, listen: false);
  }

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _vernameController = TextEditingController();
  final TextEditingController _playerCountController =
      TextEditingController(text: "8");
  final TextEditingController _portController =
      TextEditingController(text: "7777");
  final TextEditingController _beaconController =
      TextEditingController(text: "7877");

  bool _vernameError = false;
  bool _maxPlayerError = false;
  SubWorldConfig? _selectedConfig;

  @override
  void initState() {
    super.initState();
    _model.initData(widget.rootTemplate!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return NavigationView(
      appBar: NavigationAppBar(
        // backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(widget.rootTemplate!.display_name),
        leading: Center(
          child: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 300.0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select specific level",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Consumer<SessionManagerModel>(
                              builder: (context, model, child) {
                            if (model.templates.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return DropDownButton(
                              title: Text(
                                  _model.selectedTemplate?.display_name ??
                                      "Tap to select..."),
                              items: model.templates
                                  .map((template) => MenuFlyoutItem(
                                      text: Text(template.display_name),
                                      onPressed: () {
                                        _model.onSelectTemplate(template);
                                      }))
                                  .toList(),
                            );
                          }),
                          SizedBox(
                            width: 220,
                            height: 220,
                            child: Consumer<SessionManagerModel>(
                              builder: (context, model, child) {
                                if (model.selectedTemplate
                                        ?.thumbnail_centralized_uri ==
                                    null) {
                                  return Image.asset(
                                    fit: BoxFit.fill,
                                    "assets/images/placeholder_background.png",
                                  );
                                }
                                return Image.network(
                                  model.selectedTemplate!
                                      .thumbnail_centralized_uri,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: ProgressRing(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      // Consumer<SessionManagerModel>(builder: (context, model, child) {
                      //   return Container(
                      //       color: Colors.white,
                      //       height: 100,
                      //       child: SubWorldConfigManagerView(data: model.savedConfigs, onApply: (item) {}, onDelete: (item) {}));
                      // })
                    ],
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "World name",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextBox(
                        controller: _vernameController,
                        // decoration: const InputDecoration(hintText: "e.g: My awesome verse", border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 36,
                        child: _vernameError
                            ? Text(
                                "Enter verse name, plz",
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                      ),
                      const Text(
                        "Max player count",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextBox(
                        controller: _playerCountController,
                        keyboardType: TextInputType.number,
                        // decoration: const InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
                      ),
                      _maxPlayerError
                          ? Text(
                              "Enter valid max player count, plz",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Load saved config",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Consumer<SessionManagerModel>(
                          builder: (context, model, child) {
                        if (model.savedConfigs.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return DropDownButton(
                          title: Text(_selectedConfig?.name ??
                              "Tap to load saved config..."),
                          items: model.savedConfigs
                              .map((template) => MenuFlyoutItem(
                                  text: Text(template.name),
                                  onPressed: () {
                                    setState(() {
                                      _selectedConfig = template;
                                      _vernameController.text = template.name;
                                      _playerCountController.text =
                                          "${template.maxPlayerCount}";
                                      _portController.text = "${template.port}";
                                      _beaconController.text =
                                          "${template.beaconPort}";
                                    });
                                  }))
                              .toList(),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Port",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextBox(
                        controller: _portController,
                        keyboardType: TextInputType.number,
                        // decoration: InputDecoration(hintText: "7777", border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 36),
                      const Text(
                        "Beacon port",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextBox(
                        controller: _beaconController,
                        keyboardType: TextInputType.number,
                        // decoration: InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                              child: const Text("Save config"),
                              onPressed: () {
                                final maxPlayer =
                                    int.tryParse(_playerCountController.text);
                                setState(() {
                                  _vernameError =
                                      _vernameController.text.isEmpty;
                                  _maxPlayerError =
                                      _playerCountController.text.isEmpty ||
                                          maxPlayer == null ||
                                          maxPlayer <= 0;
                                });
                                if (_vernameError || _maxPlayerError) return;
                                _model.onSaveConfig(
                                  _vernameController.text,
                                  int.tryParse(_playerCountController.text)!,
                                  int.tryParse(_portController.text)!,
                                  int.tryParse(_beaconController.text)!,
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    child: const Text("Launch world"),
                    onPressed: () {
                      setState(() {
                        _vernameError = _vernameController.text.isEmpty;
                        _maxPlayerError = _playerCountController.text.isEmpty;
                      });
                      if (_vernameError || _maxPlayerError) return;
                      _model.onLaunchVerse(
                          _vernameController.text,
                          _playerCountController.text,
                          _portController.text,
                          _beaconController.text);
                    },
                  )
                ],
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 0, maxHeight: 250),
                child: SingleChildScrollView(
                  child: Consumer<SessionManagerModel>(
                      builder: (context, model, child) {
                    var contents = model.instances
                        .map((instance) => TableRow(children: [
                              TableRowContent(content: instance.id.toString()),
                              TableRowContent(content: instance.host_name),
                              TableRowContent(content: instance.region),
                              TableRowContent(content: instance.instance_port),
                              TableRowContent(content: instance.beacon_port),
                              TableRowContent(
                                  content:
                                      "${instance.num_current_players}/${instance.max_players}"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        model.onDeleteVerse(instance);
                                      },
                                      icon: Icon(
                                        FluentIcons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]))
                        .toList();
                    contents.insert(
                        0,
                        const TableRow(children: [
                          TableRowTitle(title: "Id"),
                          TableRowTitle(title: "Name"),
                          TableRowTitle(title: "Region"),
                          TableRowTitle(title: "Port"),
                          TableRowTitle(title: "Beacon Port"),
                          TableRowTitle(title: "Players"),
                          TableRowTitle(title: "Actions"),
                        ]));
                    return SizedBox(
                      width: 800,
                      child: Table(
                          defaultColumnWidth:
                              const IntrinsicColumnWidth(flex: 1),
                          // columnWidths: const {
                          //   0: FlexColumnWidth(1),
                          //   1: FlexColumnWidth(2),
                          //   2: FlexColumnWidth(2),
                          //   3: FlexColumnWidth(2),
                          //   4: FlexColumnWidth(2),
                          //   5: FlexColumnWidth(2),
                          //   6: FlexColumnWidth(2),
                          // },
                          border: TableBorder.all(),
                          children: contents),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 18),
              const ConsoleView()
            ],
            // Row(
            //   children: [ElevatedButton(onPressed: () {}, child: const Text("Continue"))],
            // )
          ),
        ),
      ),
    );
  }
}
