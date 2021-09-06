import 'package:aha_client/src/api/login_service.dart';
import 'package:chopper/chopper.dart';

abstract class AhaClient {
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
          services: [
            LoginService.create(),
          ],
        );
}
