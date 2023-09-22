import 'package:app_exercise/pages/research.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:app_exercise/components/database.dart';
import 'package:app_exercise/components/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> _genderItem = ['ชาย', 'หญิง'];
  String _gender = 'ชาย';
  //DateTime _dob = DateTime(1900);
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  final PageController _pageController = PageController();
  RangeValues hrRange = const RangeValues(50, 150);

  final MyDataBase _dataBase = MyDataBase();

  final TextEditingController _nameEdt = TextEditingController();
  final TextEditingController _lastNameEdt = TextEditingController();
  final TextEditingController _ageEdt = TextEditingController();
  // final TextEditingController _hnEdt = TextEditingController();
  // final TextEditingController _passwordEdt = TextEditingController();
  // final TextEditingController _noteEdt = TextEditingController();
  // final TextEditingController _durationHrEdt = TextEditingController();
  // final TextEditingController _durationMinEdt = TextEditingController();
  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        if (_pageController.page!.toInt() == 0) {
          crossFadeState = CrossFadeState.showFirst;
        } else {
          crossFadeState = CrossFadeState.showSecond;
        }
      });
    });
    _dataBase.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_rounded,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // )
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 64,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCrossFade(
                crossFadeState: crossFadeState,
                duration: const Duration(milliseconds: 300),
                firstCurve: Curves.easeOutCubic,
                sizeCurve: Curves.easeOutCubic,
                secondCurve: Curves.easeOutCubic,
                firstChild: Image.asset(
                  'assets/images/man-holding-sign-up-form.png',
                  width: 350,
                ),
                secondChild: Image.asset(
                  'assets/images/love-exercise.png',
                  width: 350,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 400,
                height: MediaQuery.of(context).size.height - 250,
                child: PageView(
                  clipBehavior: Clip.hardEdge,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                'ลงทะเบียน',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(right: 64),
                            padding: const EdgeInsets.all(16),
                            decoration: ShapeDecoration(
                                color: Colors.black87,
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 16,
                                      color: Colors.grey.shade300,
                                      spreadRadius: 8)
                                ],
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        'ข้อมูลส่วนบุคคล',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                  ), 
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 128,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child: Text('ชื่อ *',
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                        Flexible(
                                            child: TextField(
                                                controller: _nameEdt,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder()))),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text('นามสุกล *',
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                        Flexible(
                                            child: TextField(
                                                keyboardType:
                                                    TextInputType.name,
                                                controller: _lastNameEdt,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder())))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Text('อายุ *',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                      SizedBox(
                                          width: 100,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _ageEdt,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            maxLength: 2,
                                          )),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text('เพศ',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                      Row(children: [
                                        PopupMenuButton(
                                          itemBuilder: (context) {
                                            return _genderItem
                                                .map((e) => PopupMenuItem(
                                                      value: e,
                                                      child: Text(e,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ))
                                                .toList();
                                          },
                                          onSelected: (String value) {
                                            setState(() {
                                              _gender = value;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: ShapeDecoration(
                                                color: Colors.grey.shade100,
                                                shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16))),
                                            child: Row(
                                              children: [
                                                Text(_gender,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20)),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // const Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 16),
                                        //   child: Text('วัน เดือน ปี เกิด',
                                        //       style: TextStyle(fontSize: 20)),
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        //     var date = await showDatePicker(
                                        //         context: context,
                                        //         initialDate: DateTime.now(),
                                        //         firstDate: DateTime(1900),
                                        //         lastDate: DateTime.now());
                                        //     if (date != null) {
                                        //       setState(() {
                                        //         _dob = date;
                                        //       });
                                        //     }
                                        //   },
                                        //   child: Container(
                                        //     padding: const EdgeInsets.all(12),
                                        //     decoration: ShapeDecoration(
                                        //         color: Colors.grey.shade100,
                                        //         shape:
                                        //             ContinuousRectangleBorder(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(16))),
                                        //     child: Row(
                                        //       children: [
                                        //         Text(
                                        //           DateFormat.yMMMEd()
                                        //               .format(_dob),
                                        //           style: const TextStyle(
                                        //               color: Colors.black,
                                        //               fontSize: 20),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ])
                                    ],
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 16),
                                  //     child: Text(
                                  //       'ข้อมูลโรงพยาบาล',
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .titleLarge,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     const Padding(
                                  //       padding: EdgeInsets.only(right: 16),
                                  //       child: Text('HN'),
                                  //     ),
                                  //     Flexible(
                                  //         child: TextField(
                                  //       controller: _hnEdt,
                                  //     )),
                                  //     const Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: 16),
                                  //       child: Text('รหัสผ่าน'),
                                  //     ),
                                  //     Flexible(
                                  //         child: TextField(
                                  //       controller: _passwordEdt,
                                  //     ))
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // TextField(
                                  //   controller: _noteEdt,
                                  //   decoration: const InputDecoration(
                                  //       hintText: 'อื่นๆ'),
                                  //   maxLines: 2,
                                  // ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 60)),
                                      onPressed: () {
                                        _addUser();
                                      },
                                      child: const Text(
                                        'ต่อไป',
                                        style: TextStyle(fontSize: 26),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser() async {
    if (_nameEdt.text.isEmpty ||
        _lastNameEdt.text.isEmpty ||
        _ageEdt.text.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Please fill in your information *',
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
      );

      return;
    }

    var user = User(
      name: _nameEdt.text,
      lastName: _lastNameEdt.text,
      age: int.tryParse(_ageEdt.text) ?? 0,
      gender: _gender,
    );
    print(user);
    // dob: _dob.millisecondsSinceEpoch.toString(),
    // hn: _hnEdt.text,
    // password: _passwordEdt.text,
    // note: _noteEdt.text,
    // maxHr: hrRange.end.toInt(),
    // minHr: hrRange.start.toInt(),
    // duration: const Duration(hours: 0, minutes: 40).inMinutes);

    await _dataBase.writeUser(user);
    print(_dataBase);
    Navigator.pushNamed(context, '/research');
  }
}
