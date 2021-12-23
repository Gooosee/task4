import 'package:sqflite/sqflite.dart';
import 'package:task4/model/rent.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'STRING';
    final intType = 'INTEGER';
    final doubleType = 'DOUBLE';

    await db.execute('''
CREATE TABLE $tableRent (
 ${RentFields.id} $idType,
 ${RentFields.name} $stringType,
 ${RentFields.rate} $intType,
 ${RentFields.place} $stringType,
 ${RentFields.startDatetime} $stringType,
 ${RentFields.endDatetime} $stringType,
 ${RentFields.sum} $doubleType
 ) 
 CREATE TABLE $tableUser (
 
 )  
''');
  }

  Future<Rent> create(Rent rent, String table) async {
    final db = await instance.database;

    final id = await db.insert(table, rent.toJson());
    return rent.copy(id: id);
  }

  Future<Rent> readNote(int id) async {
    final db = await instance.database;
    
    final maps = await db.query(
      tableRent,
      columns: RentFields.values,
      where: '${RentFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Rent.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }
  }

  Future<List<Rent>> readAllNotes(String table) async {
    final db = await instance.database;
    final result = await db.query(table);
    return result.map((json) => Rent.fromJson(json)).toList();
  }

  Future<int> updateRent(Rent rent) async {
    final db = await instance.database;
    
    return db.update(
        tableRent,
        rent.toJson(),
        where: '${RentFields.id} = ?',
        whereArgs: [rent.id],
    );
  }

  Future<int> updateUser(User user) async {
    
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}