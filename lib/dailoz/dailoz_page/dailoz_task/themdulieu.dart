import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_color.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_fontstyle.dart';
import 'package:dailoz/dailoz/dailoz_gloabelclass/dailoz_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../dailoz_theme/dailoz_themecontroller.dart';
import 'package:intl/intl.dart';

import '../../dulieu.dart';

class themdulieu extends StatefulWidget {
  themdulieu({required this.initDataCallback});

  final VoidCallback initDataCallback;






  @override

  State<themdulieu> createState() => _DailozAddTaskState();

}

class _DailozAddTaskState extends State<themdulieu> {
  late String caDangKiAdmin;
  int caoDiemSang = 0;
  int caoDiemToi = 0;
  int donThuong = 0;
  int  thunhap = 0;
  int  soGioHoatDong = 0;
  int soLanSacPin = 0;
  int thoiGianSac = 0;
  int tiLeNhanChuyen = 100;
  int tiLeHoanThanhChuyen = 100;
  double tongDiem = 0.0;

  int tongDiemsm = 0;
  int thuongVuotMoc = 0;



  int gio = 0;
  int phut = 0;
 late String chuoiThoiGian;
  late DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(DateTime.now());
    pickedDate = DateTime.now();
    caDangKiAdmin = "";
    chuoiThoiGian ="";
    _fetchCaDangKiAdmin();
  }


  Future<void> _fetchCaDangKiAdmin() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final result = await databaseHelper.fetchCaDangKiAdmin();
    setState(() {
      caDangKiAdmin = result['ca_dangkiadmin'] ?? "";
    });
  }
  void _calculateTotalScore() {
    TimeOfDay thoiGian = TimeOfDay(hour: gio, minute: phut);
     chuoiThoiGian = "${thoiGian.hour}.${thoiGian.minute}";





    setState(() {
      if (pickedDate.weekday == 6 || pickedDate.weekday == 7) {
        tongDiem = caoDiemSang * 1.5 + caoDiemToi * 2 + donThuong;

      } else {
        tongDiem = (caoDiemSang.toDouble() * 2) + caoDiemToi * 2 + donThuong +0.0;


      }
      _calculateBonus();
    });
  }

  void _calculateBonus() {


    tongDiemsm = caoDiemSang + caoDiemToi + donThuong;
    if (caDangKiAdmin == '5h' && tiLeHoanThanhChuyen.toInt() >= 90 && tiLeNhanChuyen.toInt() >= 90 ) {
      if (tongDiemsm >= 12) {
        thuongVuotMoc = (12 - 8 + 1) * 4000 + (tongDiemsm - 12) * 6000;
      } else {
        thuongVuotMoc = (tongDiemsm - 8 + 1) * 4;
      }
    } else if (caDangKiAdmin == '8h' || caDangKiAdmin == '10h' && tiLeHoanThanhChuyen.toInt() >= 90 && tiLeNhanChuyen.toInt() >= 90) {
      if (tongDiemsm >= 16) {
        thuongVuotMoc = (16 - 12 + 1) * 4000 + (tongDiemsm - 16) * 6000;
      } else {
        thuongVuotMoc = (tongDiemsm - 12 + 1) * 4000;
      }
    } else {
      thuongVuotMoc = 0;
    }


    thuongVuotMoc = thuongVuotMoc < 0 ? 0 : thuongVuotMoc;


  }


  void saveData() async {
    // Create a DatabaseHelper instance
    DatabaseHelper databaseHelper = DatabaseHelper();
    NumberFormat currencyFormatter = NumberFormat("#,##000", "vi_VN");
    // Prepare data to be inserted

    bool dataExists = await databaseHelper.checkDataExists(
        'yatosm', 'ngay', DateFormat('yyyy-MM-dd').format(pickedDate));


    if (dataExists) {
      // Hiển thị thông báo hoặc thực hiện xử lý phù hợp khi dữ liệu đã tồn tại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dữ liệu cho ngày đã chọn đã tồn tại.'),
        ),
      );
    } else {
      // Nếu chưa có dữ liệu, thực hiện thêm mới

      Map<String, dynamic> data = {
        'thu': DateFormat('EEEE', 'vi_VN').format(pickedDate),
        'ngay': DateFormat('yyyy-MM-dd').format(pickedDate),
        'cd_sang': caoDiemSang,
        'cd_toi': caoDiemToi,
        'don_thuong': donThuong,
        'tong_chuyen': caoDiemSang + caoDiemToi + donThuong,
        'tong_diem': tongDiem.toDouble(),
        'doanh_thungay': "${NumberFormat("#,##0", "vi_VN").format(thunhap)}",
        'vuot_chuyen': thuongVuotMoc > 0
            ? '${NumberFormat("#,##0", "vi_VN").format(thuongVuotMoc)}'
            : '',
        'db_thunhap': _calculateGuaranteedIncome(),
        'diem_tuan': caoDiemToi,
        'du_gio': caDangKiAdmin == '5h' && chuoiThoiGian.toDouble() >= 5.0 ||
            caDangKiAdmin == '8h' && chuoiThoiGian.toDouble() >= 8.0 ||
            caDangKiAdmin == '10h' && chuoiThoiGian.toDouble() >= 10.0
            ? 'Đã đủ'
            : 'Chưa đủ ',
        'ca_dangki': caDangKiAdmin,
        'gio_themdulieu': DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(
            pickedDate),
        'thoigian_hd': gio.toString()+" giờ "+phut.toString()+" phút",
        'solansac_pin': soLanSacPin,
        'thoigian_sac': caoDiemToi,
        'tilenhanchuyen': '$tiLeNhanChuyen',
        'tilehuychuyen': '$tiLeNhanChuyen',
        'tilehoanthanhchuyen': '$tiLeHoanThanhChuyen',
        'yatagami7': caoDiemToi,
        'yatagami8': caoDiemToi,
        'yatagami9': caoDiemToi,
        'yatagami10': caoDiemToi,
        'yatagami11': caoDiemToi,
        'yatagami12': caoDiemToi,
        'yatagami13': caoDiemToi,
        'yatagami14': caoDiemToi,
        'yatagami15': caoDiemToi,
        'yatagami16': caoDiemToi,
      };

      // Insert data into the 'yatosm' table
      await databaseHelper.insert('yatosm', data);

      // Optionally, you can show a snackbar or navigate to another screen after saving
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dữ liệu đã được lưu.'),




        ),
      );


      Future.delayed(Duration(seconds: 0), () {


widget.initDataCallback();
            Navigator.of(context).pop(); // Go back to the previous screen

      });


    }
  }
  String formatHoursAndMinutes(double hours) {
    int intHours = hours.toInt();
    int minutes = ((hours - intHours) * 60).toInt();
    String formattedTime = '$intHours giờ ${minutes > 0 ? '$minutes phút' : ''}';
    return formattedTime;
  }

  String _calculateGuaranteedIncome() {

    NumberFormat currencyFormatter = NumberFormat("#,##0", "vi_VN");
    if (caDangKiAdmin == '5h' && chuoiThoiGian.toDouble() >= 5.0 && thunhap < 200000 && tongDiemsm >= 5 && tiLeHoanThanhChuyen.toInt() >= 90 && tiLeNhanChuyen.toInt() >= 90) {
      return '${currencyFormatter.format(200000 - thunhap)}đ';
    } else if (caDangKiAdmin == '8h' && chuoiThoiGian.toDouble() >= 8.0 && thunhap < 320000 && tongDiemsm >= 8 && tiLeHoanThanhChuyen.toInt() >= 90 && tiLeNhanChuyen.toInt() >= 90) {
      return '${currencyFormatter.format(320000 - thunhap)}đ';
    } else if (caDangKiAdmin == '10h' && chuoiThoiGian.toDouble() >= 10.0 && thunhap < 400000 && tongDiemsm >= 10 && tiLeHoanThanhChuyen.toInt() >= 90 && tiLeNhanChuyen.toInt() >= 90) {
      return '${currencyFormatter.format(400000 - thunhap)}đ';

    } else {
      return 'Chưa đạt điều kiện !';
    }
  }






  final TextEditingController dateController = TextEditingController();

  FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 100);
  FixedExtentScrollController _scrollController1 = FixedExtentScrollController(initialItem: 100);











  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  int selecttime = 0;
  DateTime? _selectedDay;
  String? selectdate;
  final themedata = Get.put(DailozThemecontroler());
  List type = ["Personal","Private","Secret"];

  List tag = ["Thưởng vượt mốc :" ,"44.000đ","Urgent","Work"];

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

  List hour = ["01","02","03","04","05","06","07","08"];
  List min = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"];











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
        title:  Text("yatogami0".tr+thunhap.toString(),style: hsSemiBold.copyWith(fontSize: 18),),
      ),





      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("yatogami1".tr,style: hsSemiBold.copyWith(fontSize: 14,color: DailozColor.tenka),),




              TextField(
                controller: dateController,
                style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?DailozColor.white:DailozColor.black),
                decoration: InputDecoration(
                    hintStyle: hsMedium.copyWith(fontSize: 16,color: DailozColor.tenka),
                    hintText: DateFormat('dd MMMM yyyy').format(DateTime.now()),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                          splashColor: DailozColor.transparent,
                          highlightColor: DailozColor.transparent,
                          onTap: () {
                            calendar();
                            _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết

                          },
                          child: Image.asset(DailozPngimage.calendar,height: height/36,color: DailozColor.textgray)),
                    ),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: DailozColor.greyy)
                    )
                ),
              ),

              SizedBox(height: height/40,),
              Text("yatogami2".tr,style: hsSemiBold.copyWith(fontSize: 14,color: DailozColor.tenka),),

          CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                caoDiemSang = index;
                _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
              });
            },
            children: List.generate(21, (index) {
              return Center(
                child: Text(
                  '${index} Đơn',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: themedata.isdark ? DailozColor.white : DailozColor.black,
                  ),
                ),
              );
            }),
          ),



              SizedBox(height: height/40,),
              Text("yatogami3".tr,style: hsSemiBold.copyWith(fontSize: 14,color: DailozColor.tenka),),

              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {


                  setState(() {
                    caoDiemToi = index;
                    _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
                  });

                  // Xử lý khi giá trị được chọn thay đổi
                  // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                },
                children: List.generate(20, (index) {
                  return Center(
                    child: Text(
                      '${index} Đơn',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: themedata.isdark ? DailozColor.white : DailozColor.black,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: height/40,),
              Text("yatogami4".tr,style: hsSemiBold.copyWith(fontSize: 14,color: DailozColor.tenka),),

              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {

                  setState(() {
                    donThuong = index ;
                    _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
                  });
                  // Xử lý khi giá trị được chọn thay đổi
                  // Ở đây, bạn có thể cập nhật giá trị hoặc thực hiện các tác vụ khác cần thiết
                },
                children: List.generate(20, (index) {
                  return Center(
                    child: Text(
                      '${index} Đơn',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: themedata.isdark ? DailozColor.white : DailozColor.black,
                      ),
                    ),
                  );
                }),
              ),



              SizedBox(height: height/36,),
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
                                child: CupertinoPicker(
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (int index) {
                                    setState(() {
                                      gio = index + 1;
                                      _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
                                    });
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
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (int index) {

                                    setState(() {
                                      phut = index + 1;
                                      _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
                                    });

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
                          CupertinoPicker(
                            itemExtent: 32.0,
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

                        ],
                      ),
                    ),
                  ),
                ],
              ),




              SizedBox(height: height/36,),
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
                            scrollController: _scrollController,  // Sử dụng ScrollController

                            onSelectedItemChanged: (int index) {
                              setState(() {
                                tiLeNhanChuyen = index + 1;
                                _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
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
                            scrollController: _scrollController1,  // Sử dụng ScrollController

                            onSelectedItemChanged: (int index) {
                              setState(() {
                                tiLeHoanThanhChuyen = index + 1;
                                _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết
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
              Text("yatogami9".tr, style: hsSemiBold.copyWith(fontSize: 14, color: DailozColor.tim)),
              TextField(
                keyboardType: TextInputType.number,
                style: hsMedium.copyWith(fontSize: 16, color: themedata.isdark?DailozColor.white:DailozColor.black),
                inputFormatters: [CurrencyInputFormatter()], // Sử dụng DecimalTextInputFormatter để định dạng số
                onChanged: (value) {
                  String numericValue = convertToNumber(value);


                  setState(() {
                    // Đặt bất cứ logic nào bạn muốn thực hiện khi giá trị thay đổi ở đây
                    // Ví dụ: yourVariable = value;
                    thunhap = value.toInt();

                    thunhap = int.tryParse(numericValue) ?? 0;




                  });
                },

                decoration: InputDecoration(
                  hintStyle: hsMedium.copyWith(fontSize: 16, color: DailozColor.textgray),
                  hintText: "Doanh thu Ví dụ : 100000",

                  suffixStyle: TextStyle(fontSize: 16, color: themedata.isdark?DailozColor.white:DailozColor.black),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: DailozColor.greyy),
                  ),
                ),
              ),



              SizedBox(height: height/36,),
              SizedBox(
                height: height/21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    NumberFormat currencyFormatter = NumberFormat("#,##0", "vi_VN");
                    String labelText = "";
                    Color labelColor = Colors.black;
                    Color textColor = Colors.black;

                    switch(index) {
                      case 0:
                        labelText = "Tổng điểm: $tongDiem điểm";
                        labelColor = DailozColor.bgpurple;
                        textColor = DailozColor.purple;
                        break;
                      case 1:
                        labelText = "Thưởng vượt mốc: ${currencyFormatter.format(thuongVuotMoc)}đ";
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




              SizedBox(height: height/80,),






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
                            "Đảm bảo thu nhập: ${_calculateGuaranteedIncome()}",






                            style: hsRegular.copyWith(fontSize: 14,color: DailozColor.yatogamineee),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

















              SizedBox(height: height/50,),
              InkWell(
                splashColor: DailozColor.transparent,
                highlightColor: DailozColor.transparent,
                onTap: () {
         saveData();






                },
                child: Container(
                  width: width/1,
                  height: height/15,
                  decoration: BoxDecoration(
                      color: DailozColor.appcolor,
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Center(child: Text("Create".tr,style: hsSemiBold.copyWith(fontSize: 16,color: DailozColor.white),)),
                ),
              ),
            ],
          ),
        ),
      ),





    );
  }

  Future<bool> calendar() async {




    print('Height: $height, Width: $width');

    return await showDialog(

        builder: (context) => AlertDialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              children: [
                TableCalendar(


                  locale: 'vi_VN', // Sử dụng định dạng ngôn ngữ Tiếng Việt

                  firstDay: DateTime.now().subtract(Duration(days: 30)),

                  focusedDay: DateTime.now(),
                  lastDay: DateTime.utc(2050, 3, 14),
                  headerVisible: true,
                  daysOfWeekVisible: true,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: DailozColor.appcolor,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: DailozColor.white,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: DailozColor.appcolor,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: DailozColor.white,
                    ),
                  ),
                  shouldFillViewport: false,
                  currentDay: _selectedDay,
                  calendarFormat: CalendarFormat.month,
                  pageAnimationEnabled: false,

                  headerStyle: HeaderStyle(
                      leftChevronIcon: SizedBox(
                        height: height / 26,
                        width: height / 26,
                        child: const Icon(
                          Icons.chevron_left,
                          color: DailozColor.textgray,
                        ),
                      ),
                      rightChevronIcon: SizedBox(
                          height: height / 26,
                          width: height / 26,
                          child: const Icon(Icons.chevron_right,
                            color:DailozColor.textgray,)),
                      formatButtonVisible: false,
                      decoration: const BoxDecoration(
                        color: DailozColor.transparent,
                      ),
                      titleCentered: true,
                      titleTextStyle: hsBold.copyWith(
                        fontSize: 16,
                        color: DailozColor.black,
                      )),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);

                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {

                      _selectedDay = selectedDay;
                      print('Selected Day: $_selectedDay');
                      dateController.text = DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(selectedDay);
                      Navigator.pop(context);

                      _calculateTotalScore(); // Bạn có thể sử dụng selectedValue ở đây hoặc bất kỳ nơi nào cần thiết

                      pickedDate = selectedDay;




                      /*  String convertdate = FormatedDate(_selectedDay.toString());
                      selectdate = convertdate;*/
                      // Navigator.pop(context);
                    });

                  },
                ),
                SizedBox(height: height/36,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: DailozColor.transparent,
                        highlightColor: DailozColor.transparent,
                        onTap: () {
                          Navigator.pop(context);

                        },
                        child: Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: DailozColor.appcolor)
                          ),
                          child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.appcolor),)),
                        ),
                      ),
                      SizedBox(width: width/36,),
                      Container(
                        height: height/20,
                        width: width/4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: DailozColor.appcolor
                        ),
                        child: Center(child: Text("Save".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.white),)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height/56,),
              ],
            )
          ],
        ),

        context: context);

  }




  Future<bool> newtag() async {



    return await showDialog(

        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("New_Tag".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/36,),
                  SizedBox(
                    height: height/14,
                    child: TextFormField(
                        cursorColor: DailozColor.black,
                        style: hsMedium.copyWith(fontSize: 16,color: DailozColor.black),
                        decoration: InputDecoration(
                          hintText: 'Add tag'.tr,
                          filled: true,
                          fillColor: DailozColor.bggray,
                          hintStyle: hsMedium.copyWith(fontSize: 16,color: DailozColor.textgray),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        )),
                  ),
                  SizedBox(height: height/36,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: DailozColor.transparent,
                          highlightColor: DailozColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/20,
                            width: width/4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: DailozColor.appcolor)
                            ),
                            child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.appcolor),)),
                          ),
                        ),
                        SizedBox(width: width/36,),
                        Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: DailozColor.appcolor
                          ),
                          child: Center(child: Text("Save".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.white),)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/56,),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  Future<bool> edittime() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("Edit_Time".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/36,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/36),
                    child: SizedBox(
                      height: height/5,
                      child: ListView.builder(
                        itemCount: hour.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.only(bottom: height/200),
                            child: InkWell(
                              splashColor: DailozColor.transparent,
                              highlightColor: DailozColor.transparent,
                              onTap: () {
                                setState(() {
                                  selecttime = index;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(hour[index],style: selecttime == index?hsMedium.copyWith(fontSize: 26,color: DailozColor.appcolor):hsMedium.copyWith(fontSize: 22,color: DailozColor.textgray),),
                                  SizedBox(width: width/36,),
                                  Text("Giờ".tr,style: hsSemiBold.copyWith(fontSize: 22,color:selecttime == index ? DailozColor.appcolor:DailozColor.transparent)),
                                  const Spacer(),
                                  Text(min[index],style: selecttime == index?hsMedium.copyWith(fontSize: 26,color: DailozColor.appcolor):hsMedium.copyWith(fontSize: 22,color: DailozColor.textgray),),
                                  SizedBox(width: width/36,),
                                  Text("Phút".tr,style: hsSemiBold.copyWith(fontSize: 22,color:selecttime == index ? DailozColor.appcolor:DailozColor.transparent)),
                                ],
                              ),
                            ),
                          );
                        },),
                    ),
                  ),
                  SizedBox(height: height/96,),
                  const Divider(),
                  SizedBox(height: height/96,),
                  Row(
                    children: [
                      Text("Reminder_Mode".tr,style: hsMedium.copyWith(fontSize: 16)),
                      const Spacer(),
                      Text("Ring".tr,style: hsMedium.copyWith(fontSize: 14)),
                      SizedBox(width: width/36,),
                      const Icon(Icons.arrow_forward_ios,size: 14,),
                    ],
                  ),
                  SizedBox(height: height/96,),
                  const Divider(),
                  SizedBox(height: height/66,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: DailozColor.transparent,
                          highlightColor: DailozColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/20,
                            width: width/4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: DailozColor.appcolor)
                            ),
                            child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: DailozColor.appcolor),)),
                          ),
                        ),
                        SizedBox(width: width/36,),



                          InkWell(
                          splashColor: DailozColor.transparent,
                          highlightColor: DailozColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height / 20,
                            width: width / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: DailozColor.appcolor),
                            child: Center(
                              child: Text(
                                "Save".tr,
                                style: hsRegular.copyWith(
                                  fontSize: 14,
                                  color: DailozColor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/56,),
                ],
              ),
            )
          ],
        ),
        context: context);

  }






  String convertToNumber(String valueWithCurrency) {
    // Loại bỏ chữ và dấu phẩy từ chuỗi
    String cleanedValue = valueWithCurrency.replaceAll(RegExp(r'[^\d]'), '');

    // Chuyển đổi chuỗi thành số

     thunhap =int.tryParse(cleanedValue) ?? 0;

    return thunhap.toString();

  }
}
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value is empty
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    // Remove non-digit characters from the input value
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // If the old value is not empty and the new value is shorter than the old value,
    // it means the user pressed the backspace key
    if (oldValue.text.isNotEmpty && oldValue.text.length > newValue.text.length) {
      // Remove the last character from the input value
      newText = newText.substring(0, newText.length - 1);
    }

    // Format the number using NumberFormat
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    String formattedText = formatter.format(int.parse(newText));

    // Add 'đ' at the beginning
    formattedText = '$formattedTextđ';

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}



