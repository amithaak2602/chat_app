import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_nest/model/message_model.dart';
import 'package:talk_nest/service/shared.dart';

class MessageController extends GetxController{
  var messageList = <MessageModel>[].obs;
  var audioPlayers = <AudioPlayer>[].obs;


  Future<void> addMessage()async{
    final prefs =
    Shared(sharedPreferences: await SharedPreferences.getInstance());
    messageList.addAll(prefs.message);
  }
  Future<void> setAudioPlayers()async{
    for (int i = 0; i < messageList.length; i++) {
      final player = AudioPlayer();
     audioPlayers.add(player);
    }
  }
}