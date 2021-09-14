import 'package:aha_client/src/api/login/login_manager.dart';
import 'package:chopper/chopper.dart';

import 'aha_service.dart';
import 'login/login_service.dart';
import 'login/models/session_info.dart';
import 'xml_typed_converter.dart';

class AhaClient {
  static const defaultHostName = 'fritz.box';

  final ChopperClient client;

  final LoginManager loginManager;

  AhaClient({
    String hostName = defaultHostName,
    int? port,
    required this.loginManager,
  }) : client = ChopperClient(
          baseUrl: Uri(
            scheme: 'https',
            host: hostName,
            port: port,
          ).toString(),
          converter: XmlTypedConverter()
            ..registerConverter<SessionInfo>(SessionInfo.converter),
          interceptors: [
            loginManager,
          ],
          authenticator: loginManager,
          services: [
            LoginService.create(),
            AhaService.create(),
          ],
        ) {
    loginManager.setup(client.getService());
  }

  Future<void> dispose({bool withLogout = true}) async {
    if (withLogout) {
      await loginManager.logout();
    }

    client.dispose();
  }

  AhaService get aha => client.getService();
}
