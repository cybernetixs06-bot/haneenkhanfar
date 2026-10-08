import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_cart_widget.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_viewmode;.dart';

// Adjust this path to where your viewmodel file is

class PartiesScreen extends ConsumerWidget {
  const PartiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partiesAsync = ref.watch(partyViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Parties')),
      body: partiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Something went wrong\n$error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(partyViewModelProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (parties) {
          if (parties.isEmpty) {
            return const Center(child: Text('No parties yet'));
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(partyViewModelProvider.notifier).refresh(),
            child: SingleChildScrollView(
              // Needed so pull-to-refresh works even with few items
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (final party in parties) PartyCard(party: party),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

