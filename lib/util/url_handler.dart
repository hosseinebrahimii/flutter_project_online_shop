import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {}

class UrlLauncher extends UrlHandler {
  static Future<void> openUrl(String url) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
