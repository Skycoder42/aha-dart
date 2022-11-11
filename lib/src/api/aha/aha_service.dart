// ignore_for_file: public_member_api_docs

import 'package:chopper/chopper.dart';
import 'package:color/color.dart';
import 'package:meta/meta.dart';

import 'models/blind_state.dart';
import 'models/color_defaults.dart';
import 'models/device.dart';
import 'models/device_list.dart';
import 'models/device_stats.dart';
import 'models/energy.dart';
import 'models/hkr_temperature.dart';
import 'models/level.dart';
import 'models/percentage.dart';
import 'models/power.dart';
import 'models/subscription_state.dart';
import 'models/switch_action.dart';
import 'models/switch_duration.dart';
import 'models/temperature.dart';
import 'models/timestamp.dart';

part 'aha_service.chopper.dart';

@ChopperApi()
abstract class AhaService extends ChopperService {
  static const _baseUrl = '/webservices/homeautoswitch.lua?switchcmd';

  /// @nodoc
  @internal
  static AhaService create([ChopperClient? client]) => _$AhaService(client);

  // all devices / global

  @Get(path: '$_baseUrl=getdevicelistinfos')
  Future<Response<DeviceList>> getDeviceListInfos();

  @Get(path: '$_baseUrl=getdeviceinfos')
  Future<Response<Device>> getDeviceInfos(@Query() String ain);

  @Get(path: '$_baseUrl=getbasicdevicestats')
  Future<Response<DeviceStats>> getBasicDeviceStats(@Query() String ain);

  @Get(path: '$_baseUrl=setname')
  Future<Response<void>> setName(@Query() String ain, @Query() String name);

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

  @Get(path: '$_baseUrl=getswitchpower')
  Future<Response<Power?>> getSwitchPower(@Query() String ain);

  /// Returns the energy in Wh
  @Get(path: '$_baseUrl=getswitchenergy')
  Future<Response<Energy?>> getSwitchEnergy(@Query() String ain);

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
    @Query() HkrTemperature param,
  );

  @Get(path: '$_baseUrl=sethkrboost')
  Future<Response<Timestamp>> setHkrBoost(
    @Query() String ain, [
    @Query('endtimestamp') Timestamp endTimestamp = Timestamp.deactivated,
  ]);

  @Get(path: '$_baseUrl=sethkrwindowopen')
  Future<Response<Timestamp>> setHkrWindowOpen(
    @Query() String ain, [
    @Query('endtimestamp') Timestamp endTimestamp = Timestamp.deactivated,
  ]);

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

  // level controllable

  @Get(path: '$_baseUrl=setlevel')
  Future<Response<void>> setLevel(@Query() String ain, @Query() Level level);

  @Get(path: '$_baseUrl=setlevelpercentage')
  Future<Response<void>> setLevelPercentage(
    @Query() String ain,
    @Query() Percentage level,
  );

  // light bulbs

  @Get(path: '$_baseUrl=setcolor')
  Future<Response<void>> _setColor(
    @Query() String ain, {
    @Query() required int hue,
    @Query() required int saturation,
    @Query() required SwitchDuration duration,
  });

  Future<Response<void>> setColorHs(
    String ain,
    HsvColor color,
    SwitchDuration duration,
  ) =>
      _setColor(
        ain,
        hue: color.h.round(),
        saturation: color.s.round(),
        duration: duration,
      );

  Future<Response<void>> setColorV(
    String ain,
    HsvColor color,
  ) =>
      setLevel(
        ain,
        // ignore: invalid_use_of_visible_for_overriding_member
        Percentage(rawValue: color.v.round()).toLevel(),
      );

  @Get(path: '$_baseUrl=setcolortemperature')
  Future<Response<void>> setColorTemperature(
    @Query() String ain,
    @Query() int temperature,
    @Query() SwitchDuration duration,
  );

  @Get(path: '$_baseUrl=getcolordefaults')
  Future<Response<ColorDefaults>> getColorDefaults();

  // blinds

  @Get(path: '$_baseUrl=setblind')
  Future<Response<void>> setBlind(
    @Query() String ain,
    @Query() BlindState target,
  );

  // device registration

  @Get(path: '$_baseUrl=startulesubscription')
  Future<Response<void>> startUleSubscription();

  @Get(path: '$_baseUrl=getsubscriptionstate')
  Future<Response<State>> getSubscriptionState();
}
