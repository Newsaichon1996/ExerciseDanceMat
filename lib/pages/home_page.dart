import 'dart:ui';

import 'package:app_exercise/components/database.dart';
import 'package:app_exercise/components/user.dart';
import 'package:app_exercise/pages/exercise.dart';
import 'package:app_exercise/pages/scan_page.dart';

import 'package:app_exercise/widgets/hover_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/ble_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyDataBase _dataBase = MyDataBase();

  @override
  void initState() {
    super.initState();
  }

  Future<List<User>> _getUsers() async {
    await _dataBase.open();
    var users = await _dataBase.queryUser();

    return users;
  }

  bool _checkPolarConnected() {
    var provider = Provider.of<BleProvider>(context, listen: false);
    if (provider.deviceState == BleDeviceState.connected) {
      //_zoneexercise();
      return true;
    }
    return false;
  }

  void _getPassword(User e) async {
    TextEditingController _controlrer = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              alignment: Alignment.center,
              backgroundColor: Colors.white.withOpacity(0.8),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: SizedBox(
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ใส่รหัสผ่าน',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _controlrer,
                            ),
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Align(
                      //       alignment: Alignment.centerRight,
                      //       child: ElevatedButton(
                      //           onPressed: () {
                      //             if (_controlrer.text == e.password) {
                      //               print('correct password');
                      //               Navigator.pop(context);
                      //               User user = Get.find();
                      //               user.name = e.name;
                      //               user.lastName = e.lastName;
                      //               user.age = e.age;
                      //               user.gender = e.gender;
                      //               // user.dob = e.dob;
                      //               // user.hn = e.hn;
                      //               // user.password = e.password;
                      //               // user.note = e.note;
                      //               // user.maxHr = e.maxHr;
                      //               // user.minHr = e.minHr;
                      //               // user.duration = e.duration;
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const Exercise(),
                      //                   ));
                      //             } else {
                      //               print('incorrect password');
                      //               Navigator.pop(context);
                      //               ScaffoldMessenger.of(context).showSnackBar(
                      //                   const SnackBar(
                      //                       backgroundColor: Color.fromARGB(
                      //                           255, 236, 91, 80),
                      //                       content:
                      //                           Text('รหัสผ่านไม่ถูกต้อง')));
                      //             }
                      //           },
                      //           child: const Text('ต่อไป'))),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _zoneexercise() async {
    var res = await showDialog(
      context: this.context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: FutureBuilder<List<User>>(
                future: _getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    var users = snapshot.data;
                    if (users?.isEmpty == false) {
                      return Wrap(
                        children: users!
                            .map((e) => SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: InkWell(
                                          onLongPress: () {
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder: (_) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            32.0),
                                                    child: Material(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              253,
                                                              213,
                                                              210),
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(() {
                                                                    // Update the UI here, if needed
                                                                  });
                                                                  await _dataBase
                                                                      .deleteUser(
                                                                          e);
                                                                  setState(() {
                                                                    // Update the UI after deletion
                                                                  });
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'ลบ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          onTap: () {
                                            Navigator.pop(context);
                                            User user = Get.find();
                                            user.name = e.name;
                                            user.lastName = e.lastName;
                                            user.age = e.age;
                                            user.gender = e.gender;
                                            //user.dob = e.dob;
                                            //user.hn = e.hn;
                                            //user.password = e.password;
                                            // user.note = e.note;
                                            // user.maxHr = e.maxHr;
                                            // user.minHr = e.minHr;
                                            // user.duration = e.duration;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Exercise(),
                                              ),
                                            );
                                            // _getPassword(e);
                                          },
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            width: 250,
                                            height: 150,
                                            decoration: ShapeDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                shadows: const [
                                                  BoxShadow(
                                                      blurRadius: 8,
                                                      spreadRadius: 4,
                                                      color: Colors.black)
                                                ],
                                                shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24))),
                                            //margin: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 253, 213, 210),
                                                      //     gradient:
                                                      //         LinearGradient(
                                                      //             colors: [
                                                      //   const Color.fromARGB(255, 253, 213, 210),
                                                      //   const Color.fromARGB(255, 253, 213, 210),
                                                      // ]),
                                                    ),
                                                    child: Text(
                                                      '${e.name} ${e.lastName}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'อายุ ${e.age}\nเพศ ${e.gender}',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      // Text(
                                                      //   'วดปห. เกิด ${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(e.dob)))}',
                                                      // ),
                                                      // Text(
                                                      //   'HN ${e.hn}',
                                                      // ),
                                                      // Row(
                                                      //   children: [
                                                      //     Icon(
                                                      //       Icons.timer,
                                                      //       color: Colors
                                                      //           .blueGrey,
                                                      //       size: 16,
                                                      //     ),
                                                      //     Text(
                                                      //       _printDuration(
                                                      //           Duration(
                                                      //               minutes:
                                                      //                   e.duration)),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      //const Center(child: Text('No user resisted.'));
                    }
                  }
                  return Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 200,
                    color: const Color.fromARGB(255, 253, 213, 210),
                    child: const Text(
                      'ยังไม่ได้ลงทะเบียน',
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  void _connectPolarDialog() async {
    var res = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'คุณยังไม่ได้เชื่อมต่อ Polar ต้องการเชื่อมต่อหรือไม่',
                    style: TextStyle(fontSize: 26)),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 80)),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text(
                          'เชื่อมต่อ',
                          style: TextStyle(fontSize: 24),
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            fixedSize: const Size(150, 80)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('ยกเลิก',
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 24))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    if (res != null) {
      if (res) {
        Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => const ScanDevicePage(),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Row(
              children: const [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                Text(
                  ' ลงทะเบียน',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Exercise',
                    style: TextStyle(fontSize: 60),
                  ),
                  Text(
                    'Dance Mat',
                    style: TextStyle(fontSize: 60),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 50))
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HoverButton(
                    size: const Size(300, 200),
                    onTap: () {
                      // if (_checkPolarConnected()) {
                      _zoneexercise();
                      // } else {
                      //   _connectPolarDialog();
                      // }
                    },
                    color: const Color.fromARGB(255, 253, 213, 210),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/play-button.png',
                          width: 80,
                          height: 80,
                        ),
                        const Text(
                          'เล่น',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  HoverButton(
                    size: const Size(300, 200),
                    onTap: () {
                      Navigator.pushNamed(context, '/scan');
                    },
                    color: const Color.fromARGB(255, 253, 213, 210),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/bluetooth.png',
                          width: 80,
                          height: 80,
                        ),
                        const Text(
                          'เชื่อมต่อ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
