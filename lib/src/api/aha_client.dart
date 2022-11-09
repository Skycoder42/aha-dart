import 'package:chopper/chopper.dart';
import 'package:http/http.dart';

import 'aha/aha_service.dart';
import 'aha/models/device_list.dart';
import 'aha/models/device_stats.dart';
import 'aha/models/hkr_temperature.dart';
import 'aha/models/temperature.dart';
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
            XmlConverter()
              ..registerResponseConverter(
                SessionInfo.elementName,
                SessionInfo.fromXmlElement,
              )
              ..registerResponseConverter(
                DeviceList.elementName,
                DeviceList.fromXmlElement,
              )
              ..registerResponseConverter(
                DeviceStats.elementName,
                DeviceStats.fromXmlElement,
              ),
            TextConverter()
              ..registerResponseConverter<Temperature>(Temperature.fromString)
              ..registerResponseConverter<HkrTemperature>(
                HkrTemperature.fromString,
              ),
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
    loginManager.setup(client.getService<LoginService>());
  }

  Future<void> dispose({bool withLogout = true}) async {
    if (withLogout) {
      await loginManager.logout();
    }

    client.dispose();
  }

  late final AhaService aha = client.getService();
}
