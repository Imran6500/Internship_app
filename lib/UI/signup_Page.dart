// ignore_for_file: file_names
import 'package:assignment/UI/ScreensForOtp/signInPage.dart';
import '../Global/imports.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String id = 'SignupPage';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(login ? 'Login' : 'Signup'),
          centerTitle: true,
          backgroundColor: const Color(0xff6b63ff),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  commonImage(),

                  // full name
                  login
                      ? Container()
                      : TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Desiredpurple)),
                            hintText: fullnameHint,
                          ),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Please Enter Full Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (input) {
                            setState(() {
                              Fullname = input!;
                            });
                          },
                        ),
                  sizeboxforspace(),

                  // Email
                  TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Desiredpurple)),
                      hintText: emailHint,
                    ),
                    validator: (input) {
                      if (input!.isEmpty || !input.contains('@')) {
                        return 'Please Enter valid Email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (input) {
                      setState(() {
                        Email = input!;
                      });
                    },
                  ),
                  sizeboxforspace(),

                  //Password
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Desiredpurple)),
                      hintText: passwordHint,
                    ),
                    validator: (input) {
                      if (input!.length < passLength) {
                        return 'Please Enter Password of min length $passLength';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (input) {
                      setState(() {
                        Password = input!;
                      });
                    },
                  ),

                  sizeboxforspace(),

                  SizedBox(
                    height: buttonHeight,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Desiredpurple)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            login
                                ? AuthServices.signinUser(
                                    Email, Password, context)
                                : AuthServices.signupUser(
                                    Email, Password, Fullname, context);
                          }
                        },
                        child: Text(login ? 'Login' : 'Signup')),
                  ),
                  sizeboxforspace(),

                  TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Desiredpurple)),
                      onPressed: () {
                        setState(() {
                          login = !login;
                        });
                      },
                      child: Text(login
                          ? "Don't have an account? Signup"
                          : "Already have an account? Login")),
                  sizeboxforspace(),

                  TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Desiredpurple)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(login
                          ? "Login with Phone number"
                          : "Login with Phone number")),
                  sizeboxforspace(),
                ],
              ),
            ),
          ),
        ));
  }
}
