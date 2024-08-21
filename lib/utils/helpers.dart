import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../modal/activites_modal.dart';
import '../modal/places_modal.dart';

class Helpers {


  final DateFormat dateFormatter = DateFormat('MMMM dd, yyyy');
  final DateFormat shortenedDateFormatter = DateFormat('MMM dd, yyyy');
  final DateFormat datesWithSlash = DateFormat('MM/dd/yyyy');



  Future<List<Activities>> getActivitiesFromJson() async {
    final response = await rootBundle.loadString('assets/activities.json');
    final data = json.decode(response);

    final List<Activities> list = data
        .map<Activities>((e) => Activities.fromJson(e))
        .toList() as List<Activities>;

    return list;
  }

  Future<List<PlacesModal>> getPlacesFromJson() async {
    final response = await rootBundle.loadString('assets/places.json');
    final data = json.decode(response);
    final List<PlacesModal> list = data
        .map<PlacesModal>((e) => PlacesModal.fromJson(e))
        .toList() as List<PlacesModal>;

    return list;
  }

  

  String prettyDate(String dateStr) {
    return dateFormatter.format(DateTime.parse(dateStr));
  }

  String shortenedDate(String dateStr) {
    return shortenedDateFormatter.format(DateTime.parse(dateStr));
  }
}
