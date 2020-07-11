import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './faq_view_model.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaqViewModel>.reactive(
      viewModelBuilder: () => FaqViewModel(),
      builder: (
        BuildContext context,
        FaqViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'FaqView',
            ),
          ),
        );
      },
    );
  }
}
