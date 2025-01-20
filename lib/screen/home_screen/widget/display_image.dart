import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:talk_nest/service/getx.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen(
      {super.key, required this.file, });
  final File file;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(right: 3.w, top: 2.h),
                            child: Icon(
                              Icons.close,
                              size: 21.sp,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Padding(
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

              ],
            ),
          )),
    );
  }
}
