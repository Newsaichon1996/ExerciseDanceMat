import 'dart:async';
import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_exercise/components/chart_element.dart';
import 'package:flutter_blue/flutter_blue.dart';


enum BleDeviceState { scanning, disconnected, connecting, connected }

class BleProvider with ChangeNotifier {
  BluetoothDevice? _device;
  int _heartRateValue = 0;
  int get heartRateValue => _heartRateValue;

  int _batteryLvl = 0;
  int get batteryLvl => _batteryLvl;
  set batteryLvl(int value) {
    _batteryLvl = value;
    notifyListeners();
  }

  List<BluetoothService>? _services;

  Function(int value)? _onHeartRateUpdate;
  void addHrUpdateListenter(Function(int value) listener) {
    _onHeartRateUpdate = listener;
  }

  void removeHrUpdateListener() {
    _onHeartRateUpdate = null;
  }

  Function(BleDeviceState state)? _connectionCallback;

  set connectionCallback(Function(BleDeviceState state) callback) {
    _connectionCallback = callback;
  }

  final List<ChartElement> _chartDatas = List.generate(20,
      (index) => ChartElement(0, DateTime.now().add(Duration(seconds: index))),
      growable: true);

  List<ChartElement> get chartDatas => _chartDatas;

  FlutterBlue? _ble = FlutterBlue.instance;
  BleDeviceState _deviceState = BleDeviceState.disconnected;
  BleDeviceState get deviceState => _deviceState;

  BluetoothCharacteristic? _hrChar;
  BluetoothCharacteristic? _battChar;

  BluetoothService? _hrService, _battService;
  StreamSubscription<List<int>>? _hrCharSup, _battCharSup;

  set deviceState(BleDeviceState value) {
    _deviceState = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _ble = null;
    super.dispose();
  }

  void connectDevice(BluetoothDevice? device) async {
    _device = device;
    _device?.state.listen((event) {
      switch (event) {
        case BluetoothDeviceState.disconnected:
          _deviceState = BleDeviceState.disconnected;
          break;
        case BluetoothDeviceState.connecting:
          _deviceState = BleDeviceState.connecting;
          break;
        case BluetoothDeviceState.connected:
          _deviceState = BleDeviceState.connected;
          if (_hrChar != null) {
            _hrChar?.setNotifyValue(true);
            _hrCharSup = _hrChar?.value.listen(dataListen);
          }
          if (_battChar != null) {
            _battChar?.setNotifyValue(true);
            _battCharSup = _battChar?.value.listen(battDataListen);
          }
          break;
        case BluetoothDeviceState.disconnecting:
          _deviceState = BleDeviceState.disconnected;
          _hrCharSup?.cancel();
          _hrCharSup = null;
          _battCharSup?.cancel();
          _battCharSup = null;
          break;
      }
      _connectionCallback?.call(_deviceState);
      notifyListeners();
    });
    await _device?.connect(timeout: const Duration(minutes: 10));

    var connectedDeivces = await _ble?.connectedDevices;
    if (connectedDeivces == null) return;
    if (connectedDeivces
        .where((element) => element.id == _device?.id)
        .isEmpty) {
      return;
    }

    _services = await device?.discoverServices();

    if (_services == null) return;
    if (_services!.isEmpty) return;

    _hrService = _services?.firstWhere(
        (element) => element.uuid.toString().toLowerCase().contains('180d'));
    _battService = _services?.firstWhere(
        (element) => element.uuid.toString().toLowerCase().contains('180f'));

    if (_hrService == null) return;

    _hrChar = _hrService?.characteristics.firstWhere(
        (element) => element.uuid.toString().toLowerCase().contains('2a37'));

    _battChar = _battService?.characteristics.firstWhere(
        (element) => element.uuid.toString().toLowerCase().contains('2a19'));

    if (_hrChar == null) return;

    await _hrChar?.setNotifyValue(true);
    _hrCharSup = _hrChar?.value.listen(dataListen);

    if (_battChar == null) return;
    await _battChar?.setNotifyValue(true);
    _battCharSup = _battChar?.value.listen(battDataListen);
    _battChar?.read().then((value) {
      if (value.isNotEmpty) {
        batteryLvl = value[0];
        notifyListeners();
      }
    });
  }

  void battDataListen(List<int> value) {
    if (value.isNotEmpty) {
      batteryLvl = value[0];
      notifyListeners();
    }
  }

  void dataListen(List<int> value) {
    if (value.length >= 2) {
      _heartRateValue =
          Uint8List.fromList(value).buffer.asByteData().getUint16(0);
      if (_heartRateValue != 0 && _heartRateValue <= 500) {
        _chartDatas.removeAt(0);
        _chartDatas
            .add(ChartElement(_heartRateValue.toDouble(), DateTime.now()));
        _onHeartRateUpdate?.call(_heartRateValue);
        notifyListeners();
      }
    }
  }
}
