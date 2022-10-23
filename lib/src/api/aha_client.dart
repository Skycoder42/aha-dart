import 'package:chopper/chopper.dart';
import 'package:http/http.dart';

import 'aha/aha_service.dart';
import 'aha/models/switch_status.dart';
import 'login/login_manager.dart';
import 'login/login_service.dart';
import 'login/models/session_info.dart';
import 'util/combined_converter.dart';
import 'util/text_converter.dart';
import 'util/xml_converter.dart';

class AhaClient {
  static const defaultHostName = 'fritz.box';

  final ChopperClient client;

  final LoginManager loginManager;

  AhaClient({
    String hostName = defaultHostName,
    int? port,
    required this.loginManager,
    Client? httpClient,
  }) : client = ChopperClient(
          client: httpClient,
          baseUrl: Uri(
            scheme: 'https',
            host: hostName,
            port: port,
          ).toString(),
          converter: CombinedConverter([
            XmlConverter()..registerConverter(SessionInfo.converter),
            TextConverter()..registerConverter(SwitchStatus.converter),
          ]),
          interceptors: <dynamic>[
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

  late final AhaService aha = client.getService();
}
