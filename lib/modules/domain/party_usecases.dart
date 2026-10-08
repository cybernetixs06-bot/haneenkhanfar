
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