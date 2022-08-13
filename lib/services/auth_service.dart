import 'package:deverse_host_app/services/base_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService extends BaseService {
  final _baseUrl = "https://staging.deverse.world";

  void authenticateUser(String loginKey) {
    launchUrl(Uri.parse("$_baseUrl/login?key=$loginKey"));
  }
}