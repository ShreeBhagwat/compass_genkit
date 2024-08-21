
import 'package:compass_genkit/trips/ai/widgets/brand_chip.dart';
import 'package:flutter/material.dart';

import '../../../modal/itinerary_model.dart';
import '../../../utils/helpers.dart';
import '../screens/ai_detailed_itinerary_screen.dart';

class ItineraryCard extends StatelessWidget {
  const ItineraryCard({
    required this.itinerary,
    super.key,
  });

  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    var mqWidth = MediaQuery.sizeOf(context).width;
    var mqHeight = MediaQuery.sizeOf(context).height;
    var isLarge = mqWidth >= 1024;

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => LargeDetailedItinerary(itinerary: itinerary)));
        },
        child: Card(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isLarge ? mqWidth * .5 : 800,
              minWidth: 350,
              maxHeight: 900,
              minHeight: mqHeight,
            ),
            child: Container(
              width: mqWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(itinerary.itineraryImageUrl),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 650,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter,
                            colors: [
                              Color.fromARGB(150, 49, 49, 49),
                              Colors.transparent
                            ],
                            stops: [
                              0.0,
                              0.75
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itinerary.itineraryName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 8,
                        ),
                        Text(
                          '${Helpers().prettyDate(itinerary.startDate.toString())} - ${Helpers().prettyDate(itinerary.endDate.toString())}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 8,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: List.generate(
                              itinerary.tags.length <= 5
                                  ? itinerary.tags.length
                                  : 5, (index) {
                            return BrandChip(
                              title: itinerary.tags[index],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
