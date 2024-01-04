import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dulieu.dart';
import '../dailoz_task/dailoz_taskdetail.dart';
import 'dailoz_addpersonal.dart';

class DailozWork extends StatefulWidget {
  const DailozWork({Key? key}) : super(key: key);

  @override
  State<DailozWork> createState() => _DailozWorkState();
}

class _DailozWorkState extends State<DailozWork> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
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
        title:  Text("Work".tr,style: hsSemiBold.copyWith(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width/1.35,
                    child: TextFormField(
                        cursorColor: DailozColor.black,
                        style: hsMedium.copyWith(fontSize: 16,color: DailozColor.textgray),
                        decoration: InputDecoration(
                          hintText: 'Search for task'.tr,
                          filled: true,
                          fillColor: DailozColor.bggray,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 22,
                            color: DailozColor.grey,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Container(
                              height: height/96,
                              width: height/96,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: DailozColor.textgray
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 12,
                                color: DailozColor.white,
                              ),
                            ),
                          ),
                          hintStyle: hsMedium.copyWith(fontSize: 16,color: DailozColor.textgray),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        )),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: DailozColor.transparent,
                    highlightColor: DailozColor.transparent,
                    onTap: () {
                      // filter();
                    },
                    child: Container(
                        height: height/13,
                        width: height/13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: DailozColor.bggray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Image.asset(DailozPngimage.filter,height: height/36,),
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/36,),




              ListView.builder(
                itemCount: 4, // Hiển thị tối đa 4 dữ liệu gần đây nhất
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // Lấy dữ liệu từ cơ sở dữ liệu (sử dụng FutureBuilder)
                  return FutureBuilder<Map<String, dynamic>>(
                    future: DatabaseHelper().getNhiemVuData(index),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data = snapshot.data!;
                          String date = data['ca_dangki'] ?? '';
                          String thu = data['muc'] ?? '';


                          String diemtrungbinh = data['diemtrungbinh'] ?? '';

                          String activityDuration = data['diemthuong'] ?? '';
                          String caDangKi = data['ca_dangki'] ?? '';
                          String muocthuongvnd = data['muocthuongvnd'] ?? '';

                          if (date.isNotEmpty) {
                            return InkWell(
                              splashColor: DailozColor.transparent,
                              highlightColor: DailozColor.transparent,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const DailozTaskdetail();
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: height / 46),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: DailozColor.bggray,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width / 36,
                                    vertical: height / 66,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text( "Thưởng Điểm Tuần " +thu +" ", style: hsMedium.copyWith(fontSize: 16, color: DailozColor.black)),
                                          const Spacer(),
                                          Image.asset(DailozPngimage.dot, height: height / 36),
                                        ],
                                      ),
                                      SizedBox(height: height / 200),
                                      Text("Yêu cầu : $activityDuration", style: hsRegular.copyWith(fontSize: 14, color: DailozColor.textgray)),
                                      SizedBox(height: height / 66),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 120),
                                              child: Text("Đại sứ $caDangKi", style: hsMedium.copyWith(fontSize: 10, color: DailozColor.red)),
                                            ),
                                          ),
                                          SizedBox(width: width / 36),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 120),
                                              child: Text("$muocthuongvnd/Tuần", style: hsMedium.copyWith(fontSize: 10, color: DailozColor.tim)),
                                            ),
                                          ),

                                          SizedBox(width: width / 36),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 120),
                                              child: Text("$diemtrungbinh/Ngày", style: hsMedium.copyWith(fontSize: 10, color: DailozColor.xanh)),
                                            ),
                                          ),


                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(); // Trả về một Container rỗng nếu không có dữ liệu
                          }
                        } else {
                          return Container(); // Trả về một Container rỗng nếu không có dữ liệu
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
              )











            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DailozColor.appcolor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DailozAddPersonal("work");
          },));
        },
        child: const Icon(Icons.add,size: 22,color: DailozColor.white,),
      ),
    );
  }











}
