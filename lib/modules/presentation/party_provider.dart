import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restorenttask_haneenkhanfar/modules/data/parties_datasourse.dart';
import 'package:restorenttask_haneenkhanfar/modules/data/parties_repo.dart';

import 'package:restorenttask_haneenkhanfar/modules/domain/party_repo_abstract.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_usecases.dart';

// Adjust these paths/names to your actual files

// ---------- Services ----------

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper.instance;
});

// ---------- Repositories ----------
// Typed as the abstract class so everything above depends on the domain layer only.

final partyRepositoryProvider = Provider<PartyRepository>((ref) {
  return PartyRepositoryimpl(dbHelper: ref.watch(databaseHelperProvider));
});

// ---------- Use cases ----------

final addPartyProvider = Provider<AddParty>((ref) {
  return AddParty(ref.watch(partyRepositoryProvider));
});

final getPartiesProvider = Provider<GetParties>((ref) {
  return GetParties(ref.watch(partyRepositoryProvider));
});

final getPartyProvider = Provider<GetParty>((ref) {
  return GetParty(ref.watch(partyRepositoryProvider));
});

final updatePartyProvider = Provider<UpdateParty>((ref) {
  return UpdateParty(ref.watch(partyRepositoryProvider));
});

final removePartyProvider = Provider<RemoveParty>((ref) {
  return RemoveParty(ref.watch(partyRepositoryProvider));
});

final clearPartiesProvider = Provider<ClearParties>((ref) {
  return ClearParties(ref.watch(partyRepositoryProvider));
});