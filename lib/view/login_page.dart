import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/model/UserModel.dart';
import 'package:vigenesia/services/UserService.dart';
import 'package:vigenesia/view/register_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: "anj@anj.com");
  final TextEditingController _passwordController = TextEditingController(text: "1111");

  bool _isPasswordInVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(
                image: AssetImage('assets/vigenesia-logo.png'),
                height: 100,
                alignment: Alignment.centerLeft),
            Text(
              "Sign In",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800],
              ),
            ),
            Text(
              "Hello, warriors! \nLog in and make every moment an opportunity to grow and achieve your goals.",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 17,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordInVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordInVisible = !_isPasswordInVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordInVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue[800],
                          onPrimary: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Sign In')),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text('Register Now'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email or password cannot be empty'),
        ),
      );
    } else {
      EasyLoading.show(status: 'loading...');

      Map<String, dynamic> param = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      UserModel? result = await UserService.login(param);

      if (result != null) {
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userModel: result,
            ),
          ),
          (route) => false,
        );
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or password is wrong'),
          ),
        );
      }
    }
  }
}
