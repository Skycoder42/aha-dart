// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:aha_client/aha_client.dart';

class _AhaClientHttpOverrides extends HttpOverrides {
  final String _host;
  final int _port;

  _AhaClientHttpOverrides(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback =
            (cert, host, port) => host == _host && port == _port;
}

// ignore: must_be_immutable
class ExampleLoginManager extends LoginManager {
  @override
  FutureOr<UserCredentials?> obtainCredentials(LoginInfo loginInfo) async {
    if (loginInfo.blockTime != null) {
      stdout.writeln(
        'Login blocked until: ${DateTime.now().add(loginInfo.blockTime!)}',
      );
    }
    stdout
      ..writeln('Known usernames: ${loginInfo.knownUsers}')
      ..write('Username: ');
    await stdout.flush();
    final username = stdin.readLineSync();
    stdout.write('Password: ');
    await stdout.flush();

    final echoMode = stdin.echoMode;
    String? password;
    try {
      stdin.echoMode = false;
      password = stdin.readLineSync();
      stdout.writeln();
    } finally {
      stdin.echoMode = echoMode;
    }

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
  print('');
  if (response.isSuccessful) {
    print(response.body);
  } else {
    print(response.error);
  }

  await client.dispose();
}
