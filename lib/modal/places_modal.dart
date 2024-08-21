class PlacesModal {
  final String ref;
  final String name;
  final String country;
  final String continent;
  final String knownFor;
  final List<String> tags;
  final String imageUrl;

  PlacesModal({
    required this.ref,
    required this.name,
    required this.country,
    required this.continent,
    required this.knownFor,
    required this.tags,
    required this.imageUrl,
  });

  factory PlacesModal.fromJson(Map<String, dynamic> json) {
    return PlacesModal(
      ref: json['ref'],
      name: json['name'],
      country: json['country'],
      continent: json['continent'],
      knownFor: json['knownFor'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ref': ref,
      'name': name,
      'country': country,
      'continent': continent,
      'knownFor': knownFor,
      'tags': tags,
      'imageUrl': imageUrl,
    };
  }
}
