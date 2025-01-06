import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_nest/screen/home_screen/chat_input_field.dart';
import 'package:talk_nest/screen/home_screen/widget/chat_status_filter.dart';
import 'package:talk_nest/screen/home_screen/widget/order_chat.dart';
import 'package:talk_nest/service/getx.dart';
import 'package:talk_nest/service/shared.dart';
import 'package:talk_nest/widget/menu_dialogue.dart';
import 'package:talk_nest/widget/order_dialogue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MessageController messageController = Get.put(MessageController());
  Duration? _position;
  Duration? _duration;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  PlayerState? _playerState;
  final List<AudioPlayer> _audioPlayers = [];
  final Map<int, Duration> _positions = {};
  final Map<int, Duration> _durations = {};
  AudioPlayer _audioPlayer = AudioPlayer();
  String get _durationText => _duration?.toString().split('.').first ?? '';
  String formattedTime = "";
  String get _positionText => _position?.toString().split('.').first ?? '';
  bool playAudio = false;
  int currentIndex = -1;
  @override
  void initState() {
    super.initState();
    loadMessage();
    for (int i = 0; i < messageController.messageList.length; i++) {
      final player = AudioPlayer();
      _audioPlayers.add(player);
      _setupAudioPlayerListeners(player, i);
    }
  }

  loadMessage() async {
    final prefs =
        Shared(sharedPreferences: await SharedPreferences.getInstance());
    print(prefs.message.length);
    messageController.messageList.addAll(prefs.message);
    messageController.setAudioPlayers();
  }

  void _setupAudioPlayerListeners(AudioPlayer player, int index) {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.arrow_back_ios, size: 20.sp),
            CircleAvatar(backgroundColor: Colors.blue, radius: 18.sp),
            SizedBox(width: 2.w),
            Text("Michale Knight",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17.sp)),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.search, color: Colors.black, size: 20.sp),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChatStatusFilter(),
                      OrderChat(
                        onLongPress: () async {
                          await showTwoDialogs(context);
                        },
                      ),
                      ListView.builder(
                        itemCount: messageController.messageList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final message = messageController.messageList[index];
                          final duration = _durations[index] ?? Duration.zero;
                          final position = _positions[index] ?? Duration.zero;
                          if (messageController.messageList[index].date
                              .toString()
                              .isNotEmpty) {
                            final date = DateTime.parse(
                                messageController.messageList[index].date ??
                                    "");
                            formattedTime = DateFormat('hh:mm a').format(date);
                          }
                          return Container(
                            // width: 20.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            margin: EdgeInsets.only(
                                left: 30.w, top: 2.h, right: 2.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue.shade50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: EdgeInsets.all(10.sp),
                                        child: Center(
                                          child:
                                              playAudio && currentIndex == index
                                                  ? Icon(Icons.pause,
                                                      color: Colors.black)
                                                  : Icon(Icons.play_arrow,
                                                      color: Colors.black),
                                        ),
                                      ),
                                      onTap: () async {
                                        setState(() {
                                          playAudio = !playAudio;
                                          currentIndex = index;
                                        });
                                        if (playAudio) {
                                          _setupAudioPlayerListeners(
                                              messageController
                                                  .audioPlayers[index],
                                              index);
                                          await messageController
                                              .audioPlayers[index]
                                              .play(DeviceFileSource(
                                                  message.filePath.toString()));
                                        } else {
                                          await messageController
                                              .audioPlayers[index]
                                              .pause();
                                        }
                                      },
                                    ),
                                    Slider(
                                      onChanged: (value) {
                                        if (duration == Duration.zero) return;
                                        final newPosition =
                                            value * duration.inMilliseconds;
                                        _audioPlayers[index].seek(Duration(
                                            milliseconds: newPosition.round()));
                                      },
                                      activeColor: Colors.blue,
                                      value: (position.inMilliseconds > 0 &&
                                              position.inMilliseconds <
                                                  duration.inMilliseconds)
                                          ? position.inMilliseconds /
                                              duration.inMilliseconds
                                          : 0.0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        currentIndex == index
                                            ? _position != null
                                                ? _positionText
                                                : _duration != null
                                                    ? _durationText
                                                    : ''
                                            : "",
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      Row(
                                        spacing: 1.w,
                                        children: [
                                          Text(
                                            formattedTime,
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          Icon(
                                            Icons.done_all,
                                            size: 16.0,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                child: ChatInputField(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> showTwoDialogs(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context)!;
    OverlayEntry firstDialog = OverlayEntry(
        builder: (BuildContext context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
                type: MaterialType.transparency,
                child: Dialog(
                  alignment: Alignment.center,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: SizedBox(height: 200, child: OrderDialogue()),
                ))));
    OverlayEntry secondDialog = OverlayEntry(
        builder: (BuildContext context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
            left: MediaQuery.of(context).size.width * 0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
                type: MaterialType.transparency,
                child: Dialog(
                  alignment: Alignment.bottomCenter,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: SizedBox(height: 200, child: MenuDialogue()),
                ))));
    overlayState.insert(firstDialog);
    overlayState.insert(secondDialog);

    Future.delayed(Duration(seconds: 5), () {
      firstDialog.remove();
      secondDialog.remove();
    });
  }
}
