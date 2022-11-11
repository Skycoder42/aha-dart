import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

import 'models/session_info.dart';
import 'models/sid.dart';

part 'login_service.chopper.dart';

/// @nodoc
@internal
@ChopperApi(baseUrl: '/login_sid.lua?version=2')
abstract class LoginService extends ChopperService {
  /// @nodoc
  static LoginService create([ChopperClient? client]) => _$LoginService(client);

  /// @nodoc
  @Get()
  Future<Response<SessionInfo>> getLoginStatus();

  /// @nodoc
  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> login({
    @Field() required String username,
    @Field() required String response,
  });

  /// @nodoc
  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> checkSessionValid(@Field() Sid sid);

  /// @nodoc
  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SessionInfo>> logout(
    @Field() Sid sid, {
    @Field() bool logout = true,
  });
}
