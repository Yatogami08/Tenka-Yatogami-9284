import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../dailoz_theme/dailoz_themecontroller.dart';
import '../../dulieu.dart';
import '../dailoz_home/dailoz_home.dart';
import 'lichsuitem.dart';
import 'lichsuitem.dart';
class chitietlichsu extends StatefulWidget {

  final DatabaseHelper dbHelper = DatabaseHelper();
  final VoidCallback initDataCallback;
  final LichSuItem item;

  chitietlichsu({required this.item, required this.initDataCallback});

  // chitietlichsu({required this.thoigianHd});




  @override
  State<chitietlichsu> createState() => _DailozTaskdetailState();
}

class _DailozTaskdetailState extends State<chitietlichsu> {



  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _solansac;
  late FixedExtentScrollController _tilenhan;
  late FixedExtentScrollController _tilehoanthanh;

  @override
  void initState() {
    super.initState();

    // Tách giờ và phút từ chuỗi thoigianHd
    List<String> parts = widget.item.thoigianHd.split(' ');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[2]);


    int solansacc = widget.item.solansacPin.toInt();
    int tilenhan = widget.item.tilenhanchuyen.toInt();
    int tilehoanthanh = widget.item.tilehoanthanhchuyen.toInt();
    // Đặt giá trị cho _hourController và _minuteController
    _hourController = FixedExtentScrollController(initialItem: hour - 1);
    _minuteController = FixedExtentScrollController(initialItem: minute - 1);

