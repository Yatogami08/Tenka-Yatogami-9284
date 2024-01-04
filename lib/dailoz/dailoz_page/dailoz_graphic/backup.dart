import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dailoz_theme/dailoz_themecontroller.dart';

class DailozGraphic extends StatefulWidget {
  const DailozGraphic({Key? key}) : super(key: key);

  @override
  State<DailozGraphic> createState() => _DailozGraphicState();
}

class _DailozGraphicState extends State<DailozGraphic> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(DailozThemecontroler());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Graphic".tr,style: hsSemiBold.copyWith(fontSize: 18),) ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: DailozColor.bggray
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Priority".tr,style: hsSemiBold.copyWith(fontSize: 18,color: DailozColor.black),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: DailozColor.lightred,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: DailozColor.black),),
                          SizedBox(width: width/26,),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: DailozColor.purple,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: DailozColor.black),),
                          SizedBox(width: width/26,),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: DailozColor.textblue,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: DailozColor.black),),
                        ],
                      ),
                      SizedBox(height: height/96,),
                      Text("Task Perday".tr,style: hsSemiBold.copyWith(fontSize: 14,color: DailozColor.textgray),),
                      SizedBox(height: height/36,),
                      Image.asset(DailozPngimage.graphic,width: width/1,fit: BoxFit.fitWidth,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              Text("Your_Activity".tr,style: hsSemiBold.copyWith(fontSize: 18),),
              SizedBox(height: height/36,),
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: DailozColor.bggray
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/56),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/26),
                        child: Image.asset(DailozPngimage.graph2,width: width/1,fit: BoxFit.fitWidth,),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
