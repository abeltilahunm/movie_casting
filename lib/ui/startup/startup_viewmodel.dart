import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/ui/actors/actors_view.dart';
import 'package:cast_actors/ui/login/login_view.dart';
import 'package:cast_actors/ui/roaster/roaster_view.dart';
import 'package:cast_actors/ui/shared/spinner.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends StreamViewModel<User?> {
  final _firebaseService = locator<FirebaseAuthenticationService>;

  //Initially displayed.
  Widget _child = loadingSpinnerWidget;

  @override
  // This stream helps us identify the state of the users auth.
  Stream<User?> get stream => _firebaseService().authStateChanges;

  Widget get child => _child;

  //Called on data
  startUp() async {
    setBusy(true);
    //This delayed is added because the flutter login package crushes.
    //Since first the loginview is created while authstate is listened.
    //When auth state has changed the package is calling state state.
    // Making it crush. In order to see the bug you can comment this out.
    await Future.delayed(const Duration(seconds: 1));
    if (data != null) {
      _child = const ActorsView();
    } else {
      _child = const LoginView();
    }
    setBusy(false);
    notifyListeners();
  }

  @override
  void onData(User? data) {
    startUp();
    super.onData(data);
  }
}
