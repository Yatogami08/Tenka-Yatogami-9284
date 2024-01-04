import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dailoz_gloabelclass/dailoz_prefsname.dart';
import 'dailoz_theme.dart';

class DailozThemecontroler extends GetxController{
  @override
  void onInit()
  {
    SharedPreferences.getInstance().then((value) {
      isdark = value.getBool(dailozDarkMode)!;
    });
    update();
    super.onInit();
  }

  var isdark = false;
  Future<void> changeThem (state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isdark = prefs.getBool(dailozDarkMode) ?? true;
    isdark = !isdark;

    if (state == true) {
      Get.changeTheme(DailozMythemes.darkTheme);
      isdark = true;
    }
    else {
      Get.changeTheme(DailozMythemes.lightTheme);
      isdark = false;
    }
    update();
  }

}