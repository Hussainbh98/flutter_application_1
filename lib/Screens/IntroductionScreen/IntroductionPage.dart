import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionScreenPage extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Fractional shares",
        body:
            "Instead of having to buy an entire share, invest any amount you want.",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      done: Text('Done'),
      onDone: () {},
      onSkip: () {},
      pages: getPages(),
    );
  }
}
