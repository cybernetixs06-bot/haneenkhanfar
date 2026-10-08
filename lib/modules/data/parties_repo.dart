import 'package:restorenttask_haneenkhanfar/modules/data/parties_datasourse.dart';
import 'package:restorenttask_haneenkhanfar/modules/data/party_model.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_repo_abstract.dart';
import 'package:sqflite/sqflite.dart';


class PartyRepositoryimpl implements PartyRepository{
  PartyRepositoryimpl({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  final DatabaseHelper _dbHelper;

  static const _table = DatabaseHelper.tableParties;
  static const _ticketId = DatabaseHelper.colTicketId;

  Future<void> addParty(PartyEntity party) async {
    final db = await _dbHelper.database;
    party.ticketId= await generateTicketId();
    final model= Party.fromEntity(party); 

    await db.insert(
      _table,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Party>> getParties() async {
    final db = await _dbHelper.database;
    final maps = await db.query(_table);
    return maps.map(Party.fromJson).toList();
  }

  Future<Party?> getParty(String ticketId) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      _table,
      where: '$_ticketId = ?',
      whereArgs: [ticketId],
      limit: 1,
    );
    return maps.isEmpty ? null : Party.fromJson(maps.first);
  }

  Future<bool> updateParty(PartyEntity party) async {
    final db = await _dbHelper.database;
    final model = Party.fromEntity(party);
    final count = await db.update(
      _table,
      model.toJson(),
      where: '$_ticketId = ?',
      whereArgs: [party.ticketId],
    );
    return count > 0;
  }

  Future<bool> removeParty(String ticketId) async {
    final db = await _dbHelper.database;
    final count = await db.delete(
      _table,
      where: '$_ticketId = ?',
      whereArgs: [ticketId],
    );
    return count > 0;
  }

  Future<void> clearAll() async {
    final db = await _dbHelper.database;
    await db.delete(_table);
  }
  @override
Future<int> getPartiesCount() async {
  final db = await _dbHelper.database;
  final rows = await db.query(_table);

  int count = 0;
  for (final row in rows) {
    count++;
  }
  return count;
}

@override
Future<String> generateTicketId() async {
  final db = await _dbHelper.database;
  final rows = await db.query(_table, columns: [_ticketId]);

  int highest = 0;
  for (final row in rows) {
    final ticket = row[_ticketId] as String; // e.g. "T-3"
    final number = int.tryParse(ticket.replaceAll('T-', '')) ?? 0;
    if (number > highest) highest = number;
  }
  return 'T-${highest + 1}';
}
}