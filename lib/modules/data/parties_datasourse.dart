import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;

  static const String _dbName = 'restaurant.db';
  static const int _dbVersion = 1;

  static const String tableParties = 'parties';
  static const String colName = 'name';
  static const String colSize = 'size';
  static const String colTicketId = 'ticketId';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableParties (
        $colTicketId TEXT PRIMARY KEY,
        $colName TEXT NOT NULL,
        $colSize INTEGER NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}