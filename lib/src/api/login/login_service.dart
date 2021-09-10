import 'package:chopper/chopper.dart';

import 'models/session_info.dart';

part 'login_service.chopper.dart';

@ChopperApi(baseUrl: '/login_sid.lua?version=2')
abstract class LoginService extends ChopperService {
  static LoginService create([ChopperClient? client]) => _$LoginService(client);

  @Get()
  Future<Response<SessionInfo>> getLoginStatus();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> login({
    @Field() required String username,
    @Field() required String response,
  });

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> checkSessionValid({
    @Field() required String sid,
  });

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> logout({
    @Field() required String sid,
    @Field() bool logout = true,
  });
}
