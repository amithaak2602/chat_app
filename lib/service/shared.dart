import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_nest/model/message_model.dart';


class Shared {
  final SharedPreferences sharedPreferences;
  const Shared({required this.sharedPreferences});
  set message(List<MessageModel> message) {
    if (message == null) {
      sharedPreferences.remove('msg');
    } else {
      sharedPreferences.setString('msg', jsonEncode(message));
    }
  }

  List<MessageModel> get message {
    try {
      final messageList = sharedPreferences.getString('msg');
      if(messageList == null){
        return [];
      }else {
        List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(json.decode(messageList)).toList();
        return jsonList.map((e) => MessageModel.fromJson(e)).toList();
      }
    } catch (e) {
      return [];
    }
  }
}
