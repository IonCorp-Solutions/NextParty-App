import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/content/auth/sign_up.dart';
import 'package:next_party_application/content/auth/sign_in.dart';
import 'package:next_party_application/theme/loading.dart';
import 'package:next_party_application/theme/theme.dart';
import 'package:next_party_application/api/supplies/auth/user_model.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  UsersService usersService = UsersService();

  void sendEmail(ForgotPasswordDto data, BuildContext context) async {
    if (emailController.text.isEmpty ||
        AppTheme.isEmail(emailController.text) == false) {
      AppTheme.message(context, 'Valid email is required');
    }

    LoadingEffect.showLoading(context);
    var response = await usersService.sendRestorePasswordEmail(data);
    if(!mounted) return;
    LoadingEffect.hideLoading(context);
    if (response) {
      AppTheme.message(context, 'Email sent successfully, check your inbox');
      return;
    }
    AppTheme.message(context, 'Email not sent, check your email and try again');
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTheme.input,
      decoration: AppTheme.inputDecoration('Email', CupertinoIcons.mail),
    );

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
                    const Text(
                      'Forgot Password',
                      style: AppTheme.headline,
                    ),
                    AppTheme.captionRowForPage('Already have an account',
                        'Sign In', context, const SignIn()),
                  ],
                ),
                AppTheme.spaceBoxH,
                emailTextField,
                AppTheme.spaceBoxH,
                AppTheme.elevatedButton("Send Email", () {
                  ForgotPasswordDto data =
                      ForgotPasswordDto(email: emailController.text);
                  sendEmail(data, context);
                }),
                AppTheme.captionRowForPage('Don\'t have an account?', 'Sign Up',
                    context, const SignUp())
              ],
            ),
          ),
        ),
      )),
    );
  }
}
