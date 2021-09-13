import 'package:chopper/chopper.dart';

part 'aha_service.chopper.dart';

@ChopperApi()
abstract class AhaService extends ChopperService {
  static const _baseUrl = '/webservices/homeautoswitch.lua';

  static AhaService create([ChopperClient? client]) => _$AhaService(client);

  @Get(path: '$_baseUrl?switchcmd=getswitchname')
  Future<Response<String>> getSwitchName(@Query() String ain);

  @Get(path: '$_baseUrl?switchcmd=getdevicelistinfos')
  Future<Response<Object>> getDeviceListInfos();
}