    _solansac = FixedExtentScrollController(initialItem: solansacc - 1);
    _tilenhan = FixedExtentScrollController(initialItem: tilenhan - 1);
    _tilehoanthanh = FixedExtentScrollController(initialItem: tilehoanthanh - 1);


  }



  bool interactionEnabled = true;



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
  FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 100);




  FixedExtentScrollController _scrollController1 = FixedExtentScrollController(initialItem: 100);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("${widget.item.gioThemDuLieu}".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.tim),),
              SizedBox(height: height/36,),






              SizedBox(
                height: height/21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {

                    String labelText = "";
                    Color labelColor = Colors.black;
                    Color textColor = Colors.black;

                    switch(index) {
                      case 0:
                        labelText = "Cao điểm sáng : ${widget.item.cdSang}";
                        labelColor = DailozColor.tim;
                        textColor = DailozColor.white;
                        break;
                      case 1:
                        labelText = "Cao điểm tối : ${widget.item.cdToi}";
                        labelColor = DailozColor.tim;
                        textColor = DailozColor.white;
                        break;

                      default:
                        break;
                    }

                    return Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: labelColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/20),
                          child: Text(labelText, style: hsRegular.copyWith(fontSize: 14, color: textColor)),
                        ),
                      ),
                    );
                  }),
                ),
              ),


              SizedBox(height: height/200,),

              SizedBox(
                height: height/21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(1, (index) {

                    String labelText = "";
                    Color labelColor = Colors.black;
                    Color textColor = Colors.black;

                    switch(index) {
                      case 0:
                        labelText = "Đơn thường : ${widget.item.donThuong}";
                        labelColor = DailozColor.tim;
                        textColor = DailozColor.white;
                        break;
                      case 1:
                        labelText = "Cao điểm tối : 10";
                        labelColor = DailozColor.tim;
                        textColor = DailozColor.white;
                        break;

                      default:
                        break;
                    }

                    return Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: labelColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/20),
                          child: Text(labelText, style: hsRegular.copyWith(fontSize: 14, color: textColor)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 3,  // Điều chỉnh chiều rộng của SizedBox tại đây
                    child: InkWell(
                      splashColor: DailozColor.transparent,
                      highlightColor: DailozColor.transparent,
                      onTap: () {

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height / 72),
                          Align(
                            alignment: Alignment.center,
                            child: Text("yatogami5".tr, style: hsSemiBold.copyWith(fontSize: 14, color: DailozColor.tenka)),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: IgnorePointer(
                                  ignoring: true, // Đặt thành false để cho phép tương tác
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    scrollController: _hourController,
                                    onSelectedItemChanged: (int index) {
                                      // Xử lý khi giá trị được chọn thay đổi
                                      // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                                    },
                                    children: List.generate(16, (index) {
                                      return Center(
                                        child: Text(
                                          '${index + 1} Giờ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: themedata.isdark ? DailozColor.white : DailozColor.black,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),




















                              ),
                              Expanded(
                                child:   IgnorePointer(
                                  ignoring: true, // Đặt thành false để cho phép tương tác
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    scrollController:_minuteController,
                                    onSelectedItemChanged: (int index) {
                                      // Xử lý khi giá trị được chọn thay đổi
                                      // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                                    },
                                    children: List.generate(59, (index) {
                                      return Center(
                                        child: Text(
                                          '${index + 1} Phút',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: themedata.isdark ? DailozColor.white : DailozColor.black,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),

























                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: width/2.2,
                    child: InkWell(
                      splashColor: DailozColor.transparent,
                      highlightColor: DailozColor.transparent,
                      onTap: () {

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height/72),
                          Align(
                            alignment: Alignment.center,
                            child: Text("yatogami6".tr, style: hsSemiBold.copyWith(fontSize: 14, color: DailozColor.tenka)),
                          ),
                          IgnorePointer(
                            ignoring: true, // Đặt thành true để chặn tương tác
                            child: CupertinoPicker(
                              itemExtent: 32.0,
                              scrollController: _solansac,
                              onSelectedItemChanged: (int index) {
                                // Xử lý khi giá trị được chọn thay đổi
                                // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                              },
                              children: List.generate(20, (index) {
                                return Center(
                                  child: Text(
                                    '${index + 1} lần sạc',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: themedata.isdark ? DailozColor.white : DailozColor.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(

                    width: width/2.2,
                    child: InkWell(
                      splashColor: DailozColor.transparent,
                      highlightColor: DailozColor.transparent,
                      onTap: () {

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height/72),

                          Align(
                            alignment: Alignment.center,
                            child: Text("yatogami7".tr, style: hsSemiBold.copyWith(fontSize: 14, color: DailozColor.tenka)),
                          ),
                          CupertinoPicker(
                            itemExtent: 32.0,
                            scrollController: _tilenhan,  // Sử dụng ScrollController

                            onSelectedItemChanged: (int index) {
                              setState(() {

                              });
                              // Xử lý khi giá trị được chọn thay đổi
                              // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                            },
                            children: List.generate(100, (index) {
                              return Center(
                                child: Text(
                                  '${index + 1}%',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: themedata.isdark ? DailozColor.white : DailozColor.black,
                                  ),
                                ),
                              );
                            }),
                          ),

                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: width/2.2,
                    child: InkWell(
                      splashColor: DailozColor.transparent,
                      highlightColor: DailozColor.transparent,
                      onTap: () {

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height/72),

                          Align(
                            alignment: Alignment.center,
                            child: Text("yatogami8".tr, style: hsSemiBold.copyWith(fontSize: 14, color: DailozColor.tenka)),
                          ),
                          CupertinoPicker(
                            itemExtent: 32.0,
                            scrollController: _tilehoanthanh,  // Sử dụng ScrollController

                            onSelectedItemChanged: (int index) {
                              setState(() {
                              });
                              // Xử lý khi giá trị được chọn thay đổi
                              // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                            },
                            children: List.generate(100, (index) {
                              return Center(
                                child: Text(
                                  '${index + 1}%',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: themedata.isdark ? DailozColor.white : DailozColor.black,
                                  ),
                                ),
                              );
                            }),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height/36,),
              SizedBox(
                height: height/21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    String labelText = "";
                    Color labelColor = Colors.black;
                    Color textColor = Colors.black;

                    switch(index) {
                      case 0:
                        labelText = "Tổng Chuyến:  ${widget.item.tongChuyen}";
                        labelColor = DailozColor.bgpurple;
                        textColor = DailozColor.purple;
                        break;
                      case 1:
                        labelText = "Thưởng vượt mốc: ${widget.item.vuotChuyen}";
                        labelColor = DailozColor.bgred;
                        textColor = DailozColor.lightred;
                        break;
                      case 2:
                        labelText = "Mục 3";
                        labelColor = const Color(0xffFFE9ED);
                        textColor = DailozColor.lightred;
                        break;
                      case 3:
                        labelText = "Mục 4";
                        labelColor = DailozColor.bgsky;
                        textColor = DailozColor.textblue;
                        break;
                      default:
                        break;
                    }

                    return Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: labelColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/20),
                          child: Text(labelText, style: hsRegular.copyWith(fontSize: 14, color: textColor)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: height/36,),
              SizedBox(
                height: height/21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Đặt giá trị MainAxisAlignment.center ở đây
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: DailozColor.bgred,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/20),
                          child: Text(
                            "Đảm bảo thu nhập: ${widget.item.dbThuNhap}",
                            style: hsRegular.copyWith(fontSize: 14,color: DailozColor.yatogamineee),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



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
                              style: hsMedium.copyWith(fontSize: 18, color: DailozColor.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${widget.item.tongDiem} Điểm",
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
                      color: DailozColor.yatogamineee,
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
                              "Doanh Thu Ngày".tr,
                              style: hsMedium.copyWith(fontSize: 18, color: DailozColor.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${widget.item.doanhThuNgay}đ",
                              style: hsMedium.copyWith(fontSize: 18, color: DailozColor.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],


              ),
              SizedBox(height: height/100,),



              SizedBox(height: height/36,),
              Text("Task".tr,style: hsSemiBold.copyWith(fontSize: 20),),
              SizedBox(height: height/36,),
              ListView.separated(
                itemCount:1,
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
                        Text("Xác nhận xóa",style: hsRegular.copyWith(fontSize: 16,),),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(indent: 30,);
                },
              ),

              SizedBox(height: height/50,),
              InkWell(
                splashColor: DailozColor.transparent,
                highlightColor: DailozColor.transparent,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Thông tin'),
                      content: Text('Bạn có chắc chắn muốn xóa dữ liệu này không?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Đóng hộp thoại xác nhận
                          },
                          child: Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            _deleteDataAndNavigateBack(context, widget.item);
                          },
                          child: Text('Xóa'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: width/1,
                  height: height/15,
                  decoration: BoxDecoration(
                    color: DailozColor.appcolor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      'Xóa dữ liệu',
                      style: hsSemiBold.copyWith(fontSize: 16, color: DailozColor.white),
                    ),
                  ),
                ),
              ),






            ],
          ),
        ),
      ),
    );
  }



  void _deleteDataAndNavigateBack(BuildContext context, LichSuItem item) async {
    try {
      await dbHelper.deleteLichSuItem(item.id);

      widget.initDataCallback();

      Navigator.of(context).pop();
      Navigator.of(context).pop(); // Go back to the previous screen

    } catch (e) {
      print('Lỗi khi xóa dữ liệu: $e');
    }
  }


}


