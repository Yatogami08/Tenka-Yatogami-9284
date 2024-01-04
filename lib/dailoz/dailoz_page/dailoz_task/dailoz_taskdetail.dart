import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dailoz_theme/dailoz_themecontroller.dart';

class DailozTaskdetail extends StatefulWidget {
  const DailozTaskdetail({Key? key}) : super(key: key);

  @override
  State<DailozTaskdetail> createState() => _DailozTaskdetailState();
}

class _DailozTaskdetailState extends State<DailozTaskdetail> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List isselected = [];
  final themedata = Get.put(DailozThemecontroler());
  List tag = ["Office","Home","Urgent","Work"];

  List color = [
    DailozColor.bgpurple,
    DailozColor.bgred,
    const Color(0xffFFE9ED),
    DailozColor.bgsky,
  ];

  List textcolor = [
    DailozColor.purple,
    DailozColor.lightred,
    DailozColor.lightred,
    DailozColor.textblue,
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            splashColor: DailozColor.transparent,
            highlightColor: DailozColor.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: height/20,
              width: height/20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: DailozColor.white,
                  boxShadow: const [
                    BoxShadow(color: DailozColor.textgray,blurRadius: 5)
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.only(left: width/56),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: DailozColor.black,
                ),
              ),
            ),
          ),
        ),
        title: Text("Detail".tr,style: hsSemiBold.copyWith(fontSize: 18),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              splashColor: DailozColor.transparent,
              highlightColor: DailozColor.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: height/20,
                width: height/20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: DailozColor.white,
                    boxShadow: const [
                      BoxShadow(color: DailozColor.textgray,blurRadius: 5)
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(DailozPngimage.moreSquare,height: height/36,),
                ),
              ),
            ),
          ),
        ],
      ),   
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Thứ 5 ngày 21 tháng 6 năm 202333".tr,style: hsRegular.copyWith(fontSize: 14),),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Container(
                    width: width / 2.2,
                    decoration: BoxDecoration(
                      color: DailozColor.lightred,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Tổng Điểm".tr,
                              style: hsMedium.copyWith(fontSize: 18, color: const Color(0x80FFFFFF)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "10 + 10 + 5 = 25 điểm",
                              style: hsMedium.copyWith(fontSize: 18, color: DailozColor.white),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  Container(
                    width: width / 2.2,
                    decoration: BoxDecoration(
                      color: DailozColor.lightred,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Doanh Thu".tr,
                              style: hsMedium.copyWith(fontSize: 18, color: const Color(0x80FFFFFF)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "500.000đ",
                              style: hsMedium.copyWith(fontSize: 18, color: DailozColor.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],


              ),
              SizedBox(height: height/36,),
              Text("Task".tr,style: hsSemiBold.copyWith(fontSize: 20),),
              SizedBox(height: height/36,),
              ListView.separated(
                itemCount:4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: DailozColor.transparent,
                      highlightColor: DailozColor.transparent,
                      onTap: () {
                        setState(() {
                          if(isselected.contains(index)){
                            isselected.remove(index);
                          }else{
                            isselected.add(index);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(isselected.contains(index)?Icons.check_box_sharp:Icons.check_box_outline_blank,size: 22,color: isselected.contains(index)?DailozColor.appcolor:DailozColor.textgray,),
                          SizedBox(width: width/36,),
                          Text("Creating this month's work plan",style: hsRegular.copyWith(fontSize: 16,),),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(indent: 30,);
                  },
                 ),
              SizedBox(height: height/36,),
              Text("Tag".tr,style: hsSemiBold.copyWith(fontSize: 20),),
              SizedBox(height: height/46,),
              SizedBox(
                height: height/21,
                child: ListView.builder(
                  itemCount: tag.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: color[index]
                      ),
                      child: Center(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/20),
                        child: Text(tag[index],style: hsRegular.copyWith(fontSize: 14,color: textcolor[index]),),
                      )),
                    );
                  },),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
