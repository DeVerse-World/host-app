import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  final LogsContainer logsContainer = container<LogsContainer>();
}
