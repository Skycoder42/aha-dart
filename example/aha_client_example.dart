import 'dart:io';

import 'package:aha_client/src/api/aha_client.dart';

class _AhaClientHttpOverrides extends HttpOverrides {
  final String _host;
  final int _port;

  _AhaClientHttpOverrides(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              host == _host && port == _port;
  }
}

Future<void> main() async {
  HttpOverrides.global =
      _AhaClientHttpOverrides(AhaClient.defaultHostName, 443);

  final client = AhaClient();

  final response = await client.login.getLoginStatus();

  print(response.body);

  client.dispose();
}
