import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modal/itinerary_model.dart';

class FirebaseFunctionsRepo {
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;
  Future<List<ItineraryModel>> generateItineraryFlow(
      {required String request, String? imageUrl}) async {
    return Future.error('Not implemented');
    // try {
    //   final resonse = await _firebaseFunctions
    //       .httpsCallable(itineraryFlowFunctionName)
    //       .call({'request': request, 'imageUrl': imageUrl});
    //   final List<ItineraryModel> list =
    //       ItineraryModel.fromJsonList(resonse.data);
    //   return list;
    // } on FirebaseFunctionsException catch (e) {
    //   log(e.toString());
    //   return Future.error((e));
    // } catch (e) {
    //   log(e.toString());
    //   return Future.error((e));
    // }
  }
}

final firebaseFunctionRepoProvider = Provider((ref) => FirebaseFunctionsRepo());
