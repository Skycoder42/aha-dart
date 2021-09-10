import 'package:chopper/chopper.dart';

part 'aha_service.chopper.dart';

@ChopperApi(baseUrl: '/webservices/homeautoswitch.lua')
abstract class AhaService extends ChopperService {
  static AhaService create([ChopperClient? client]) => _$AhaService(client);

  @Get()
  Future<Response> get(
    @Query('switchcmd') String switchCmd,
  );
}
