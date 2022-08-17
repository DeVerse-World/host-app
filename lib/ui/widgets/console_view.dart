import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LogsContainer {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier _logs = ValueNotifier<String>("");
  LogsContainer() {
    _logs.addListener(() {
      _controller.text = _logs.value;
    });
  }

  TextEditingController get controller {
    return _controller;
  }

  void addLog(String? newLogs) {
    if (newLogs != null) {
      _logs.value = _logs.value + "$newLogs\n";
    }
  }

  void clearLogs() {
    _logs.value = "";
  }
}

class ConsoleView extends StatefulWidget {
  const ConsoleView({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _ConsoleViewState();
}

class _ConsoleViewState extends State<ConsoleView> {

  final LogsContainer _logsContainer = container<LogsContainer>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(

        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormBox(
              // style: const TextStyle(
              //   background: Paint()..color = Colors.black,
              //   backgroundColor: Colors.black,
              //   color: Colors.white
              // ),
              readOnly: true,
              scrollController: _scrollController,
              maxLines: 10,
              header: "Logs",
              controller: _logsContainer.controller,
            )
            // TextBox(
            //   onChanged: (e) {},
            //   enabled: true,
            //   header: 'Logs',
            //   placeholder: 'Logs will appear here',
            //   showCursor: true,
            //
            //   controller: _logsContainer.controller,
            // )

          ],
        ),

      ),
    );
    return SizedBox(
      child:
        TextFormBox(

      header: 'Logs',
      placeholder: 'Logs will appear here',
      controller: _logsContainer.controller,
        )
    );
  }
}
