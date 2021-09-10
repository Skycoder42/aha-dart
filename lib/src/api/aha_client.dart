import 'package:chopper/chopper.dart';

import 'aha_service.dart';
import 'login/login_service.dart';
import 'login/models/session_info.dart';
import 'xml_typed_converter.dart';

class AhaClient {
  static const defaultHostName = 'fritz.box';

  final ChopperClient _client;

  AhaClient({
    String hostName = defaultHostName,
    int? port,
  }) : _client = ChopperClient(
          baseUrl: Uri(
            scheme: 'https',
            host: hostName,
            port: port,
          ).toString(),
          converter: XmlTypedConverter()
            ..registerConverter<SessionInfo>(SessionInfo.converter),
          services: [
            LoginService.create(),
            AhaService.create(),
          ],
        );

  void dispose() => _client.dispose();

  LoginService get login => _client.getService();

  AhaService get aha => _client.getService();
}
