import 'package:compass_genkit/dreaming/dreaming.dart';
import 'package:compass_genkit/extensions/build_context_extension.dart';
import 'package:compass_genkit/trips/ai/providers/image_provider.dart';
import 'package:compass_genkit/trips/ai/screens/ai_itinerary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/common_app_bar.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/gradient_title.dart';
import '../../../utils/constants.dart';
import '../../../utils/image_handling.dart';
import '../providers/itinerary_provider.dart';
import '../widgets/image_selector.dart';

class AiPlanMyTripScreen extends ConsumerStatefulWidget {
  const AiPlanMyTripScreen({super.key});

  @override
  ConsumerState<AiPlanMyTripScreen> createState() => _AiPlanMyTripScreenState();
}

class _AiPlanMyTripScreenState extends ConsumerState<AiPlanMyTripScreen> {
  final TextEditingController _queryController = TextEditingController();

  List<UserSelectedImage>? selectedImages;

  @override
  Widget build(BuildContext context) {
    final iteneraryNotifier = ref.watch(itineraryProvider);
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                const GradientTitle(
                  'Dream Your Vacation',
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextField(
                      controller: _queryController,
                      keyboardType: TextInputType.multiline,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      maxLines: 8,
                      decoration: const InputDecoration(
                        hintText: 'Write anything',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox.square(
                  dimension: 4,
                ),
                ImageSelector(onSelect: onSelect),
                const Spacer(),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 52,
                    minWidth: double.infinity,
                  ),
                  child: CommonButton(
                    buttonText: 'Plan My Trip',
                    onPressed: () async {
                      if (_queryController.text.isNotEmpty) {
                        context.navigateToScreen(
                            DreamingScreen(queryText: _queryController.text));
                      } else {
                        return;
                      }
                    },
                    buttonColor: purpleColour,
                  ),
                ),
                const SizedBox.square(
                  dimension: 40,
                ),
              ],
            ),
            iteneraryNotifier.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void onSelect(List<UserSelectedImage> images) {
    setState(() {
      selectedImages = images;
    });
    ref.read(imageUploadProvider.notifier).addImages(images);
  }
}
