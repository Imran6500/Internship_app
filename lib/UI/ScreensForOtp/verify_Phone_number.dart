// ignore_for_file: must_be_immutable

import 'package:assignment/UI/homePage.dart';
import 'package:assignment/cubit/authcubit/auth_cubit.dart';
import 'package:assignment/cubit/authcubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  VerifyPhoneNumberScreen({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              maxLength: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "6-Digit OTP",
                counterText: "",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
              if (state is AuthLoggedInState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => const HomePage()));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                  duration: const Duration(milliseconds: 2000),
                ));
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
                    color: Colors.blue,
                    child: const Text("Verify"),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOTP(otpController.text);
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
