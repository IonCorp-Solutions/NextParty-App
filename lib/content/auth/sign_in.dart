import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/auth/user_model.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/api/supplies/preferences/preferences.dart';
import 'package:next_party_application/content/auth/forgot_password.dart';
import 'package:next_party_application/content/auth/sign_up.dart';
import 'package:next_party_application/theme/loading.dart';
import 'package:next_party_application/theme/theme.dart';

import '../index.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersService usersService = UsersService();

  @override
  initState() {
    super.initState();
  }

  login(LoginDto loginDto, context) async {
    if (loginDto.email.isEmpty || loginDto.password.isEmpty) {
      AppTheme.message(context, 'Please fill all fields');
      return;
    }

    if (AppTheme.isEmail(loginDto.email) == false) {
      AppTheme.message(context, 'Please enter a valid email');
      return;
    }

    LoadingEffect.showLoading(context);
    var response = await usersService.login(loginDto);
    if (response == null) {
      LoadingEffect.hideLoading(context);
      AppTheme.message(context, 'Invalid credentials');
      return;
    }

    Preferences pref = await Preferences().init();
    pref.setToken(response['token']);
    pref.setUser(response['user']);
    LoadingEffect.hideLoading(context);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const Index()));
  }

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: AppTheme.input,
        decoration: AppTheme.inputDecoration('Email', CupertinoIcons.mail));

    Widget passwordTextField = TextField(
        controller: passwordController,
        style: AppTheme.input,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: AppTheme.inputDecoration('Password', CupertinoIcons.lock));

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: AppTheme.paddingApp,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sign In', style: AppTheme.headline),
                    AppTheme.captionRowForPage('Don\'t have an account?',
                        'Sign Up', context, const SignUp()),
                  ],
                ),
                AppTheme.spaceBoxH,
                emailTextField,
                AppTheme.spaceBoxH,
                passwordTextField,
                AppTheme.spaceBoxH,
                AppTheme.elevatedButton("Login", () {
                  login(
                      LoginDto(
                          email: emailController.text,
                          password: passwordController.text),
                      context);
                }),
                AppTheme.spaceBoxH,
                AppTheme.captionRowForPage('Forgot your password?',
                    'Click here', context, const ForgotPassword()),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
