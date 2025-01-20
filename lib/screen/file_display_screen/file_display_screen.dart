import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:talk_nest/model/message_model.dart';
import 'package:talk_nest/service/getx.dart';
import 'package:talk_nest/service/shared.dart';

class FileDisplayScreen extends StatefulWidget {
  const FileDisplayScreen(
      {super.key, required this.file, required this.platformFile});
  final File file;
  final PlatformFile platformFile;
  @override
  State<FileDisplayScreen> createState() => _FileDisplayScreenState();
}

class _FileDisplayScreenState extends State<FileDisplayScreen> {
  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(right: 3.w, top: 2.h),
                        child: Icon(
                          Icons.delete_outlined,
                          size: 21.sp,
                        ),
                      ),
                      onTap: () {
                        widget.file.delete();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                widget.platformFile.extension.toString().toLowerCase() == "pdf"
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: SfPdfViewer.file(
                              File(widget.file.path),
                              canShowScrollHead: false,
                              interactionMode: PdfInteractionMode.pan,
                              pageSpacing: 0,
                              pageLayoutMode: PdfPageLayoutMode.single,
                              enableDoubleTapZooming: false,
                            )),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: Image.file(
                            widget.file,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
              ],
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 3.w, top: 5.h),
                child: CircleAvatar(
                  radius: 18.sp,
                  backgroundColor: Colors.grey.shade400,
                  child: Icon(
                    Icons.send,
                    size: 18.sp,
                  ),
                ),
              ),
              onTap: () async {
                MessageModel msg = MessageModel(
                  type: "png",
                  filePath: widget.file.path,
                  date: "${DateTime.now()}",
                );
                final prefs = Shared(
                    sharedPreferences: await SharedPreferences.getInstance());
                if (widget.file.path != null) {
                  prefs.message = [msg];
                  await messageController.addMessage();
                  await messageController.setAudioPlayers();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
