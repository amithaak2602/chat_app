import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_nest/screen/home_screen/home_screen.dart';
import 'package:talk_nest/widget/custom_save_button.dart';
import 'package:talk_nest/widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomTextFormField(
                controller: _userName,
                label: "Username",
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.grey.shade400,),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("Username is required");
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                controller: _password,
                label: "Password",
                icon: Icon(
                  Icons.lock_person_outlined,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length!=4) {
                    return ("Password is required");
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              SaveButton(
                onTap: () async{
                  if(_formKey.currentState!.validate()){
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('username', _userName.text);
                    await prefs.setString('password', _password.text);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
