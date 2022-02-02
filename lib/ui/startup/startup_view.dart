import 'package:cast_actors/ui/shared/spinner.dart';
import 'package:cast_actors/ui/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.startUp(),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy ? loadingSpinnerWidget : model.child,
      ),
    );
  }

}
