import 'package:flutter/material.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';

class PartyCard extends StatelessWidget {
  const PartyCard({super.key, required this.party});

  final PartyEntity party;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.groups)),
        title: Text(party.name),
        subtitle: Text('Size: ${party.size}'),
      ),
    );
  }
}