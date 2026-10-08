import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_provider.dart';

final partyViewModelProvider =
    AsyncNotifierProvider<PartyViewModel, List<PartyEntity>>(
  PartyViewModel.new,
);
class PartyViewModel extends AsyncNotifier<List<PartyEntity>> {
  // Initial state: loads the parties when the provider is first read
  @override
  Future<List<PartyEntity>> build() {
    return ref.watch(getPartiesProvider)();
  }

  // Add
  Future<void> addParty(PartyEntity party) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(addPartyProvider)(party);
      return ref.read(getPartiesProvider)();
    });
  }

  // Remove
  Future<void> removeParty(String ticketId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(removePartyProvider)(ticketId);
      return ref.read(getPartiesProvider)();
    });
  }

  // Update
  Future<void> updateParty(PartyEntity party) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(updatePartyProvider)(party);
      return ref.read(getPartiesProvider)();
    });
  }

  // Refresh
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(getPartiesProvider)());
  }

  // Get one party 
  Future<PartyEntity?> getParty(String ticketId) {
    return ref.read(getPartyProvider)(ticketId);
  }
}

