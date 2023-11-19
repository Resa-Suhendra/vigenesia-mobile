import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/services/UserService.dart';

import '../model/UserModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordInVisible = true;
  bool _isConfirmPasswordInVisible = true;

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
              "Register",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800],
              ),
            ),
            Text(
              "Join this enthusiastic community! \nRegister now and begin the journey toward the best version of yourself.",
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _professionController,
                      decoration: const InputDecoration(
                        labelText: 'Profession',
                        hintText: 'Enter your profession',
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _isConfirmPasswordInVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordInVisible =
                                  !_isConfirmPasswordInVisible;
                            });
                          },
                          icon: Icon(
                            _isConfirmPasswordInVisible
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
                          _checkPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue[800],
                          onPrimary: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Register')),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Login Now'),
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

  void _checkPassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      EasyLoading.showError('Password not match');
    } else {
      _register();
    }
  }

  void _register() async {
    EasyLoading.show(
      status: 'loading...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.custom,
    );

    UserModel userModel = UserModel(
      nama: _nameController.text,
      profesi: _professionController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    print(userModel.toRawJson());

    String? res = await UserService.register(userModel.toJson());

    if (res != null) {
      EasyLoading.showSuccess('Register success');
      Navigator.pop(context);
    } else {
      EasyLoading.showError('Register failed');
    }
    // EasyLoading.dismiss();
  }
}
