
class Activities {
  final num duration;
  final String ref;
  final String locationName;
  final int price;
  final String imageUrl;
  final String destination;
  final String name;
  final String description;
  final bool familyFriendly;
  final String timeOfDay;


  Activities({
    required this.duration,
    required this.ref,
    required this.locationName,
    required this.price,
    required this.imageUrl,
    required this.destination,
    required this.name,
    required this.description,
    required this.familyFriendly,
    required this.timeOfDay,
  });

  factory Activities.fromJson(Map<String, dynamic> json) {
    return Activities(
      duration: json['duration'],
      ref: json['ref'],
      locationName: json['locationName'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      destination: json['destination'],
      name: json['name'],
      description: json['description'],
      familyFriendly: json['familyFriendly'],
      timeOfDay: json['timeOfDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'ref': ref,
      'locationName': locationName,
      'price': price,
      'imageUrl': imageUrl,
      'destination': destination,
      'name': name,
      'description': description,
      'familyFriendly': familyFriendly,
      'timeOfDay': timeOfDay,
    };
  }
}
