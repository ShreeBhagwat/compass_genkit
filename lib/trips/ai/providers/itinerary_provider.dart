import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modal/flowItinaray.dart';
import '../../../modal/itinerary_model.dart';
import '../repo/firebase_functions_repo.dart';

class ItineraryController {
  final bool isLoading;
  final List<ItineraryModel> itineraries;
  final String error;
  final bool isError;

  ItineraryController({
    required this.isLoading,
    required this.itineraries,
    required this.error,
    required this.isError,
  });

  ItineraryController copyWith({
    bool? isLoading,
    List<ItineraryModel>? itineraries,
    String? error,
    bool? isError,
  }) {
    return ItineraryController(
      isLoading: isLoading ?? this.isLoading,
      itineraries: itineraries ?? this.itineraries,
      error: error ?? this.error,
      isError: isError ?? this.isError,
    );
  }
}

class ItineraryProvider extends StateNotifier<ItineraryController> {
  final Ref ref;
  ItineraryProvider(this.ref)
      : super(ItineraryController(
            isLoading: false, itineraries: [], error: '', isError: false));

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setItineraries(List<ItineraryModel> itineraries) {
    state = state.copyWith(itineraries: itineraries);
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  void setIsError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  Future getItineraries({required String request}) async {
    setLoading(true);
    try {
      final resonse = await ref
          .read(firebaseFunctionRepoProvider)
          .generateItineraryFlow(request: request);

      state = state.copyWith(itineraries: resonse);
    } catch (e) {
      log(e.toString());
      await getFallbackItineraries();
    } finally {
      setLoading(false);
    }
  }

  Future getFallbackItineraries() async {
    List<ItineraryModel> itineraries = [];
    demoFallbackData
        .map((e) => itineraries.add(ItineraryModel.fromJson(e)))
        .toList();
    state = state.copyWith(itineraries: itineraries);
  }
}

final itineraryProvider =
    StateNotifierProvider<ItineraryProvider, ItineraryController>((ref) {
  return ItineraryProvider(ref);
});
