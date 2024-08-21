
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../modal/itinerary_model.dart';
import '../../../utils/helpers.dart';
import '../widgets/day_stepper.dart';

class LargeDetailedItinerary extends StatelessWidget {
  const LargeDetailedItinerary({
    super.key,
    required this.itinerary,
  });

  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SmallSliverAppBar(itinerary: itinerary),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                buildDayPlanSteppers(itinerary),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallSliverAppBar extends StatelessWidget {
  const SmallSliverAppBar({required this.itinerary, super.key});

  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: true,
      ),
      collapsedHeight: kToolbarHeight,
      backgroundColor: Colors.transparent,
      expandedHeight: 240,
      pinned: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 2.25,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itinerary.itineraryName,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                '${Helpers().prettyDate(itinerary.startDate.toString())} - ${Helpers().prettyDate(itinerary.endDate.toString())}',
                style: TextStyle(
                  fontSize: 8,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                itinerary.itineraryImageUrl,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 240,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [Color.fromARGB(165, 0, 0, 0), Colors.transparent],
                    stops: [0, 1]),
              ),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.home_outlined,
              ),
            )),
      ],
    );
  }
}

List<Widget> buildDayPlanSteppers(ItineraryModel itinerary) {
  return List.generate(
    itinerary.itinerary.length,
    (day) {
      var dayPlan = itinerary.itinerary[day];

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DayTitle(title: 'Day ${dayPlan.day.toString()}'),
        DayStepper(key: Key('stepper$day'), activities: dayPlan.planForDay)
      ]);
    },
  );
}
