import 'package:chopper/chopper.dart';

import 'models/device_list.dart';
import 'models/device_stats.dart';
import 'models/hkr_temperature.dart';
import 'models/percentage.dart';
import 'models/switch_action.dart';
import 'models/temperature.dart';

part 'aha_service.chopper.dart';

@ChopperApi()
abstract class AhaService extends ChopperService {
  static const _baseUrl = '/webservices/homeautoswitch.lua?switchcmd';

  static AhaService create([ChopperClient? client]) => _$AhaService(client);

  // all devices

  @Get(path: '$_baseUrl=getdevicelistinfos')
  Future<Response<DeviceList>> getDeviceListInfos();

  @Get(path: '$_baseUrl=getbasicdevicestats')
  Future<Response<DeviceStats>> getBasicDeviceStats(@Query() String ain);

  // switches

  @Get(path: '$_baseUrl=getswitchlist')
  Future<Response<List<String>>> getSwitchList();

  @Get(path: '$_baseUrl=setswitchon')
  Future<Response<bool>> setSwitchOn(@Query() String ain);

  @Get(path: '$_baseUrl=setswitchoff')
  Future<Response<bool>> setSwitchOff(@Query() String ain);

  @Get(path: '$_baseUrl=setswitchtoggle')
  Future<Response<bool>> setSwitchToggle(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchstate')
  Future<Response<bool?>> getSwitchState(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchpresent')
  Future<Response<bool>> getSwitchPresent(@Query() String ain);

  /// Returns the power in mW
  @Get(path: '$_baseUrl=getswitchpower')
  Future<Response<int?>> getSwitchPower(@Query() String ain);

  /// Returns the energy in Wh
  @Get(path: '$_baseUrl=getswitchenergy')
  Future<Response<int?>> getSwitchEnergy(@Query() String ain);

  @Get(path: '$_baseUrl=getswitchname')
  Future<Response<String>> getSwitchName(@Query() String ain);

  // temperature sensors

  @Get(path: '$_baseUrl=gettemperature')
  Future<Response<Temperature?>> getTemperature(@Query() String ain);

  // thermostats

  @Get(path: '$_baseUrl=gethkrtsoll')
  Future<Response<HkrTemperature?>> getHkrTSoll(@Query() String ain);

  @Get(path: '$_baseUrl=gethkrkomfort')
  Future<Response<HkrTemperature?>> getHkrKomfort(@Query() String ain);

  @Get(path: '$_baseUrl=gethkrabsenk')
  Future<Response<HkrTemperature?>> getHkrAbsenk(@Query() String ain);

  @Get(path: '$_baseUrl=sethkrtsoll')
  Future<Response<void>> setHkrTSoll(
    @Query() String ain,
    @Query('param') HkrTemperature temperature,
  );

  // templates

  // @Get(path: '$_baseUrl=gettemplatelistinfos')
  // Future<Response<dynamic>> getTemplateListInfos();

  // @Get(path: '$_baseUrl=applytemplate')
  // Future<Response<void>> applyTemplate(@Query() String ain);

  // simple on off

  @Get(path: '$_baseUrl=setsimpleonoff')
  Future<Response<void>> setSimpleOnOff(
    @Query() String ain,
    @Query('onoff') SwitchAction onOff,
  );

  /// Level must be [0, 255]
  @Get(path: '$_baseUrl=setlevel')
  Future<Response<void>> setLevel(@Query() String ain, @Query() int level);

  @Get(path: '$_baseUrl=setlevelpercentage')
  Future<Response<void>> setLevelPercentage(
    @Query() String ain,
    @Query() Percentage level,
  );
}
