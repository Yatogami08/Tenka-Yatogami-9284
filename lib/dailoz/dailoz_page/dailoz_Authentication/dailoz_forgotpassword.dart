import 'package:flutter/material.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class DailozForgotpassword extends StatefulWidget {
  const DailozForgotpassword({Key? key}) : super(key: key);

  @override
  State<DailozForgotpassword> createState() => _DailozForgotpasswordState();
}

class _DailozForgotpasswordState extends State<DailozForgotpassword> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height/12,),
            Text("Forgot_password".tr,style: hsSemiBold.copyWith(fontSize: 36,color: DailozColor.appcolor),),
            SizedBox(height: height/16,),
            TextField(
              style: hsMedium.copyWith(fontSize: 16,color: DailozColor.textgray),
              decoration: InputDecoration(
                  hintStyle: hsMedium.copyWith(fontSize: 16,color: DailozColor.textgray),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(DailozSvgimage.icemail,height: height/36,colorFilter: const ColorFilter.mode(DailozColor.textgray, BlendMode.srcIn)),
                  ),
                  hintText: "Email ID or Username",
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: DailozColor.greyy)
                  )
              ),
            ),
            SizedBox(height: height/20,),
            InkWell(
              splashColor: DailozColor.transparent,
              highlightColor: DailozColor.transparent,
              onTap: () {
                /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DailozLogin();
                  },));*/
              },
              child: Container(
                width: width/1,
                height: height/15,
                decoration: BoxDecoration(
                    color: DailozColor.appcolor,
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Center(child: Text("Send".tr,style: hsSemiBold.copyWith(fontSize: 16,color: DailozColor.white),)),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
