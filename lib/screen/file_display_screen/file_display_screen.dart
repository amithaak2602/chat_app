import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileDisplayScreen extends StatefulWidget {
  const FileDisplayScreen(
      {super.key, required this.file, required this.platformFile});
  final File file;
  final PlatformFile platformFile;
  @override
  State<FileDisplayScreen> createState() => _FileDisplayScreenState();
}

class _FileDisplayScreenState extends State<FileDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 17.sp,
                    backgroundColor: Colors.grey.shade400,
                    child: Icon(
                      Icons.clear,
                      size: 18.sp,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              widget.platformFile.extension.toString().toLowerCase() == "pdf"
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 600,
                      child: SfPdfViewer.file(File(widget.file.path)))
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 600,
                      child: Image.file(widget.file),
                    ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18.sp,
              backgroundColor: Colors.grey.shade400,
              child: Icon(
                Icons.send,
                size: 18.sp,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
