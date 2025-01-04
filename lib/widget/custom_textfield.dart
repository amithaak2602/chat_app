import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? labelText;
  final Widget? icon;
  final Widget? prefixIcon;
  final TextCapitalization? capitalization;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.label,
      this.inputFormatters,
      this.prefixIcon,
      this.capitalization,
      this.icon,
      this.textInputType,
      this.labelText,
      this.validator,
      this.onTap,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: textInputType ?? TextInputType.text,
      cursorColor: Colors.black,
      controller: controller,
      inputFormatters: inputFormatters ?? [],
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          fontFamily: 'Poppins'),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: 4.w, top: 2.3.h, bottom: 2.3.h, right: 4.w),
        suffixIcon: icon,
        prefixIcon: prefixIcon,
        alignLabelWithHint: true,
        focusColor: const Color(0xffeeeeee),
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1.5, style: BorderStyle.none, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
