import 'package:flutter/material.dart';

class Contacts {
  int? id;
  String? name;
  String? address;

  Contacts({this.id, required this.name, required this.address});

  factory Contacts.fromJson(Map<String, dynamic> json) =>
      Contacts(id: json['id'], name: json['name'], address: json['address']);
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'address': address};
}
