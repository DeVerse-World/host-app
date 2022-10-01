import 'package:fluent_ui/fluent_ui.dart';

class TableRowContent extends StatelessWidget {
  const TableRowContent({Key? key, required this.content})
      : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        content,
      ),
    );
  }
}