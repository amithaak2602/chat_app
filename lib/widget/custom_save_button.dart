import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onTap;
  const SaveButton({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.8.h),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold, fontSize: 17.sp),
        ),
      ),
    );
  }
}
