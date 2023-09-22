import 'package:app_exercise/components/user.dart';
import 'package:app_exercise/pages/exercise.dart';
import 'package:app_exercise/pages/home_page.dart';
// import 'package:exercise/pages/mode_page.dart';
import 'package:app_exercise/pages/profile.dart';
import 'package:app_exercise/pages/research.dart';
import 'package:app_exercise/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_exercise/providers/app_provider.dart';
import 'package:app_exercise/providers/ble_provider.dart';
import 'package:get/get.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => BleProvider())
    ],
    child:
    const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Get.put(User(
      name: '',
      lastName: '',
      age: 0,
      gender: 'Male',
      // dob: '0',
      // hn: '',
      // password: '',
      // note: '',
      // maxHr: 150,
      // minHr: 50,
      // duration: 30
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Excercise Dance Mat',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/scan': (context) => const ScanDevicePage(),
          '/profile': (context) => const Profile(),
          // '/mode': (context) => const Mode(),
          '/exercise': (context) => const Exercise(),
          '/research': (context) => const Research(),
        });
  }
}
