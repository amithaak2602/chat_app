import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatStatusFilter extends StatelessWidget {
  const ChatStatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 0.3.h,),
        padding: EdgeInsets.symmetric(vertical: 1.2.h,horizontal: 3.w),
        child: Row(
          spacing: 3.w,
          children: [
            StatusFilterContainer(
              color: Colors.black,
              title: "All",
              titleColor: Colors.white,
            ),
            StatusFilterContainer(
              color: Colors.grey.shade100,
              title: "Unread",
              titleColor: Colors.black,
            ),
            StatusFilterContainer(
              color: Colors.green.shade50,
              title: "Approved",
              titleColor: Colors.green,
            ),
            StatusFilterContainer(
              color: Colors.red.shade50,
              title: "Declined",
              titleColor: Colors.red,
            ),
            StatusFilterContainer(
              color: Colors.orange.shade50,
              title: "Pending",
              titleColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class StatusFilterContainer extends StatelessWidget {
  const StatusFilterContainer(
      {super.key, this.color, this.title, this.titleColor});
  final Color? color;
  final Color? titleColor;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      child: Center(
        child: Text(
          title ?? "",
          style: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.bold, color: titleColor),
        ),
      ),
    );
  }
}
