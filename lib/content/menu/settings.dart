import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/preferences/preferences.dart';
import 'package:next_party_application/content/auth/sign_in.dart';
import 'package:next_party_application/theme/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> logout() async {
    Preferences prefs = await Preferences().init();
    prefs.clear();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Padding(
        padding: AppTheme.paddingApp,
        child: Center(
          child: Column(children: [
            AppTheme.elevatedButton("Log out", () {
              logout();
            }),
          ]),
        ),
      ),
    );
  }
}
