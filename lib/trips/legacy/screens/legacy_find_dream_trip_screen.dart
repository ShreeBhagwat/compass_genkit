import 'package:compass_genkit/common/widgets/gradient_title.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/common_app_bar.dart';

class LegacyFindMyDreamTrip extends StatelessWidget {
  const LegacyFindMyDreamTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/stars.png'),
            const Center(
              child: GradientTitle(
                  'Use AI trip planner to plan your dream trip',
                  textAlign: TextAlign.center),
            ),
          ],
        ));
  }
}
