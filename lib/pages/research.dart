import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../widgets/hover_button.dart';

class Research extends StatefulWidget {
  const Research({super.key});

  @override
  State<Research> createState() => _ResearchState();
}

class _ResearchState extends State<Research> {
  bool isChecked11 = false;
  bool isChecked12 = false;
  bool isChecked21 = false;
  bool isChecked22 = false;
  bool isChecked31 = false;
  bool isChecked32 = false;
  bool isChecked41 = false;
  bool isChecked42 = false;
  bool isChecked51 = false;
  bool isChecked52 = false;
  bool isChecked61 = false;
  bool isChecked62 = false;
  bool isChecked71 = false;
  bool isChecked72 = false;

  int yes = 0;
  int no = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('แบบประเมินความพร้อมก่อนการออกกำลังกาย',
              style: TextStyle(fontSize: 20))),
      body: Row(
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flexible(flex: 1, child: Container()),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        'โปรดตอบคำถามเหล่านี้ค่อยๆอ่านอย่างใคร่ครวญและตอบด้วยความสัตย์จริงว่า',
                        style: TextStyle(fontSize: 20)),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        'เคย/เคย หรือ ไม่เคย/ไม่เคย เพื่อประเมินความปลอดภัยก่อนการออกกำลังกาย',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(flex: 1, child: Container()),
                  const Flexible(
                    flex: 2,
                    child: Text(
                        '1.แพทย์ที่ตรวจรักษาเคยบอกหรือไม่ว่า ท่านเคยความผิดปกติของหัวใจและควรทำกิจกรรมการออกกำลังกาย \nภายใต้คำแนะนำ ของแพทย์เท่าน้น',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked11,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked11 = value!;
                                    isChecked12 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked12,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked12 = value!;
                                    isChecked11 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '2.ท่านเคยความรู้สึกเจ็บปวดหรือแน่นบริเวณหน้าอกขณะทำกิจกรรมออกกำลังกายหรือไม่',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked21,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked21 = value!;
                                    isChecked22 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked22,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked22 = value!;
                                    isChecked21 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '3.ในเดือนที่ผ่านมา ท่านเคยเคยอาการเจ็บแน่นหน้าอกในขณะที่อยู่ฉยๆโดยไม่ได้ทำกิจกรรมออกกำลังกายหรือไม่',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked31,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked31 = value!;

                                    isChecked32 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked32,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked32 = value!;
                                    isChecked31 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '4.ท่านเคยอาการสูญเสียการทรงตัว (ยืนหรือเดินเซ) เนื่องมาจากอาการเวียนศีรษะหรือไม่ หรือท่านเคยเป็นลมหมดสติหรือไม่',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked41,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked41 = value!;
                                    isChecked42 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked42,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked42 = value!;
                                    isChecked41 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '5.ท่านเคยปัญหาที่กระดูกหรือข้อต่อ ซึ่งจะเคยอาการแย่ลง ถ้าท่านทำกิจกรรมออกกำลังกายหรือไม่ ',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked51,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked51 = value!;
                                    isChecked52 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked52,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked52 = value!;
                                    isChecked51 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '6.แพทย์ที่ตรวจรักษาเคยการสั่งยารักษาโรคความดันโลหิตสูง หรือความผิดปกติของหัวใจให้ท่านหรือไม่',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked61,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked61 = value!;
                                    isChecked62 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked62,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked62 = value!;
                                    isChecked61 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  const Flexible(
                    flex: 1,
                    child: Text(
                        '7.เท่าที่ท่านทราบยังเคยเหตุผลอื่นๆ อีกหรือไม่ที่ทำให้ท่านไม่สามารถทำกิจกรรมออกกำลังกายได้',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked71,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked71 = value!;
                                    isChecked72 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child:
                                  Text('เคย', style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                          Flexible(
                            flex: 1,
                            child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.blue,
                                value: isChecked72,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked72 = value!;
                                    isChecked71 = false;
                                  });
                                }),
                          ),
                          const Flexible(
                              flex: 1,
                              child: Text('ไม่เคย',
                                  style: TextStyle(fontSize: 20))),
                          Flexible(flex: 2, child: Container()),
                        ],
                      )),
                  Center(
                    child: Flexible(
                      flex: 1,
                      child: HoverButton(
                        size: const Size(180, 60),
                        onTap: () {
                          check();
                        },
                        color: const Color.fromARGB(255, 253, 213, 210),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'เสร็จสิ้น',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  void check() async {
    if ((isChecked11 || isChecked12) &&
        (isChecked21 || isChecked22) &&
        (isChecked31 || isChecked32) &&
        (isChecked41 || isChecked42) &&
        (isChecked51 || isChecked52) &&
        (isChecked61 || isChecked62) &&
        (isChecked71 || isChecked72) == true) {
      recheck();
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'กรุณาตอบให้ครบทุกคำถาม',
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
  }

  void recheck() async {
    if (isChecked11 ||
        isChecked21 ||
        isChecked31 ||
        isChecked41 ||
        isChecked51 ||
        isChecked61 ||
        isChecked71 == true) {
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ขอให้ท่านปรึกษาแพทย์/นักกายภาพบำบัดก่อนที่ท่านจะเริ่มออกกำลังกาย',
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      'เสร็จสิ้น',
                      style: TextStyle(fontSize: 26),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      Navigator.pushNamed(context, '/');
    }
  }
}
