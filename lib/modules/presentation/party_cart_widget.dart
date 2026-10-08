import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_viewmode;.dart';

class PartyCard extends ConsumerWidget {
  const PartyCard({super.key, required this.party});

  final PartyEntity party;

  int get _aheadTickets {
    final number = int.tryParse(party.ticketId.replaceAll('T-', '')) ?? 1;
    return number - 1;
  }

  Future<void> _openEditDialog(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(partyViewModelProvider.notifier);

    // Load the latest version of the party from the db
    final current = await viewModel.getParty(party.ticketId);
    if (current == null || !context.mounted) return;

    final nameController = TextEditingController(text: current.name);
    final sizeController = TextEditingController(text: current.size.toString());
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit ${current.ticketId}'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: sizeController,
                  decoration: const InputDecoration(labelText: 'Size'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final size = int.tryParse(value ?? '');
                    return (size == null || size <= 0)
                        ? 'Enter a size greater than 0'
                        : null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final updated = PartyEntity(
                    name: nameController.text.trim(),
                    size: int.parse(sizeController.text),
                    ticketId: current.ticketId,
                  );

                  viewModel.updateParty(updated);
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    sizeController.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.groups)),
        title: Text(party.name),
        subtitle: Text('Size: ${party.size}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ahead tickets: $_aheadTickets'),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => ref
                  .read(partyViewModelProvider.notifier)
                  .removeParty(party.ticketId),
            ),
          ],
        ),
        onTap: () => _openEditDialog(context, ref),
      ),
    );
  }
}