import 'package:flutter/material.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';

class Party extends PartyEntity {
  final String name;
  final int size;
  final String ticketId;

 Party({
     required this.name,
    required this.size,
    required this.ticketId, 
  }) : super(name: '', size: 0, ticketId: '');

 factory Party.fromEntity(PartyEntity party) {
    return Party(
      name: party.name,
      size: party.size,
      ticketId: party.ticketId,
    );
  }
  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      name: json['name'] as String,
      size: json['size'] as int,
      ticketId: json['ticketId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size,
      'ticketId': ticketId,
    };
  }

}