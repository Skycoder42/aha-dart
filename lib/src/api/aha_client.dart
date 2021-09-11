import 'package:aha_client/src/api/login/login_manager.dart';
import 'package:chopper/chopper.dart';

import 'aha_service.dart';
import 'login/login_service.dart';
import 'login/models/session_info.dart';
import 'xml_typed_converter.dart';

class AhaClient {
  static const defaultHostName = 'fritz.box';

  final ChopperClient _client;

  final LoginManager loginManager;

  AhaClient({
    String hostName = defaultHostName,
    int? port,
    required this.loginManager,
  }) : _client = ChopperClient(
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
    loginManager.linkToClient(_client);
  }

  void dispose() => _client.dispose();

  LoginService get login => _client.getService();

  AhaService get aha => _client.getService();
}
