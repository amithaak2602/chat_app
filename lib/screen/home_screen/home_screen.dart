import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:talk_nest/screen/home_screen/chat_input_field.dart';
import 'package:talk_nest/screen/home_screen/widget/chat_status_filter.dart';
import 'package:talk_nest/screen/home_screen/widget/order_chat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 18.sp,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "Michale Knight",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17.sp),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 20.sp,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.h,
                  children: [
                    ChatStatusFilter(),
                    OrderChat(),

                  ],
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: ChatInputField(),
            ),
          ],
        ),
      ),
    );
  }
}
