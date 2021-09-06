import 'package:chopper/chopper.dart';

part 'login_service.chopper.dart';

@ChopperApi(baseUrl: '/login_sid.lua?version=2')
abstract class LoginService extends ChopperService {
  static LoginService create([ChopperClient? client]) => _$LoginService(client);

  @Get()
  Future<Response> getLoginStatus();
}
