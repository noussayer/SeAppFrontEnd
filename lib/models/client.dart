import 'dart:convert';

class Client {
  final String name;
  final String telephone;
  final String adresse;
  final String codepostal;
  final String ville;
  final String cin;
  final String? id;
  Client({
    required this.name,
    required this.telephone,
    required this.adresse,
    required this.codepostal,
    required this.ville,
    required this.cin,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'telephone': telephone,
      'adresse': adresse,
      'codepostal': codepostal,
      'ville': ville,
      'cin': cin,
      'id': id,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      name: map['name'] ?? '',
      telephone: map['telephone'] ?? '',
      adresse: map['adresse'] ?? '',
      codepostal: map['codepostal'] ?? '',
      ville: map['ville'] ?? '',
      cin: map['cin'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));
}
