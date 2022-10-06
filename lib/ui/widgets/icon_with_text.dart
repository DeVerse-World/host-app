import 'package:fluent_ui/fluent_ui.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String title;

  const IconWithText({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12),
        const SizedBox(width: 6),
        Text(title),
      ],
    );
  }
}
