import 'package:aha_client/src/api/login_service.dart';
import 'package:aha_client/src/api/models/session_info.dart';
import 'package:aha_client/src/api/xml_typed_converter.dart';
import 'package:chopper/chopper.dart';

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
          ],
        );

  void dispose() => _client.dispose();

  LoginService get login => _client.getService();
}
