import 'package:url_launcher/url_launcher.dart';

abstract class UrlLaunchHandler {
  void openUrl(String paymentUri);
}

class UrlLauncher extends UrlLaunchHandler {
  @override
  void openUrl(String paymentUri) {
    launchUrl(
      Uri.parse(paymentUri),
      mode: LaunchMode.externalApplication,
    );
  }
}
