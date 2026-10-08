
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_repo_abstract.dart';

class AddParty {
  const AddParty(this._repository);

  final PartyRepository _repository;

  Future<void> call(PartyEntity party) => _repository.addParty(party);
}
//..

class GetParties {
  const GetParties(this._repository);

  final PartyRepository _repository;

  Future<List<PartyEntity>> call() => _repository.getParties();
}
class GetParty {
  const GetParty(this._repository);

  final PartyRepository _repository;

  Future<PartyEntity?> call(String ticketId) => _repository.getParty(ticketId);
}
class UpdateParty {
  const UpdateParty(this._repository);

  final PartyRepository _repository;

  Future<bool> call(PartyEntity party) => _repository.updateParty(party);
}
class RemoveParty {
  const RemoveParty(this._repository);

  final PartyRepository _repository;

  Future<bool> call(String ticketId) => _repository.removeParty(ticketId);
}
class ClearParties {
  const ClearParties(this._repository);

  final PartyRepository _repository;

  Future<void> call() => _repository.clearAll();
}