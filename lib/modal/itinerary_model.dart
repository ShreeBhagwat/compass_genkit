class ItineraryModel {
  final String itineraryName;
  final String place;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> tags;
  final String itineraryImageUrl;
  final String placeRef;
  final List<DayPlan> itinerary;

  ItineraryModel({
    required this.itineraryName,
    required this.place,
    required this.startDate,
    required this.endDate,
    required this.tags,
    required this.itineraryImageUrl,
    required this.placeRef,
    required this.itinerary,
  });

  factory ItineraryModel.fromJson(Map<Object?, Object?> json1) {
    final json = convertMap(json1);
    return ItineraryModel(
      itineraryName: json['itineraryName'],
      place: json['place'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      tags: List<String>.from(json['tags']),
      itineraryImageUrl: json['itineraryImageUrl'],
      placeRef: json['placeRef'],
      itinerary:
          (json['itinerary'] as List).map((e) => DayPlan.fromJson(e)).toList(),
    );
  }

  static List<ItineraryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ItineraryModel.fromJson(json)).toList();
  }
}

class DayPlan {
  final DateTime date;
  final int day;
  final List<ActivityPlan> planForDay;

  DayPlan({
    required this.date,
    required this.day,
    required this.planForDay,
  });

  factory DayPlan.fromJson(Map<Object?, Object?> json1) {
    final json = convertMap(json1);
    return DayPlan(
      date: DateTime.parse(json['date']),
      day: json['day'],
      planForDay: (json['planForDay'] as List)
          .map((e) => ActivityPlan.fromJson(e))
          .toList(),
    );
  }
}

class ActivityPlan {
  final String activityTitle;
  final String activityDesc;
  final String activityRef;
  final String imageUrl;


  ActivityPlan({
    required this.activityTitle,
    required this.activityDesc,
    required this.activityRef,
    this.imageUrl = '',
  });

  factory ActivityPlan.fromJson(Map<Object?, Object?> json1) {
    final json = convertMap(json1);
    return ActivityPlan(
      activityTitle: json['activityTitle'],
      activityDesc: json['activityDesc'],
      activityRef: json['activityRef'],
      imageUrl: json['imgUrl'] ?? '',
    );
  }
}

Map<String, dynamic> convertMap(Map<Object?, Object?> source) {
  return source.map((key, value) {
    if (key is String) {
      return MapEntry(key, value);
    } else {
      throw Exception("Invalid key type: ${key.runtimeType}");
    }
  });
}
