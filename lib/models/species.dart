class Species {
  final String name;
  final String latin_name;
  final String type;
  final String image_url;
  final String description;

  Species({required this.name, required this.latin_name,
    required this.type, required this.image_url, required this.description});

  factory Species.fromMap(Map<String, dynamic> data) {
    return Species(
        name: data['name'],
        latin_name: data['latin_name'],
        type: data['type'],
        image_url: data['image_url'],
        description: data['description']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latin_name': latin_name,
      'type': type,
      'image_url': image_url,
      'description': description,
    };
  }
}