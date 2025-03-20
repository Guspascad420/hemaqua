class Species {
  final String name;
  final String latin_name;
  final String type;
  final String? klass;
  final String image_url;
  final List<int>? stations;
  final String description;

  Species({this.klass, required this.name, required this.latin_name,
    required this.type, this.stations, required this.image_url, required this.description});

  factory Species.fromMap(Map<String, dynamic> data) {
    return Species(
        klass: data['class'] ?? "unknown",
        stations: (data['weight'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
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

  Map<String, dynamic> toMap() {
    return {
      'latin_name': latin_name,
      'image_url': image_url,
      'name': name,
      'description': description,
      'type': type,
    };
  }
}