// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:assignment/UI/ScreensForOtp/verify_Phone_number.dart';
import 'package:assignment/cubit/authcubit/auth_cubit.dart';
import 'package:assignment/cubit/authcubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/colors.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In With Phone"),
        backgroundColor: const Color(0xff6b63ff),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Desiredpurple)),
                  hintText: "Phone Number",
                  counterText: ""),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
              if (state is AuthCodeSendState) {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => VerifyPhoneNumberScreen()));
              }
            }, builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  onPressed: () {
                    String phoneNumber = "+91" + phoneController.text;
                    BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                  },
                  color: Colors.blue,
                  child: const Text("SignIn"),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
