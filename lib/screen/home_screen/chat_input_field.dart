import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:talk_nest/screen/file_display_screen/file_display_screen.dart';

class ChatInputField extends StatefulWidget {
   const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
 PlatformFile?_pickedFile;
File?_displayFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 25,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 5.5.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade100),
              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
              padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 0.5.h),
              child: Center(
                child: TextField(
                  cursorHeight: 2.h,
                  decoration: InputDecoration(
                      hintText: "Type here...",
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.blue,
                          size: 19.sp,
                        ),
                        onTap: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.any,
                            allowMultiple: false,
                          );
                          if (null != result) {
                            final fileName = result.files.first.toString();
                            _pickedFile=result.files.first;
                            _displayFile = File(_pickedFile!.path.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return FileDisplayScreen(file: _displayFile!,platformFile: _pickedFile!,);
                            }));
                          }
                        },
                      )),
                ),
              ),
            ),
          ),
          // Microphone Icon
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
            margin: EdgeInsets.only(right: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.blue),
            child: Icon(
              Icons.mic_none,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
