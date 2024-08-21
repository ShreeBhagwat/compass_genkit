
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/common_app_bar.dart';
import '../providers/itinerary_provider.dart';
import '../widgets/itinerary_card.dart';
import '../widgets/no_itineraries_widget.dart';

class AiItineraryScreen extends ConsumerStatefulWidget {
  const AiItineraryScreen({super.key});

  @override
  ConsumerState<AiItineraryScreen> createState() => _AiItineraryScreenState();
}

class _AiItineraryScreenState extends ConsumerState<AiItineraryScreen> {
  @override
  Widget build(BuildContext context) {

    final itineraryNotifier = ref.read(itineraryProvider);
    return Scaffold(
      appBar: const CommonAppBar(
        showHomeButton: false,
      ),
      body: itineraryNotifier.itineraries.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final itinerary = itineraryNotifier.itineraries[index];
                return SizedBox(
                  child: ItineraryCard(itinerary: itinerary),
                );
              },
              itemCount: itineraryNotifier.itineraries.length,
            )
          : const NoItinerariesMessage(),
    );
  }
}
