import 'dart:convert';

class RepairMaterial {
  final String marque;
  final String serie;
  final String panne;
  final String traveaux;
  final String nomclient;
  final String telephone;
  final String reparateur;
  final String montant;
  final DateTime date;
  final List<String> documents;
  final String? id;
  RepairMaterial({
    required this.marque,
    required this.serie,
    required this.panne,
    required this.traveaux,
    required this.nomclient,
    required this.telephone,
    required this.reparateur,
    required this.montant,
    required this.date,
    required this.documents,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'marque': marque,
      'serie': serie,
      'panne': panne,
      'traveaux': traveaux,
      'nomclient': nomclient,
      'telephone': telephone,
      'reparateur': reparateur,
      'montant': montant,
      'date': date.millisecondsSinceEpoch,
      'documents': documents,
      'id': id,
    };
  }

  factory RepairMaterial.fromMap(Map<String, dynamic> map) {
    return RepairMaterial(
      marque: map['marque'] ?? '',
      serie: map['serie'] ?? '',
      panne: map['panne'] ?? '',
      traveaux: map['traveaux'] ?? '',
      nomclient: map['nomclient'] ?? '',
      telephone: map['telephone'] ?? '',
      reparateur: map['reparateur'] ?? '',
      montant: map['montant'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      documents: List<String>.from(map['documents']),
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairMaterial.fromJson(String source) => RepairMaterial.fromMap(json.decode(source));
}
