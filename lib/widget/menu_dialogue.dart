import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuDialogue extends StatelessWidget {
  const MenuDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 1.h,
        children: [
          SizedBox(
            height: 1.h,
          ),
          _makeMenuData(Icon(Icons.receipt), "Quick Recorder"),
          Divider(),
          _makeMenuData(Icon(Icons.arrow_forward), "Assign to Salesman"),
          Divider(),
          _makeMenuData(Icon(Icons.share), "Share"),
          Divider(),
          _makeMenuData(Icon(Icons.exposure_rounded), "Export"),
        ],
      ),
    );
  }

  Widget _makeMenuData(Icon icon, String menu) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.w,
      ),
      child: Row(
        spacing: 2.w,
        children: [icon, Text(menu)],
      ),
    );
  }
}
