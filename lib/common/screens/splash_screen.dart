import 'package:compass_genkit/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

import '../../trips/ai/screens/ai_plan_my_trip_screen.dart';
import '../../trips/legacy/screens/legacy_find_dream_trip_screen.dart';
import '../../utils/constants.dart';
import '../widgets/common_button.dart';
import '../widgets/splash_cards.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SplashCards(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 52, minWidth: 320, maxWidth: 360),
              child: CommonButton(
                buttonText: 'Find my dream Trip',
                buttonColor: Colors.black,
                onPressed: () {
                  context.navigateToScreen(const LegacyFindMyDreamTrip());
                },
              ),
            ),
            const SizedBox.square(
              dimension: 16,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 52, minWidth: 320, maxWidth: 360),
              child: CommonButton(
                buttonText: 'Plan my dream trip',
                buttonColor: purpleColour,
                onPressed: () {
                  context.navigateToScreen(AiPlanMyTripScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
