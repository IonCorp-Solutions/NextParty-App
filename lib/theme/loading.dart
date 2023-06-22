import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingEffect {
  static Center loading = const Center(
    child: SpinKitCubeGrid(
      color: Color(0xff2699FB),
      size: 50.0,
    ),
  );

  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return loading;
      },
    );
  }

  static hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
