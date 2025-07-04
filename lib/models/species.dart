import 'package:cloud_firestore/cloud_firestore.dart';

class Species {
  final String? id;
  final String name;
  final String latin_name;
  final String type;
  final String? klass;
  final String? image_url;
  final List<int>? stations;
  final String description;

  Species({this.id, this.klass, required this.name, required this.latin_name,
    required this.type, this.stations, required this.image_url, required this.description});

  factory Species.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Species(
        id: doc.id,
        klass: data['class'] ?? "unknown",
        stations: (data['stations'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
        name: data['name'],
        latin_name: data['latin_name'],
        type: data['type'],
        image_url: data['image_url'],
        description: data['description']
    );
  }

  factory Species.fromMap(Map<String, dynamic> data) {
    return Species(
        id: data['id'],
        klass: data['class'] ?? "unknown",
        stations: (data['stations'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
        name: data['name'],
        latin_name: data['latin_name'],
        type: data['type'],
        image_url: data['image_url'],
        description: data['description']
    );
  }

  factory Species.fromCalculationResultMap(Map<String, dynamic> result) {
    return Species(
        klass: result['class'],
        stations: [],
        name: result['name'],
        latin_name: result['latin_name'],
        type: result['type'],
        image_url: result['image_url'],
        description: ''
    );
  }

  Species copyWith({
    String? latinName,
    List<int>? stations,
    String? description,
    String? name,
    String? klass,
    String? type,
    String? imageUrl,
  }) {
    return Species(
      name: name ?? this.name,
      type: type ?? this.type,
      image_url: imageUrl ?? image_url,
      latin_name: latinName ?? latin_name,
      stations: stations ?? this.stations,
      description: description ?? this.description,
      klass: klass ?? this.klass
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latin_name': latin_name,
      'image_url': image_url,
      'name': name,
      'description': description,
      'type': type,
    };
  }
}