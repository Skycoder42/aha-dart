import 'package:chopper/chopper.dart';
import 'package:http/http.dart';

import 'aha/aha_service.dart';
import 'aha/models/color_defaults.dart';
import 'aha/models/device.dart';
import 'aha/models/device_list.dart';
import 'aha/models/device_stats.dart';
import 'aha/models/energy.dart';
import 'aha/models/hkr_temperature.dart';
import 'aha/models/power.dart';
import 'aha/models/subscription_state.dart';
import 'aha/models/temperature.dart';
import 'aha/models/timestamp.dart';
import 'login/login_manager.dart';
import 'login/login_service.dart';
import 'login/models/session_info.dart';
import 'util/combined_converter.dart';
import 'util/text_converter.dart';
import 'util/xml_converter.dart';

/// The AHA Api client.
///
/// This client handles both authentication and the actual API access. Please
/// refer to the official documentation on how the API works.
///
/// {@template aha_reference}
/// See https://avm.de/service/schnittstellen/
/// {@endtemplate}
class AhaClient {
  /// The default host name of a fritz.box.
  static const defaultHostName = 'fritz.box';

  /// The underlying chopper client being used for the API requests.
  final ChopperClient client;

  /// The login manager that can be used to handle sessions.
  ///
  /// Provides methods to log in and out of the remote and to check for session
  /// validity.
  final LoginManager loginManager;

  /// Default constructor.
  ///
  /// By default, the client connects to http://fritz.box:80. Can be configured
  /// via [hostName] and [port].
  ///
  /// The [loginManager] parameter is required and should be your extension of
  /// the [LoginManager] to handle user authentication.
  ///
  /// Finally, a custom [httpClient] can be provided to be passed to chopper. If
  /// given, you are responsible for disposing that client.
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
                Device.deviceElementName,
                Device.fromXmlElement,
                const [Device.groupElementName],
              )
              ..registerResponseConverter(
                DeviceStats.elementName,
                DeviceStats.fromXmlElement,
              )
              ..registerResponseConverter(
                ColorDefaults.elementName,
                ColorDefaults.fromXmlElement,
              )
              ..registerResponseConverter(
                State.elementName,
                State.fromXmlElement,
              ),
            TextConverter()
              ..registerResponseConverter(Power.fromString)
              ..registerResponseConverter(Energy.fromString)
              ..registerResponseConverter(Temperature.fromString)
              ..registerResponseConverter(HkrTemperature.fromString)
              ..registerResponseConverter(Timestamp.fromString),
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

  /// Dispose of the client.
  ///
  /// By default, this will automatically logout the user.
  Future<void> dispose({bool withLogout = true}) async {
    if (withLogout) {
      await loginManager.logout();
    }

    client.dispose();
  }

  /// The AHA API client to access the actual API.
  late final AhaService aha = client.getService();
}
