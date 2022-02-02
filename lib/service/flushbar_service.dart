import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/ui/shared/base_colors.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class FlushBarService {
  late Flushbar _loadingFlushBar = Flushbar();

  final buildContext =
      locator<NavigationService>().navigatorKey!.currentState!.context;

  void dismissFlushBar() {
    _loadingFlushBar.dismiss();
  }

  void showFlushBar() {
    _loadingFlushBar = Flushbar(
      title: "Loading",
      message: "Please wait until process completes.",
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: BaseColors.buttonColor,
    )..show(buildContext);
  }

  void showSuccessFlushBar() {
    FlushbarHelper.createSuccess(
            message: "Process has completed Successfully", title: "Done")
        .show(buildContext);
  }
}
