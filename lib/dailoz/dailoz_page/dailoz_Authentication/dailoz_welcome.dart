import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailoz_login.dart';
import 'dailoz_signup.dart';

class DailozWelcome extends StatefulWidget {
  const DailozWelcome({Key? key}) : super(key: key);

  @override
  State<DailozWelcome> createState() => _DailozWelcomeState();
}

class _DailozWelcomeState extends State<DailozWelcome> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height/36,horizontal: width/36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height/8,),
            Image.asset(DailozPngimage.spash,height: height/3,fit: BoxFit.fitHeight,),
            SizedBox(height: height/16,),
            Text("Dailoz".tr,style: hsBold.copyWith(fontSize: 32,color: DailozColor.appcolor),),
            SizedBox(height: height/46,),
            Text("Dev by Yatogami".tr,textAlign: TextAlign.center,style: hsRegular.copyWith(fontSize: 14),),
            const Spacer(),
            InkWell(
              splashColor: DailozColor.transparent,
              highlightColor: DailozColor.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DailozLogin();
                },));
              },
              child: Container(
                width: width/1,
                height: height/15,
                decoration: BoxDecoration(
                  color: DailozColor.appcolor,
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Center(child: Text("Login".tr,style: hsSemiBold.copyWith(fontSize: 16,color: DailozColor.white),)),
              ),
            ),
            SizedBox(height: height/96,),
            InkWell(
              splashColor: DailozColor.transparent,
              highlightColor: DailozColor.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DailozSignup();
                },));
              },
              child: Container(
                width: width/1,
                height: height/15,
                decoration: BoxDecoration(
                    color: DailozColor.transparent,
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Center(child: Text("SignUp".tr,style: hsSemiBold.copyWith(fontSize: 16,color: DailozColor.appcolor),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
