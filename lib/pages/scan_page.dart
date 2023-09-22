import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:lottie/lottie.dart';
import 'package:app_exercise/providers/ble_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ScanDevicePage extends StatefulWidget {
  const ScanDevicePage({Key? key}) : super(key: key);

  @override
  _ScanDevicePageState createState() => _ScanDevicePageState();
}

class _ScanDevicePageState extends State<ScanDevicePage> {
  //static const String MI_UUID = '0000180d-0000-1000-8000-00805f9b34fb';
  final _ble = FlutterBlue.instance;
  StreamSubscription? _scanSubscription;
  BluetoothDevice? _device;
  bool _isOver = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/polar_oh1_bg.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back_rounded,
          //     color: Colors.white,
          //   ),
          //   iconSize: 32,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        body: _device == null
            ? Container(
                margin: const EdgeInsets.only(bottom: 64),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 400,
                      height: 400,
                      child: Lottie.asset(
                          'assets/lotties/12054-scanning-faceid.json'),
                    ),
                    const Text(
                      'Scanning Device',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ))
            : Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 300),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MouseRegion(
                          onHover: (event) {
                            setState(() {
                              _isOver = true;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              _isOver = false;
                            });
                          },
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isOver = false;
                              });
                              connectDevice();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: AnimatedContainer(
                                  curve: Curves.easeInOutCirc,
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200
                                                .withOpacity(0.2),
                                            blurRadius: 16,
                                            spreadRadius: 4)
                                      ],
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white
                                          .withOpacity(_isOver ? 1 : 0.5)),
                                  duration: const Duration(milliseconds: 200),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_device?.name ?? '',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30)),
                                      Text(
                                        _device?.id.toString() ?? '',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 26),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  context.watch<BleProvider>().deviceState ==
                          BleDeviceState.connecting
                      ? Positioned(
                          bottom: 32,
                          child: FadeInUp(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Lottie.asset(
                                        'assets/lotties/indicator.json',
                                        width: 48),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text('Connecting'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
      ),
    );
  }

  void startScan() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      _ble.startScan(timeout: const Duration(minutes: 10));
      _scanSubscription = _ble.scanResults.listen((results) {
        var index = results
            .indexWhere((element) => element.device.name.contains('Polar'));
        if (index != -1) {
          var device = results[index].device;
          _scanSubscription?.cancel();
          Future.delayed(const Duration(seconds: 2)).then((value) {
            setState(() {
              _device ??= device;
            });
          });
        }
      });
    }
  }

  void connectDevice() {
    if (_device != null) {
      var provider = Provider.of<BleProvider>(context, listen: false);
      provider.connectionCallback = (BleDeviceState state) {
        if (state == BleDeviceState.connected) {
          if (mounted) {
            Navigator.pop(context);
            //Navigator.pushNamed(context, '/');
          }
        }
      };

      _ble.stopScan();
      provider.connectDevice(_device);

      context.read<BleProvider>().batteryLvl = 100;
    }
  }
}
