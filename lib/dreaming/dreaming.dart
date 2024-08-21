import 'package:compass_genkit/common/widgets/common_app_bar.dart';
import 'package:compass_genkit/extensions/build_context_extension.dart';
import 'package:compass_genkit/trips/ai/providers/itinerary_provider.dart';
import 'package:compass_genkit/trips/ai/screens/ai_itinerary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/dreaming_title.dart';
import 'widgets/rotating_photos.dart';

class DreamingScreen extends ConsumerStatefulWidget {
  const DreamingScreen({super.key, required this.queryText});
  final String queryText;

  @override
  ConsumerState<DreamingScreen> createState() => _DreamingScreenState();
}

class _DreamingScreenState extends ConsumerState<DreamingScreen> {
  @override
  void initState() {
    super.initState();
      Future.microtask(() async{
      await showItinerary();
    });
  }



  Future showItinerary() async {
    await ref
        .read(itineraryProvider.notifier)
        .getItineraries(request: widget.queryText);
    if (mounted) {
      if (ref.read(itineraryProvider).isError) {
        showError(ref.read(itineraryProvider).error, () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      } else {
        context.navigateToScreen(const AiItineraryScreen());
      }
    }
  }

  void showError(String errorMessage, VoidCallback onDismissed) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          errorMessage,
        ),
        content: const Text('Please try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: onDismissed,
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff352F34),
      appBar: const CommonAppBar(
        isTransparent: true,
      ),
      body: Stack(children: [
        ...buildRotatingPhotos(context),
        const DreamingTitleWidget(),
      ]),
    );
  }
}
