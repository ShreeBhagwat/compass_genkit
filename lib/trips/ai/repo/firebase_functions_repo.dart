import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:compass_genkit/trips/ai/providers/image_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modal/itinerary_model.dart';
import '../../../utils/constants.dart';

class FirebaseFunctionsRepo {
  Ref ref;

  FirebaseFunctionsRepo({required this.ref});
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  Future<List<ItineraryModel>> generateItineraryFlow(
      {required String request}) async {
    try {
      final imageUrls = await uploadToImageToFirestore();
      final resonse = await _firebaseFunctions
          .httpsCallable(itineraryFlowFunctionName)
          .call({'request': request, 'imageUrl': imageUrls});
      final List<ItineraryModel> list =
          ItineraryModel.fromJsonList(resonse.data);
      return list;
    } on FirebaseFunctionsException catch (e) {
      log(e.toString());
      return Future.error((e));
    } catch (e) {
      log(e.toString());
      return Future.error((e));
    }
  }

  Future<List<String>> uploadToImageToFirestore() async {
    final imagesList = ref.read(imageUploadProvider);
    List<String> imageUrls = [];
    if (imagesList.isEmpty) {
      return [];
    }

    for (var image in imagesList) {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('images/${DateTime.now()}.png');
      await ref.putData(image.bytes);
      final url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    log('Image URLs: $imageUrls');
    return imageUrls;
  }
}

final firebaseFunctionRepoProvider =
    Provider((ref) => FirebaseFunctionsRepo(ref: ref));
