import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/api/supplies/preferences/preferences.dart';
import 'package:next_party_application/theme/loading.dart';
import 'package:next_party_application/theme/theme.dart';

import 'package:next_party_application/api/supplies/auth/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  UsersService usersService = UsersService();
  bool enabled = false;
  bool isLoading = false;
  late User user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date).toString();
  }

  Future<void> _getUser() async {
    setState(() {
      isLoading = true;
    });
    Preferences prefs = await Preferences().init();
    setState(() {
      user = prefs.user;
    });
    firstnameController.text = user.firstname;
    lastnameController.text = user.lastname;
    emailController.text = user.email;
    phoneController.text = user.phone ?? '';
    birthdayController.text = user.birthdayString;
    setState(() {
      isLoading = false;
    });
  }

  Object image() {
    if (user.profileImage != null) {
      return MemoryImage(user.profileImage as Uint8List);
    } else {
      return const AssetImage('assets/utils/profileL.png');
    }
  }

  void update(UpdateProfileDto data) async {
    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        emailController.text.isEmpty) {
      AppTheme.message(context, 'Complete your name and email');
      return;
    }
    if (AppTheme.isEmail(emailController.text) == false) {
      AppTheme.message(context, 'Enter a valid email');
      return;
    }

    if (phoneController.text.length != 9) {
      AppTheme.message(context, 'Enter a valid phone number, 9 digits');
      return;
    }

    LoadingEffect.showLoading(context);
    var response = await usersService.updateProfile(data);
    if (response) {
      Preferences prefs = await Preferences().init();
      prefs.setUser(User(
          id: user.id,
          firstname: data.firstName,
          lastname: data.lastName,
          email: data.email,
          phone: data.phone,
          birthday: data.birthday,
          profileImage: user.profileImage));
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
    } else {
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
      AppTheme.message(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textFieldFormat(ctrl, text, icon, obscure, type, onTap, enabled) =>
        TextField(
          enabled: enabled,
          controller: ctrl,
          obscureText: obscure,
          keyboardType: type,
          style: AppTheme.input,
          decoration: AppTheme.inputDecoration(text, icon),
          onTap: () => onTap(),
        );

    Widget emailTextField = textFieldFormat(
        emailController,
        'Email',
        CupertinoIcons.mail,
        false,
        TextInputType.emailAddress,
        () => {},
        enabled);
    Widget firstnameTextField = textFieldFormat(
        firstnameController,
        'Firstname',
        CupertinoIcons.person,
        false,
        TextInputType.name,
        () => {},
        enabled);
    Widget lastnameTextField = textFieldFormat(lastnameController, 'Lastname',
        CupertinoIcons.person, false, TextInputType.name, () => {}, enabled);
    Widget phoneTextField = textFieldFormat(phoneController, 'Phone',
        CupertinoIcons.phone, false, TextInputType.phone, () => {}, enabled);
    Widget birthdayTextField = textFieldFormat(birthdayController, 'Birthday',
        CupertinoIcons.calendar, false, TextInputType.datetime, () async {
      FocusScope.of(context).unfocus();
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));
      birthdayController.text =
          DateFormat('yyyy-MM-dd').format(date!).toString();
    }, enabled);
    List<Widget> textFields = [
      firstnameTextField,
      lastnameTextField,
      emailTextField,
      phoneTextField,
      birthdayTextField
    ];

    return isLoading
        ? LoadingEffect.loading
        : Scaffold(
            backgroundColor: AppTheme.whiteColor,
            floatingActionButton: !enabled
                ? FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        enabled = !enabled;
                      });
                    },
                    backgroundColor: AppTheme.dodgerPrimaryColor,
                    child: const Icon(Icons.edit, color: AppTheme.whiteColor),
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: SingleChildScrollView(
              child: Padding(
                padding: AppTheme.paddingApp,
                child: Center(
                  child: Column(
                    children: [
                      AppTheme.spaceBoxNH(20),
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: image() as ImageProvider<Object>?),
                      AppTheme.spaceBoxH,
                      Text(
                        user.fullName,
                        style: AppTheme.profileName,
                      ),
                      AppTheme.spaceBoxH,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
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
                      ),
                      enabled
                          ? AppTheme.elevatedButton("Save", () {
                              update(UpdateProfileDto(
                                firstName: firstnameController.text,
                                lastName: lastnameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                birthday: birthdayController.text.isEmpty
                                    ? null
                                    : DateTime.parse(birthdayController.text),
                              ));
                              setState(() {
                                enabled = !enabled;
                              });
                            })
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
