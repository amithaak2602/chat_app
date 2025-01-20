import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_nest/model/message_model.dart';
import 'package:talk_nest/service/getx.dart';
import 'package:talk_nest/service/shared.dart';

class VoiceRecorderUI extends StatefulWidget {
  const VoiceRecorderUI({super.key, this.onSend, required this.onClick});
  final void Function()? onSend;
  final VoidCallback onClick;
  @override
  _VoiceRecorderUIState createState() => _VoiceRecorderUIState();
}

class _VoiceRecorderUIState extends State<VoiceRecorderUI> {
  final AudioRecorder _record = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late RecorderController _recorderController = RecorderController();
  bool _isRecording = false;
  String? _filePath;
  String? path;
  Duration _duration = Duration.zero;
  Timer? _timer;
  final MessageController messageController = Get.put(MessageController());
  @override
  void initState() {
    _initialiseControllers();
    super.initState();
  }

  Future<void> _getDir() async {
    if (await Permission.microphone.request().isGranted) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      path = p.join(appDocumentsDir.path,
          "${DateTime.now().millisecondsSinceEpoch}recording.m4a");
      // await _record.start(const RecordConfig(), path: filePath);
      _startTimer();
      setState(() {
        // _isRecording = true;
        _filePath = null;
      });
    } else {
      print('Microphone permission denied');
    }
  }

  void _startOrStopRecording() async {
    try {
      if (_isRecording) {
        _recorderController.reset();

        path = await _recorderController.stop(false);

        if (path != null) {
          _stopTimer();
        }
      } else {
        await _getDir();
        await _recorderController.record(path: path); // Path is optional
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isRecording = !_isRecording;
      });
    }
  }

  void _initialiseControllers() {
    _recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _playRecording() async {
    if (_filePath != null) {
      await _audioPlayer.play(DeviceFileSource(_filePath!));
    }
  }

  void _deleteRecording() {
    if (path != null) {
      widget.onClick();
      setState(() {
        path = null;
        _isRecording = false;
        _duration = Duration.zero;
      });
    }
  }

  @override
  void dispose() {
    _recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 2.h,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 25,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: _startOrStopRecording,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(10.sp),
                            child: Center(
                              child: _isRecording
                                  ? Icon(
                                      Icons.pause,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                    ),
                            ),
                          )),
                      Column(
                        children: [
                          if (path != null)
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: AudioWaveforms(
                                enableGesture: true,
                                size: Size(
                                    MediaQuery.of(context).size.width / 2,
                                    30.0),
                                recorderController: _recorderController,
                                waveStyle: const WaveStyle(
                                  waveColor: Colors.red,
                                  extendWaveform: true,
                                  showMiddleLine: false,
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              ),
                            ),
                          Row(
                            spacing: 1.w,
                            children: [
                              CircleAvatar(
                                radius: 8.sp,
                                backgroundColor: Colors.red,
                              ),
                              Text(
                                _formatDuration(_duration),
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: _deleteRecording,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(10.sp),
                            child: Center(
                              child: Icon(
                                Icons.delete_outlined,
                                color: Colors.red,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 2.w,
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade50),
                child: Center(
                  child: Row(
                    spacing: 2.w,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                      Text(
                        "Send as chat",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                MessageModel msg = MessageModel(
                    type: "mp3",
                    filePath: path,
                    date: "${DateTime.now()}",
                    duration: _duration);
                final prefs = Shared(
                    sharedPreferences: await SharedPreferences.getInstance());
                widget.onClick();
                if (path != null) {
                  prefs.message = [msg];
                  await messageController.addMessage();
                  await messageController.setAudioPlayers();
                }
                _stopTimer();
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.shade50),
              child: Center(
                child: Row(
                  spacing: 2.w,
                  children: [
                    Icon(
                      Icons.receipt,
                      color: Colors.green,
                      size: 18.sp,
                    ),
                    Text(
                      "Send as order",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
