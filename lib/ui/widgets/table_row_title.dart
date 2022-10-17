import 'package:fluent_ui/fluent_ui.dart';

class TableRowTitle extends StatelessWidget {
  const TableRowTitle({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}