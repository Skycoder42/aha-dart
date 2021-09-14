import 'dart:async';
import 'dart:io';

import 'package:aha_client/src/api/aha_client.dart';
import 'package:aha_client/src/api/login/login_info.dart';
import 'package:aha_client/src/api/login/login_manager.dart';
import 'package:aha_client/src/api/login/user_credentials.dart';

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

class ExampleLoginManager extends LoginManager {
  @override
  FutureOr<UserCredentials?> obtainCredentials(LoginInfo loginInfo) async {
    if (loginInfo.blockTime != null) {
      stdout.writeln(
        'Login blocked until: ${DateTime.now().add(loginInfo.blockTime!)}',
      );
    }
    stdout.writeln('Known usernames: ${loginInfo.knownUsers}');
    stdout.write('Username: ');
    await stdout.flush();
    final username = stdin.readLineSync();
    stdout.write('Password: ');
    await stdout.flush();
    stdin.echoMode = false;
    final password = stdin.readLineSync();
    stdin.echoMode = true;

    if (username == null || password == null) {
      return null;
    }

    return UserCredentials(username: username, password: password);
  }
}

Future<void> main() async {
  HttpOverrides.global =
      _AhaClientHttpOverrides(AhaClient.defaultHostName, 443);

  final client = AhaClient(loginManager: ExampleLoginManager());

  final response = await client.aha.getDeviceListInfos();
  print(response.statusCode);
  print(response.headers);
  print(response.bodyString);

  await client.dispose();
}
