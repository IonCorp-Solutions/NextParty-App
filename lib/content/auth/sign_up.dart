import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_party_application/api/supplies/auth/user_model.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/content/auth/sign_in.dart';
import 'package:next_party_application/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/loading.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  UsersService usersService = UsersService();

  final Uri _url = Uri.parse(
      'https://www.freeprivacypolicy.com/live/45881ce6-ff56-4c12-829c-4d66aaaa23b1');

  Future<void> register(RegisterDto registerDto, BuildContext context) async {
    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      AppTheme.message(context, 'Complete your name, email and password');
      return;
    }

    if (AppTheme.isEmail(emailController.text) == false) {
      AppTheme.message(context, 'Enter a valid email');
      return;
    }

    if (!_terms) {
      AppTheme.message(context, 'Accept the terms and conditions');
      return;
    }
    LoadingEffect.showLoading(context);
    var response = await usersService.register(registerDto);
    if (response != false) {
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
      AppTheme.message(context, 'User created successfully, go to sign in');
      return;
    }
    if (!mounted) return;
    LoadingEffect.hideLoading(context);
    AppTheme.message(context, 'User already exists');
    return;
  }

  bool _terms = false;

  Future<void> launch() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = AppTheme.textField(emailController, 'Email*',
        CupertinoIcons.mail, TextInputType.emailAddress, () => {}, false);
    Widget passwordTextField = AppTheme.textField(
        passwordController,
        'Password*',
        CupertinoIcons.lock,
        TextInputType.visiblePassword,
        () => {},
        true);
    Widget firstnameTextField = AppTheme.textField(
        firstnameController,
        'First Name*',
        CupertinoIcons.person,
        TextInputType.name,
        () => {},
        false);
    Widget lastnameTextField = AppTheme.textField(
        lastnameController,
        'Last Name*',
        CupertinoIcons.person,
        TextInputType.name,
        () => {},
        false);
    Widget phoneTextField = AppTheme.textField(phoneController, 'Phone',
        CupertinoIcons.phone, TextInputType.phone, () => {}, false);
    Widget birthdayTextField = AppTheme.textField(birthdayController,
        'Birthday', CupertinoIcons.calendar, TextInputType.datetime,  () async {
      FocusScope.of(context).unfocus();
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));
      birthdayController.text = date != null
          ? DateFormat('yyyy-MM-dd').format(date).toString()
          : birthdayController.text;
    }, false);
    List<Widget> textFields = [
      firstnameTextField,
      lastnameTextField,
      emailTextField,
      passwordTextField,
      phoneTextField,
      birthdayTextField
    ];
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
                    const Text('Sign Up', style: AppTheme.headline),
                    AppTheme.captionRowForPage('Already have an account?',
                        'Sign In', context, const SignIn()),
                  ],
                ),
                AppTheme.spaceBoxH,
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: AppTheme.paddingBottom,
                      child: textFields[index],
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: textFields.length,
                ),
                AppTheme.spaceBoxH,
                Row(
                  children: [
                    Checkbox(
                      value: _terms,
                      onChanged: (bool? value) {
                        setState(() {
                          _terms = value!;
                        });
                      },
                    ),
                    AppTheme.captionRowForFunction('I accept the',
                        'T&C and \nPrivacy Policy', context, launch),
                  ],
                ),
                AppTheme.elevatedButton("Sign Up", () {
                  register(
                      RegisterDto(
                        firstName: firstnameController.text,
                        lastName: lastnameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text.isEmpty
                            ? null
                            : phoneController.text,
                        birthday: birthdayController.text.isEmpty
                            ? null
                            : DateTime.parse(birthdayController.text),
                      ),
                      context);
                })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
