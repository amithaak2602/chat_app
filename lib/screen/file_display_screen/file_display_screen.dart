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
            Padding(
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
          ],
        ),
      )),
    );
  }
}
