import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_model.dart';
import 'package:deverse_host_app/ui/session_manager/sub_world_config_manager.dart';
import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class SessionManagerScreen extends StatefulWidget {
  const SessionManagerScreen({Key? key, required this.rootTemplate}) : super(key: key);
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
  final TextEditingController _playerCountController = TextEditingController();
  final TextEditingController _portController = TextEditingController(text: "7777");
  final TextEditingController _beaconController = TextEditingController(text: "7877");

  @override
  void initState() {
    super.initState();
    _model.initData(widget.rootTemplate!);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _buildVerseInputSection(),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    child: const Text("Launch Verse"),
                    onPressed: () {
                      _model.onLaunchVerse(_vernameController.text, _playerCountController.text, _portController.text, _beaconController.text);
                    },
                  )
                ],
              ),
              const SizedBox(height: 36),
              _buildSessionTable(),
              const SizedBox(height: 36),
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

  Widget _buildSessionTable() {
    return Consumer<SessionManagerModel>(builder: (context, model, child) {
      var contents = model.instances
          .map((instance) => TableRow(

          children: [
                Text(instance.id.toString()),
                Text(instance.host_name),
                Text(instance.region),
                Text(instance.instance_port),
                Text(instance.beacon_port),
                Text("${instance.num_current_players}/${instance.max_players}"),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {
                        model.onDeleteVerse(instance);
                      },
                      child: const Text("Delete"),
                    )
                  ],
                )
              ]))
          .toList();
      contents.insert(
          0, const TableRow(children: [Text("Id"), Text("Name"), Text("Region"), Text("Port"), Text("Beacon Port"), Text("Players"), Text("Actions")]));
      return SizedBox(
        width: 800,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
            // columnWidths: const {
            //   0: FlexColumnWidth(1),
            //   1: FlexColumnWidth(2),
            //   2: FlexColumnWidth(2),
            //   3: FlexColumnWidth(2),
            //   4: FlexColumnWidth(2),
            //   5: FlexColumnWidth(2),
            //   6: FlexColumnWidth(2),
            // },
            border: TableBorder.all(), children: contents),
      );
    });
  }

  Widget _buildVerseInputSection() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 300.0,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select specific level"),
            Consumer<SessionManagerModel>(
                builder: (context, model, child){
                  if (model.templates.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return DropDownButton(
                    title: Text(_model.selectedTemplate?.display_name ?? "Tap to select..."),
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
                  if (model.selectedTemplate?.thumbnail_centralized_uri == null) {
                    return const Image(image: AssetImage("assets/images/placeholder_background.png"));
                  }
                  return Image(image: NetworkImage(model.selectedTemplate!.thumbnail_centralized_uri));
                },
              ),
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
            const Text("Verse name"),
            const SizedBox(height: 8),
            TextBox(
              controller: _vernameController,
              // decoration: const InputDecoration(hintText: "e.g: My awesome verse", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 36),
            const Text("Max player count"),
            const SizedBox(height: 8),
            TextBox(
              controller: _playerCountController,
              keyboardType: TextInputType.number,
              // decoration: const InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      Container(
        width: 300.0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Port"),
            const SizedBox(height: 8),
            TextBox(
              controller: _portController,
              keyboardType: TextInputType.number,
              // decoration: InputDecoration(hintText: "7777", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 36),
            const Text("Beacon port"),
            const SizedBox(height: 8),
            TextBox(
              controller: _beaconController,
              keyboardType: TextInputType.number,
              // decoration: InputDecoration(hintText: "e.g: 10", border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    ]);
  }
}
