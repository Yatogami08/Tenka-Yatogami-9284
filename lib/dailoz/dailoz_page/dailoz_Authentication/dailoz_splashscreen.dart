import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';

import '../../dailoz_gloabelclass/dailoz_color.dart';
import '../dailoz_home/dailoz_dashboard.dart';
import 'dailoz_welcome.dart';

class DailozSplashscreen extends StatefulWidget {
  const DailozSplashscreen({Key? key}) : super(key: key);

  @override
  State<DailozSplashscreen> createState() => _DailozSplashscreenState();
}

class _DailozSplashscreenState extends State<DailozSplashscreen> {
  @override
  void initState() {
    super.initState();
    goup();
  }

  goup() async {
    var navigator = Navigator.of(context);
    await Future.delayed(const Duration(seconds: 5));
    navigator.push(MaterialPageRoute(
      builder: (context) {
      //  return const DailozWelcome();
        return DailozDashboard("0");
      },
    ));
  }

  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: DailozColor.appcolor,
      body: Center(
          child: Image.asset(DailozPngimage.splashh,height: height/6,fit: BoxFit.fitHeight,)),
    );
  }
}
