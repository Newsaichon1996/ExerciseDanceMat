import 'dart:async';
import 'package:app_exercise/components/chart_element.dart';
import 'package:app_exercise/components/user.dart';
import 'package:app_exercise/widgets/Padtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:video_player/video_player.dart';
import 'package:csv/csv.dart';
import 'package:get/get.dart';

import '../providers/ble_provider.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> with TickerProviderStateMixin {
  // Keypad
  PhysicalKeyboardKey SelectPad = PhysicalKeyboardKey.gameButton9;
  PhysicalKeyboardKey StartPad = PhysicalKeyboardKey.gameButton10;
  PhysicalKeyboardKey Pad7 = PhysicalKeyboardKey.gameButton7; //North_west
  PhysicalKeyboardKey Pad8 = PhysicalKeyboardKey.gameButton3; //North
  PhysicalKeyboardKey Pad9 = PhysicalKeyboardKey.gameButton8; //North_east
  PhysicalKeyboardKey Pad4 = PhysicalKeyboardKey.gameButton1; //West
  PhysicalKeyboardKey Pad5 = PhysicalKeyboardKey.arrowDown; //Center
  PhysicalKeyboardKey Pad6 = PhysicalKeyboardKey.gameButton4; //East
  PhysicalKeyboardKey Pad1 = PhysicalKeyboardKey.gameButton6; //South_west
  PhysicalKeyboardKey Pad2 = PhysicalKeyboardKey.gameButton2; //South
  PhysicalKeyboardKey Pad3 = PhysicalKeyboardKey.gameButton5; //South_east

  // Initial basecolor of the icon
  Color baseColor = Colors.lightGreen.shade100; //base
  Color activeColor = Colors.red; //bomb
  Color actionColor = Colors.amber; //fire

  // check เช็ค state Guide
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool check6 = false;
  bool check7 = false;
  bool check8 = false;
  bool check9 = false;

  // correct เช็ค state ตอนเหยียบ
  bool correct1 = false;
  bool correct2 = false;
  bool correct3 = false;
  bool correct4 = false;
  bool correct5 = false;
  bool correct6 = false;
  bool correct7 = false;
  bool correct8 = false;
  bool correct9 = false;

  bool visible1 = false;
  bool visible2 = false;
  bool visible3 = false;
  bool visible4 = false;
  bool visible5 = false;
  bool visible6 = false;
  bool visible7 = false;
  bool visible8 = false;
  bool visible9 = false;

  bool recheck1 = false;
  bool recheck2 = false;
  bool recheck3 = false;
  bool recheck4 = false;
  bool recheck5 = false;
  bool recheck6 = false;
  bool recheck7 = false;
  bool recheck8 = false;
  bool recheck9 = false;

  // keycheck
  bool isScoreIncremented = false;
  bool isKeyPressed = false; // Track the key press state
  bool statestart = false;
  bool action = false;

  // width
  double samplewidth = 60;
  double dancewidth = 160;

  // Profile
  String _name = '';
  String _lastName = '';
  String _gender = '';
  int _age = 0;
  int _maxhr = 0;
  User user = Get.find();

  // Animation & Video
  late AnimationController _animationController;
  Image bomb = Image.asset('assets/images/bomb.png');
  Image fire = Image.asset('assets/images/vyond-vyond-effect.gif');
  late VideoPlayerController _controller;
  bool switchvideo = false;

  // etc
  String Sub = '';
  double Score = 0;
  int maxScore = 0;
  List<String> Totalvideo = [
    'assets/videos/MP4/Warmup1min1.mp4',
    'assets/videos/MP4/Hip_abduction_aduction.mp4',
    'assets/videos/MP4/Hip_flexion_extension.mp4',
    'assets/videos/MP4/Boxing.mp4',
  ];
  int lastState = 0;
  int _videoIndex = 0;
  int loopIndex = 1;

  late Timer timer;

  @override
  void initState() {
    // loadVideoPlayer();
    loadVideoPlayertotal();
    super.initState();
    // Registering the key event listener
    RawKeyboard.instance.addListener(_handleKeyPress);
    _name = user.name;
    _lastName = user.lastName;
    _age = user.age;
    _gender = user.gender;
    if (_gender == 'Male') {
      _maxhr = (214 - (0.8 * _age)).toInt();
    } else if (_gender == 'Female') {
      _maxhr = (209 - (0.7 * _age)).toInt();
    }
    Sub = 'Press Start to Play';
    _loadCSV();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          })
          ..repeat();
  }

  loadVideoPlayertotal() {
    _controller = VideoPlayerController.asset(Totalvideo[_videoIndex]);
    _controller.addListener(videoListener);
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  void videoListener() {
    var video = _controller.value;
    if (video != null) {
      if ((video.duration.inSeconds == video.position.inSeconds) &&
          (!video.isPlaying)) {
        _controller.removeListener(videoListener);
        _nextVideo();
      }
    }
  }

  void _nextVideo() async {
    if (_videoIndex < Totalvideo.length - 1) {
      _videoIndex++; // Move to the next video index
      loadVideoPlayertotal();
      _controller.play(); // Load and play the next video
      // } else {
      //   // If the last video ends, loop back to the first video
      //   setState(() {
      //     _controller.pause();
      //     _videoIndex = 0;
      //     loadVideoPlayer();
      //   });
    }
  }

  @override
  void dispose() {
    // Removing the key event listener
    RawKeyboard.instance.removeListener(_handleKeyPress);
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Poststart() {
    setState(() {
      correct1 = false;
      correct2 = false;
      correct3 = false;
      correct4 = false;
      correct5 = false;
      correct6 = false;
      correct7 = false;
      correct8 = false;
      correct9 = false;
      visible1 = false;
      visible2 = false;
      visible3 = false;
      visible4 = false;
      visible5 = false;
      visible6 = false;
      visible7 = false;
      visible8 = false;
      visible9 = false;
      action = false;
    });
  }

  List<List<dynamic>> _data = [];
  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/csv/data.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      _data = listData;
    });
  }

  int k = 1;
  Exam() {
    if (statestart == false) {
      _controller.play();
      setState(() {});
      _loadCSV();
      statestart = true;
      Score = 0;
      maxScore = _data.length - 1;

      Timer.periodic(const Duration(milliseconds: 1200), (timer) {
        Sub = 'Press Bomb!';
        Poststart();
        if (k >= _data.length) {
          timer.cancel();
          statestart = false;
          k = 1;
          Poststart();
          Sub = 'Press Start to Play';
          _controller.pause();
          _controller.seekTo(const Duration(seconds: 0));
          setState(() {});
        }

        if ((_data[k][1]) == 1) {
          correct1 = true;
          visible1 = true;
        } else if (_data[k][1] == 2) {
          correct2 = true;
          visible2 = true;
        } else if (_data[k][1] == 3) {
          correct3 = true;
          visible3 = true;
        } else if (_data[k][1] == 4) {
          correct4 = true;
          visible4 = true;
        } else if (_data[k][1] == 5) {
          correct5 = true;
          visible5 = true;
        } else if (_data[k][1] == 6) {
          correct6 = true;
          visible6 = true;
        } else if (_data[k][1] == 7) {
          correct7 = true;
          visible7 = true;
        } else if (_data[k][1] == 8) {
          correct8 = true;
          visible8 = true;
        } else if (_data[k][1] == 9) {
          correct9 = true;
          visible9 = true;
        } else if (_data[k][1] == 0) {
          Sub = 'Warmup';
        }
        k++;
      });
    }
  }

  void End() {
    if (k >= 5) {
      k = _data.length;
      _controller.removeListener(videoListener);
      _videoIndex = 0;
      _controller = VideoPlayerController.asset(Totalvideo[_videoIndex]);
      _controller.initialize().then((_) {
        setState(() {});
      });
    }
  }

  void checkbox() {
    if (check1 && correct1) {
      // setState(() {
      if (!isScoreIncremented) {
        if (recheck1 == false) {
          Score++;
          recheck1 = true;
        }
        action = true;
        isScoreIncremented = true;
        Timer(const Duration(milliseconds: 1000), () {
          recheck1 = false;
        });
      }
      // });
    } else if (check2 && correct2) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck2 == false) {
            Score++;
            recheck2 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck2 = false;
          });
        }
      });
    } else if (check3 && correct3) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck3 == false) {
            Score++;
            recheck3 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck3 = false;
          });
        }
      });
    } else if (check4 && correct4) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck4 == false) {
            Score++;
            recheck4 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck4 = false;
          });
        }
      });
    } else if (check5 && correct5) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck5 == false) {
            Score++;
            recheck5 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck5 = false;
          });
        }
      });
    } else if (check6 && correct6) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck6 == false) {
            Score++;
            recheck6 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck6 = false;
          });
        }
      });
    } else if (check7 && correct7) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck7 == false) {
            Score++;
            recheck7 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck7 = false;
          });
        }
      });
    } else if (check8 && correct8) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck8 == false) {
            Score++;
            recheck8 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck8 = false;
          });
        }
      });
    } else if (check9 && correct9) {
      setState(() {
        if (!isScoreIncremented) {
          if (recheck9 == false) {
            Score++;
            recheck9 = true;
          }
          isScoreIncremented = true;
          action = true;
          Timer(const Duration(milliseconds: 1000), () {
            recheck9 = false;
          });
        }
      });
    } else {
      isScoreIncremented = false;
    }
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.data.physicalKey == Pad1 && !isKeyPressed) {
        setState(() {
          check1 = true;
        });
      } else if (event.data.physicalKey == Pad2 && !isKeyPressed) {
        setState(() {
          check2 = true;
        });
      } else if (event.data.physicalKey == Pad3 && !isKeyPressed) {
        setState(() {
          check3 = true;
        });
      } else if (event.data.physicalKey == Pad4 && !isKeyPressed) {
        setState(() {
          check4 = true;
        });
      } else if (event.data.physicalKey == Pad5 && !isKeyPressed) {
        setState(() {
          check5 = true;
        });
      } else if (event.data.physicalKey == Pad6 && !isKeyPressed) {
        setState(() {
          check6 = true;
        });
      } else if (event.data.physicalKey == Pad7 && !isKeyPressed) {
        setState(() {
          check7 = true;
        });
      } else if (event.data.physicalKey == Pad8 && !isKeyPressed) {
        setState(() {
          check8 = true;
        });
      } else if (event.data.physicalKey == Pad9 && !isKeyPressed) {
        setState(() {
          check9 = true;
        });
      } else if (event.data.physicalKey == StartPad && !isKeyPressed) {
        setState(() {
          Exam();
        });
      } else if (event.data.physicalKey == SelectPad && !isKeyPressed) {
        setState(() {
          End();
        });
      }

      // Handle other keys similarly
    } else if (event is RawKeyUpEvent) {
      if (event.data.physicalKey == Pad1) {
        setState(() {
          check1 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad2) {
        setState(() {
          check2 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad3) {
        setState(() {
          check3 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad4) {
        setState(() {
          check4 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad5) {
        setState(() {
          check5 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad6) {
        setState(() {
          check6 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad7) {
        setState(() {
          check7 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad8) {
        setState(() {
          check8 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == Pad9) {
        setState(() {
          check9 = false;
          isKeyPressed = false;
        });
      } else if (event.data.physicalKey == StartPad) {
      } else if (event.data.physicalKey == SelectPad) {}
      // Handle other keys similarly
    }
    checkbox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$_name $_lastName, $_age ",
            style: const TextStyle(fontSize: 20)),
      ),
      body: Row(
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 8,
            child: Center(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    // width: 50,
                    height: 50,
                    child: const Text(
                      "Dance Mat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible7 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  // width: dancewidth,
                                  // height: dancewidth,
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible8 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  // width: dancewidth,
                                  // height: dancewidth,
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible9 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  // width: dancewidth,
                                  // height: dancewidth,
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible4 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible5 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible6 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible1 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible2 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padtable(
                            child: AnimatedOpacity(
                                opacity: visible3 ? 1 : 0,
                                duration: const Duration(seconds: 0),
                                child: Container(
                                  color: action ? actionColor : activeColor,
                                  alignment: Alignment.center,
                                  child: action ? fire : bomb,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(Sub,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          Flexible(
              flex: 4,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Heart Rate',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: 50,
                          height: 50,
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            // iconSize: 30 + (_animationController.value * 5),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          '${context.watch<BleProvider>().heartRateValue}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        Expanded(
                            child: Text(
                          'Score : $Score',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SfCartesianChart(
                      backgroundColor: Colors.lightGreen.shade100,
                      primaryXAxis: DateTimeAxis(
                        isVisible: false,
                        borderColor: Colors.black,
                        //dateFormat: DateFormat.Hms(),
                        //majorGridLines: MajorGridLines(color: Colors.red),
                        labelStyle: const TextStyle(color: Colors.black),
                        //title: AxisTitle(text: 'Time',textStyle: const TextStyle(color: Colors.black))
                      ),
                      primaryYAxis: NumericAxis(
                          maximum: (_maxhr).toDouble(),
                          // (context.watch<BleProvider>().heartRateValue) + 10,
                          minimum: (_maxhr * 0.35).toInt().toDouble(),
                          // (context.watch<BleProvider>().heartRateValue) - 10,
                          //     ? hr - 10r
                          //     : _minHrWarning - 10,
                          plotBands: [
                            PlotBand(
                              start: _maxhr * 0.5,
                              end: (_maxhr * 0.35).toInt(),
                              text: "Zone0",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.lightGreen.shade100,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            PlotBand(
                              start: _maxhr * 0.6,
                              end: _maxhr * 0.5,
                              text: "Zone1",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.green.shade200,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            PlotBand(
                              start: _maxhr * 0.7,
                              end: _maxhr * 0.6,
                              text: "Zone2",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.green.shade400,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            PlotBand(
                              start: _maxhr * 0.8,
                              end: _maxhr * 0.7,
                              text: "Zone3",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.yellow.shade400,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            PlotBand(
                              start: _maxhr * 0.9,
                              end: _maxhr * 0.8,
                              text: "Zone4",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.orange.shade400,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            PlotBand(
                              start: _maxhr * 1,
                              end: _maxhr * 0.9,
                              text: "Zone5",
                              //borderColor: const Color.fromARGB(255, 71, 41, 243),
                              borderWidth: 1,
                              color: Colors.red.shade300,
                              horizontalTextAlignment: TextAnchor.end,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          interval: 4,
                          //majorGridLines: const MajorGridLines(color: Colors.red),
                          labelStyle: const TextStyle(color: Colors.black),
                          title: AxisTitle(
                              text: 'Heart Rate',
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 12))),
                      series: [
                        LineSeries<ChartElement, DateTime>(
                          animationDuration: 0,
                          color: Colors.red,
                          dataSource: context.watch<BleProvider>().chartDatas,
                          xValueMapper: (datum, index) => datum.timeStamp,
                          yValueMapper: (datum, index) => datum.value,
                        )
                      ],
                    ),
                  ),
                  // Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 6,
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),

                  // Expanded(flex: 1, child: FloatingActionButton(onPressed: (){
                  //   _controller.play();
                  // })),
                  Expanded(child: Container())
                ],
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
