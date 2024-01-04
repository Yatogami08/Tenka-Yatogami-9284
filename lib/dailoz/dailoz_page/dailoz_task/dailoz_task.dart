import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../dailoz_theme/dailoz_themecontroller.dart';
import '../dailoz_task/dailoz_addtask.dart';


class DailozTask extends StatefulWidget {
  const DailozTask({Key? key}) : super(key: key);

  @override
  State<DailozTask> createState() => _DailozTaskState();
}

class _DailozTaskState extends State<DailozTask> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(DailozThemecontroler());

  List name = ["Dữ liệu 1","Dữ liệu 2","Dữ liệu 3"];

  List name2 = ["test","Dữ liệu 2","Dữ liệu 3"];

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

// Phương thức để lấy ngày cuối cùng của tuần
  DateTime _getEndOfWeek(DateTime date) {
    return date.add(Duration(days: 7 - date.weekday));
  }
  @override
  void initState() {
    super.initState();

    DateTime startDate = DateTime.now().subtract(Duration(days: 30));
    selectedDate = DateTime.now();
    isselected = 30;
  }

  DateTime selectedDate = DateTime.now();
  ScrollController scrollController = ScrollController();

  List<String> listOfDays = ["Thứ hai", "thứ ba", "Thứ Tư", "Thứ năm", "Thứ sáu", "Thứ 7	", "Chủ nhật"]; //List of Days


  @override
  Widget build(BuildContext context) {






    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Lịch sử".tr,style: hsSemiBold.copyWith(fontSize: 18),) ,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            children: [

              SizedBox(height: height/26,),
              Row(
                children: [
                  Text("Tìm thấy 18 dữ liệu".tr,style: hsSemiBold.copyWith(fontSize: 24),),
                  const Spacer(),
                  Image.asset(DailozPngimage.calendar,height: height/46,),
                  SizedBox(width: width/36,),
                  Text("Hiện tại "+DateFormat('dd/MM/yyyy').format(selectedDate),style: hsRegular.copyWith(fontSize: 12),),
                ],
              ),
              SizedBox(height: height/36,),

              SizedBox(
                height: height / 8.8,
                child: ListView.builder(
                  itemCount: 31,

                  controller: PageController(
                    initialPage: isselected,
                    viewportFraction: 0.3,
                  ),

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DateTime startDate = DateTime.now().subtract(Duration(days: 30));
                    DateTime currentDate = startDate.add(Duration(days: index));
                    DateFormat dateFormat = DateFormat('dd/MM');

                    return InkWell(
                      onTap: () {
                        setState(() {
                          isselected = index;
                          selectedDate = DateTime.utc(currentDate.year, currentDate.month, currentDate.day);
                        });
                      },
                      child: Container(
                        width: width / 7,
                        margin: EdgeInsets.only(bottom: width / 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isselected == index ? DailozColor.appcolor : DailozColor.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 96),
                          child: Column(
                            children: [
                              Text(
                                listOfDays[currentDate.weekday - 1],
                                style: hsMedium.copyWith(
                                  fontSize: 16,
                                  color: isselected == index
                                      ? DailozColor.white
                                      : themedata.isdark
                                      ? DailozColor.white
                                      : DailozColor.black,
                                ),
                              ),
                              SizedBox(height: height / 96),
                              Text(
                                dateFormat.format(currentDate),
                                style: hsRegular.copyWith(
                                  fontSize: 14,
                                  color: isselected == index
                                      ? DailozColor.white
                                      : themedata.isdark
                                      ? DailozColor.white
                                      : DailozColor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),








              SizedBox(height: height/36,),
              Row(
                children: [
                  Text("Dữ Liệu Tuần".tr,style: hsSemiBold.copyWith(fontSize: 24,color: DailozColor.tim),),
                  const Spacer(),
                  Text("Tuần hiện tại (${DateFormat('dd/MM/yyyy').format(_getStartOfWeek(selectedDate))} - ${DateFormat('dd/MM/yyyy').format(_getEndOfWeek(selectedDate))})",
                    style: hsRegular.copyWith(fontSize: 14,color: DailozColor.tim),
                  ),
                ],
              ),




              SizedBox(height: height/96,),
              if(name.isEmpty)...[
                Image.asset(DailozPngimage.emptytask,height: height/4,fit: BoxFit.fitHeight,),
                SizedBox(height: height/26,),
                Text("bạn không có dữ liệu trong ngày này!\nVui lòng kiểm tra lại.",textAlign: TextAlign.center,style: hsRegular.copyWith(fontSize: 14,),),
              ]else...[
                const Divider(color: DailozColor.textgray,),
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height/46),
                      child: Text("07:00",style: hsMedium.copyWith(fontSize: 14),),
                    ),
                    const Spacer(),




                    SizedBox(
                      height: height/5.7,
                      width: width/1.25,
                      child: ListView.builder(
                        itemCount: name.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width/1.8,
                            margin: EdgeInsets.only(right: width/36),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: DailozColor.bggray
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(name[index],style: hsMedium.copyWith(fontSize: 16,color: DailozColor.black),),
                                      const Spacer(),
                                      SizedBox(
                                        height: height/22,
                                        width: height/26,
                                        child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.closeSquare,height: height/36,color: DailozColor.black,),
                                                SizedBox(width: width/36,),
                                                Text("Disable",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.editSquare,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("chỉnh sửa",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.delete,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Xóa",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          )
                                        ],
                                          offset: const Offset(5, 50),
                                          color: DailozColor.white,
                                          constraints: BoxConstraints(
                                            maxWidth: width/2.8,
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          icon: Image.asset(DailozPngimage.dot,height: height/36,fit: BoxFit.fitHeight,),
                                          elevation: 2,

                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height/200,),
                                  Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: DailozColor.textgray),),
                                  SizedBox(height: height/66,),
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: DailozColor.appcolor),),
                                          )),
                                      SizedBox(width: width/36,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Home",style: hsMedium.copyWith(fontSize: 10,color: DailozColor.appcolor),),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },),
                    )












                  ],
                ),


                SizedBox(height: height/80,),
                Row(
                  children: [
                    Text("Dữ liệu ngày".tr,style: hsSemiBold.copyWith(fontSize: 24,color: DailozColor.tim),),
                    const Spacer(),
                    Text("Thông tin ngày "+ DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: hsRegular.copyWith(fontSize: 14,color: DailozColor.tim),
                    ),
                  ],
                ),

                SizedBox(height: height/80,),


                const Divider(color: DailozColor.textgray,),
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height/46),
                      child: Text("07:00",style: hsMedium.copyWith(fontSize: 14),),
                    ),
                    const Spacer(),

                    SizedBox(
                      height: height/5.7,
                      width: width/1.25,
                      child: ListView.builder(
                        itemCount: name2.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width/1.8,
                            margin: EdgeInsets.only(right: width/36),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: DailozColor.bggray
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(name2[index],style: hsMedium.copyWith(fontSize: 16,color: DailozColor.black),),
                                      const Spacer(),
                                      SizedBox(
                                        height: height/22,
                                        width: height/26,
                                        child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.closeSquare,height: height/36,color: DailozColor.black,),
                                                SizedBox(width: width/36,),
                                                Text("Disable",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.editSquare,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("chỉnh sửa",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: Row(
                                              children: [
                                                Image.asset(DailozPngimage.delete,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Xóa",style: hsRegular.copyWith(fontSize: 16,color: DailozColor.black),),
                                              ],
                                            ),
                                          )
                                        ],
                                          offset: const Offset(5, 50),
                                          color: DailozColor.white,
                                          constraints: BoxConstraints(
                                            maxWidth: width/2.8,
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          icon: Image.asset(DailozPngimage.dot,height: height/36,fit: BoxFit.fitHeight,),
                                          elevation: 2,

                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height/200,),
                                  Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: DailozColor.textgray),),
                                  SizedBox(height: height/66,),
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: DailozColor.appcolor),),
                                          )),
                                      SizedBox(width: width/36,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Home",style: hsMedium.copyWith(fontSize: 10,color: DailozColor.appcolor),),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },),
                    )
                  ],
                ),














              ]










            ],
          ),
        ),
      ),
    );
  }
}