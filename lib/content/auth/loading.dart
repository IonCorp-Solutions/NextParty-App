import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/content/auth/sign_in.dart';
import 'package:next_party_application/theme/loading.dart';
import 'package:next_party_application/theme/theme.dart';
import 'package:next_party_application/content/index.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});
  @override
  State<LoadPage> createState() => _LoadPageState();
}
class _LoadPageState extends State<LoadPage> {
  UsersService usersService = UsersService();
  bool loading = false;

  Future<void> _checkLoginStatus() async {
    setState(() {
      loading = true;
    });
    bool isLogged = await usersService.isLogged();
    if (isLogged) {
      setState(() {
        loading = false;
      });
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const Index()),(Route<dynamic> route) => false
      );
    }
    else {
      setState(() {
        loading = false;
      });
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const SignIn()),(Route<dynamic> route) => false
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: loading ? LoadingEffect.loading: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Next\nParty', style:AppTheme.loadingText),
              AppTheme.spaceBoxNH(MediaQuery.of(context).size.height * 0.1),
              IconButton(onPressed: ()=> _checkLoginStatus(),
                  icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                  iconSize: 60, color: AppTheme.lightBlue)
            ],
          )
      ),
    );
  }
}