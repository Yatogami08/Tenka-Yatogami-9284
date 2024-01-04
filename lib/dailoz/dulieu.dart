import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dailoz_page/dailoz_home/dailoz_home.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;
  DatabaseHelper._internal();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE yatosm (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        thu TEXT,
        ngay TEXT,
        cd_sang INTEGER,
        cd_toi INTEGER,
        don_thuong INTEGER,
        tong_chuyen INTEGER,
        tong_diem INTEGER,
        doanh_thungay TEXT,
        vuot_chuyen TEXT,
        db_thunhap TEXT,
        diem_tuan INTEGER,
        du_gio INTEGER,
        ca_dangki TEXT,
        gio_themdulieu TEXT,
        thoigian_hd TEXT,
        solansac_pin TEXT,
        thoigian_sac TEXT,
        tilenhanchuyen TEXT,
        tilehuychuyen TEXT,
        tilehoanthanhchuyen TEXT,
        yatagami7 TEXT,
        yatagami8 TEXT,
        yatagami9 TEXT,
        yatagami10 TEXT,
        yatagami11 TEXT,
        yatagami12 TEXT,
        yatagami13 TEXT,
        yatagami14 TEXT,
        yatagami15 TEXT,
        yatagami16 TEXT
      )
    ''');





    // Tạo bảng yatoadmin
    await db.execute('''
    CREATE TABLE nhiemvu (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
        ca_dangki TEXT,
        muc TEXT,
        diemthuong TEXT,
        muocthuongvnd TEXT,
        diemtrungbinh TEXT,
        yato_1 TEXT,
        yato_2 TEXT,
        yato_3 TEXT,
        yato_4 TEXT,
        yato_5 TEXT
    
    )
  ''');

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '5h',
        'muc': 'Mức 1',
        'diemthuong': 'Từ 90 điểm tới 114 điểm',
        'muocthuongvnd': '200.000 VNĐ',
        'diemtrungbinh': '13 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu5h1',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '5h',
        'muc': 'Mức 2',
        'diemthuong': 'Từ 115 điểm tới 134 điểm',
        'muocthuongvnd': '300.000 VNĐ',
        'diemtrungbinh': '17 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu5h2',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '5h',
        'muc': 'Mức 3',
        'diemthuong': 'Từ 135 điểm trở lên',
        'muocthuongvnd': '400.000 VNĐ',
        'diemtrungbinh': '20 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu5h3',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );




    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '8h',
        'muc': 'Mức 1',
        'diemthuong': 'Từ 135 điểm tới 164 điểm',
        'muocthuongvnd': '500.000 VNĐ',
        'diemtrungbinh': '20 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h1',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '8h',
        'muc': 'Mức 2',
        'diemthuong': 'Từ 165 điểm tới 194 điểm',
        'muocthuongvnd': '600.000 VNĐ',
        'diemtrungbinh': '24 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h2',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '8h',
        'muc': 'Mức 3',
        'diemthuong': 'Từ 195 điểm tới 224 điểm',
        'muocthuongvnd': '700.000 VNĐ',
        'diemtrungbinh': '28 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h3',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '8h',
        'muc': 'Mức 4',
        'diemthuong': 'Từ 225 điểm trở lên',
        'muocthuongvnd': '1.100.000 VNĐ',
        'diemtrungbinh': '33 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h4',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '10h',
        'muc': 'Mức 1',
        'diemthuong': 'Từ 135 điểm tới 164 điểm',
        'muocthuongvnd': '500.000 VNĐ',
        'diemtrungbinh': '20 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h1',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '10h',
        'muc': 'Mức 2',
        'diemthuong': 'Từ 165 điểm tới 194 điểm',
        'muocthuongvnd': '600.000 VNĐ',
        'diemtrungbinh': '24 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h2',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '10h',
        'muc': 'Mức 3',
        'diemthuong': 'Từ 195 điểm tới 224 điểm',
        'muocthuongvnd': '700.000 VNĐ',
        'diemtrungbinh': '28 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h3',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );

    await db.insert(
      'nhiemvu',
      {
        'ca_dangki': '10h',
        'muc': 'Mức 4',
        'diemthuong': 'Từ 225 điểm trở lên',
        'muocthuongvnd': '1.100.000 VNĐ',
        'diemtrungbinh': '33 điểm',
        'yato_1': 'tuan',
        'yato_2': 'nhiemvu8h4',
        'yato_3': 'test2',
        'yato_4': 'test3',
        'yato_5': 'test4',
      },
    );






    // Tạo bảng yatoadmin
    await db.execute('''
    CREATE TABLE yatoadmin (
      ca_dangkiadmin TEXT,
        kichthuoc_font TEXT,
      nhiemvutuan TEXT,
      keykichhoat TEXT
    
    )
  ''');
    await db.insert(
      'yatoadmin',
      {
        'ca_dangkiadmin': '10h',
        'keykichhoat': 'xanhsm',
        'nhiemvutuan': 'xanhsm',
        'kichthuoc_font': '21.0',
      },
    );




  }


  Future<int> countNhiemVuData(String caDangKiAdmin) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM nhiemvu WHERE ca_dangki = ?',
      [caDangKiAdmin],
    )) ?? 0;
  }
  Future<void> deleteLichSuItem(int id) async {
    final db = await database;
    await db.delete(
      'yatosm',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAllLichSu() async {
    Database db = await database;
    return await db.query('yatosm', orderBy: 'ngay DESC');
  }


  Future<Map<String, dynamic>> getNhiemVuData(int index) async {
    final db = await database;

    // Lấy giá trị ca_dangkiadmin từ bảng yatoadmin
    String? caDangKiAdmin = await DatabaseHelper().getCaDangKiAdmin();

    List<Map<String, dynamic>> result = await db.query(
      'nhiemvu',
      where: 'ca_dangki = ?', // Lọc dữ liệu theo trường ca_dangki
      whereArgs: [caDangKiAdmin], // Giá trị ca_dangkiadmin từ bảng yatoadmin
      orderBy: 'id ASC', // Sắp xếp theo id tăng dần
      limit: 4, // Lấy 4 bản ghi gần đây nhất
      offset: index, // Bắt đầu từ vị trí chỉ định
    );

    if (result.isNotEmpty) {
      return result[0];
    } else {
      return {}; // Trả về một Map rỗng nếu không có dữ liệu
    }
  }







  void _sortDataByDate() {
    lichSuItems.sort((a, b) => b.ngay.compareTo(a.ngay));
  }






  Future<Map<String, dynamic>> getRecentData(int index) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'yatosm',
      orderBy: 'gio_themdulieu DESC', // Sắp xếp theo thời gian giảm dần
      limit: 4, // Lấy 4 bản ghi gần đây nhất
      offset: index, // Bắt đầu từ vị trí chỉ định
    );

    if (result.isNotEmpty) {
      return result[0];
    } else {
      return {}; // Trả về một Map rỗng nếu không có dữ liệu
    }
  }


  Future<bool> checkDataExists(String tableName, String columnName, String value) async {
    final db = await database;
    var result = await db.query(tableName, where: '$columnName = ?', whereArgs: [value]);

    return result.isNotEmpty;
  }
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert(tableName, data);
  }
  Future<String?> getCaDangKiAdmin() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('yatoadmin');
    if (result.isNotEmpty) {
      return result[0]['ca_dangkiadmin'].toString();
    }
    return null;
  }

  Future<void> updateCaDangKiAdmin(String caDangKi) async {
    Database db = await database;
    await db.update(
      'yatoadmin',
      {'ca_dangkiadmin': caDangKi},
    );
  }


  Future<Map<String, dynamic>> fetchCaDangKiAdmin() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('yatoadmin');
    return result.isNotEmpty ? result.first : {};
  }

  Future<int> fetchCaDangKiAdminIndex() async {
    Map<String, dynamic> result = await fetchCaDangKiAdmin();
    String caDangKiAdmin = result['ca_dangkiadmin'] ?? '5h';

    if (caDangKiAdmin == '5h') {
      return 0;
    } else if (caDangKiAdmin == '8h') {
      return 1;
    } else if (caDangKiAdmin == '10h') {
      return 2;
    } else {
      // Handle other cases if needed
      return 0; // Giá trị mặc định nếu không khớp
    }
  }




  Future<Map<String, dynamic>> fetchDataForWeek(DateTime startDate, DateTime endDate) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      COALESCE(SUM(cd_sang), 0) as total_cd_sang,
      COALESCE(SUM(cd_toi), 0) as total_cd_toi,
      COALESCE(SUM(don_thuong), 0) as total_don_thuong,
      COALESCE(SUM(tong_chuyen), 0) as total_tong_chuyen,

COALESCE(CAST(SUM(tong_diem) AS DOUBLE), 0.0) AS total_tong_diem,


      

        COALESCE(AVG(CAST(REPLACE(thoigian_hd, '%', '') AS INTEGER)), 0) as total_thoigian_hd,
      
      
            COALESCE(SUM(CAST(REPLACE(doanh_thungay, '.', '') AS INTEGER)), 0) as total_doanh_thungay,

 
      COALESCE(AVG(CAST(REPLACE(tilenhanchuyen, '%', '') AS INTEGER)), 0) as average_tilenhanchuyen,
      COALESCE(AVG(CAST(REPLACE(tilehoanthanhchuyen, '%', '') AS INTEGER)), 0) as average_tilehoanthanhchuyen,
      COALESCE(AVG(CAST(REPLACE(tilehuychuyen, '%', '') AS INTEGER)), 0) as average_tilehuychuyen,
      COALESCE(yatoadmin.ca_dangkiadmin, '') as ca_dangkiadmin
    FROM yatosm
    LEFT JOIN yatoadmin ON 1=1  
    WHERE 
      DATE(ngay) >= DATE('${_formatDate(startDate)}')
      AND DATE(ngay) <= DATE('${_formatDate(endDate)}')
      AND tilenhanchuyen IS NOT NULL
      AND tilehoanthanhchuyen IS NOT NULL
      AND tilehuychuyen IS NOT NULL;
  ''');

    return result.isNotEmpty ? result.first : {};
  }


  Future<Map<String, dynamic>> fetchDataForWeek1(DateTime startDate, DateTime endDate) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      COALESCE(SUM(cd_sang), 0) as total_cd_sang,
      COALESCE(SUM(cd_toi), 0) as total_cd_toi,
      COALESCE(SUM(don_thuong), 0) as total_don_thuong,
      COALESCE(SUM(tong_chuyen), 0) as total_tong_chuyen,
      COALESCE(SUM(tong_diem), 0) as total_tong_diem,
      

        COALESCE(AVG(CAST(REPLACE(thoigian_hd, '%', '') AS INTEGER)), 0) as total_thoigian_hd,
      
            COALESCE(SUM(CAST(REPLACE(doanh_thungay, '.', '') AS INTEGER)), 0) as total_doanh_thungay,

        COALESCE(SUM(doanh_thungay), 0) as total_doanh_thungay,
 
      COALESCE(AVG(CAST(REPLACE(tilenhanchuyen, '%', '') AS INTEGER)), 0) as average_tilenhanchuyen,
      COALESCE(AVG(CAST(REPLACE(tilehoanthanhchuyen, '%', '') AS INTEGER)), 0) as average_tilehoanthanhchuyen,
      COALESCE(AVG(CAST(REPLACE(tilehuychuyen, '%', '') AS INTEGER)), 0) as average_tilehuychuyen,
      COALESCE(yatoadmin.ca_dangkiadmin, '') as ca_dangkiadmin
    FROM yatosm
    LEFT JOIN yatoadmin ON 1=1  
    WHERE 
      DATE(ngay) >= DATE('${_formatDate(startDate)}')
      AND DATE(ngay) <= DATE('${_formatDate(endDate)}')
      AND tilenhanchuyen IS NOT NULL
      AND tilehoanthanhchuyen IS NOT NULL
      AND tilehuychuyen IS NOT NULL;
  ''');

    return result.isNotEmpty ? result.first : {};
  }


  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }






}

