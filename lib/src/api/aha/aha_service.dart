import 'package:chopper/chopper.dart';

import 'models/device_list.dart';
import 'models/optional.dart';
import 'models/switch_status.dart';

part 'aha_service.chopper.dart';

@ChopperApi()
abstract class AhaService extends ChopperService {
  static const _baseUrl = '/webservices/homeautoswitch.lua?switchcmd';

  static AhaService create([ChopperClient? client]) => _$AhaService(client);

  // all devices

  @Get(path: '$_baseUrl=getdevicelistinfos')
  Future<Response<DeviceList>> getDeviceListInfos();

  // switches

  @Get(path: '$_baseUrl=getswitchlist')
  Future<Response<String>> getSwitchList();

  @Get(path: '$_baseUrl=setswitchon')
  Future<Response<SwitchStatus>> setSwitchOn(@Query() String ain);

  @Get(path: '$_baseUrl=setswitchoff')
  Future<Response<SwitchStatus>> setSwitchOff(@Query() String ain);

  @Get(path: '$_baseUrl=setswitchtoggle')
  Future<Response<SwitchStatus>> setSwitchToggle(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchstate')
  Future<Response<Optional<SwitchStatus>>> getSwitchState(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchpresent')
  Future<Response<SwitchStatus>> getSwitchPresent(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchpower')
  Future<Response<Optional<double>>> getSwitchPower(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchenergy')
  Future<Response<Optional<double>>> getSwitchEnergy(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchname')
  Future<Response<String>> getSwitchName(@Query() String ain);
}
