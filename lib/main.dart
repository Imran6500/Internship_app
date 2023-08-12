import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Global/imports.dart';
import 'UI/ScreensForOtp/signInPage.dart';
import 'UI/homePage.dart';
import 'UI/signup_Page.dart';
import 'cubit/authcubit/auth_cubit.dart';
import 'cubit/authcubit/auth_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return

        // BlocProvider(
        //     create: (context) => AuthCubit(),
        //     child: MaterialApp(
        //       debugShowCheckedModeBanner: false,
        //       home: BlocBuilder<AuthCubit, AuthState>(
        //         buildWhen: (oldState, newState) {
        //           return oldState is AuthInitialState;
        //         },
        //         builder: (context, state) {
        //           if (state is AuthLoggedInState) {
        //             return const HomePage();
        //           } else if (state is AuthLoggedOutState) {
        //             return SignInScreen();
        //           } else {
        //             return const Scaffold();
        //           }
        //         },
        //       ),
        //     ));

        // BlocProvider(
        //     create: (context) => AuthCubit(),
        //     child: MaterialApp(
        //       debugShowCheckedModeBanner: false,
        //       home: BlocBuilder<AuthCubit, AuthState>(
        //         buildWhen: (oldState, newState) {
        //           return oldState is AuthInitialState;
        //         },
        //         builder: (context, state) {
        //           if (state is AuthLoggedInState) {
        //             return const HomePage();
        //           } else if (state is AuthLoggedOutState) {
        //             return SignInScreen();
        //           } else {
        //             return const Scaffold();
        //           }
        //         },
        //       ),
        //     ));

        MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return const SignupPage();
                }
              },
            ));
  }
}
