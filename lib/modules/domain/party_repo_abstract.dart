
import 'package:restorenttask_haneenkhanfar/modules/data/party_model.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';

abstract class PartyRepository {
  Future<void> addParty(PartyEntity party);
  Future<List<PartyEntity>> getParties();
  Future<PartyEntity?> getParty(String ticketId);
  Future<bool> updateParty(PartyEntity party);
  Future<bool> removeParty(String ticketId);
  Future<void> clearAll();
}