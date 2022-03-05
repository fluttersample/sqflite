
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/phone_book_model.dart';

String tableName= 'phoneBook';
class PhoneBookDateBase{

  static final PhoneBookDateBase instance =PhoneBookDateBase._init();
  PhoneBookDateBase._init();

  static Database? _database;



  Future<Database> get dataBase async{
    if(_database !=null) return _database!;

    _database = await _initDb('phonebook.db');
    return _database!;
  }
  Future<Database> _initDb(String filePath)async {

    final dbPath  = await getDatabasesPath();
    print(dbPath);

      final path = join(dbPath,filePath);
      return await openDatabase(path,version: 1,onCreate: _createDb);
  }

 Future _createDb(Database db , int version)async {
   //  const boolType = 'BOOLEAN NOT NULL';

    const idType = 'INTEGER PRIMARY KEY';
    const integerType = 'INTEGER';
    const textType = 'TEXT';
    await db.execute(
      '''
      CREATE TABLE $tableName (
      ${PhoneBookFields.id} $idType,
      ${PhoneBookFields.name} $textType,
      ${PhoneBookFields.number} $integerType
      )
      '''
    );
 }
 Future close() async{
    final db = await instance.dataBase;
    db.close();
 }

 Future<PhoneBookModel> create(PhoneBookModel model)async{
    final db = await instance.dataBase;
    final id =await db.insert(tableName, model.toJson());
    return model.copyWith(id: id);

 }
 Future<PhoneBookModel?> readPhoneBook(int id) async {
    final db = await instance.dataBase;


    final map = await db.query(
      tableName,
      columns: PhoneBookFields.values,
      where: '${PhoneBookFields.id} = ?',
      whereArgs: [id]
    );
    if(map.isNotEmpty)
      {
        PhoneBookModel.fromJson(map.first);
      }else {
      throw Exception('ID $id Not Found');
    }
    return null;
 }


 Future<List<PhoneBookModel>> readAllPhoneBook()async {
    final db = await instance.dataBase;
    final result = await db.query(tableName);
    return result.map((e) => PhoneBookModel.fromJson(e)).toList();
 }

 Future<int> update ( PhoneBookModel model) async{
   final db = await instance.dataBase;


   return await db.update(
       tableName,
       model.toJson(),
       where: '${PhoneBookFields.id} = ?',
       whereArgs: [model.id]
   );

 }

 Future<int> delete ( int id) async{
   final db = await instance.dataBase;


   return await db.delete(
       tableName,
       where: '${PhoneBookFields.id} = ?',
       whereArgs: [id]
   );

 }

}