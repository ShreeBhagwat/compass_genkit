import 'package:compass_genkit/utils/image_handling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageUploadProvider extends StateNotifier<List<UserSelectedImage>> {
  ImageUploadProvider() : super([]);

  void addImages(List<UserSelectedImage> images) {
    state = images;
  }

  void removeImage(UserSelectedImage image) {
    state = state.where((element) => element != image).toList();
  }
}

final imageUploadProvider =
    StateNotifierProvider<ImageUploadProvider, List<UserSelectedImage>>(
        (ref) => ImageUploadProvider());
