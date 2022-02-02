import 'package:cast_actors/service/firestore_service.dart';
import 'package:cast_actors/service/flushbar_service.dart';
import 'package:cast_actors/ui/actors/actors_view.dart';
import 'package:cast_actors/ui/login/login_view.dart';
import 'package:cast_actors/ui/new_actors/new_actors_view.dart';
import 'package:cast_actors/ui/roaster/roaster_view.dart';
import 'package:cast_actors/ui/startup/startup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

@StackedApp(
  routes: [
    //This is our root layout where the user is redirected from loginView/actorsView
    CupertinoRoute(page: StartupView, initial: true),
    CupertinoRoute(
      page: ActorsView,
    ),
    CupertinoRoute(
      page: LoginView,
    ),
    CupertinoRoute(
      page: NewActorsView,
    ),
    CupertinoRoute(
      page: RoasterView,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: FireStoreService),
    LazySingleton(classType: FlushBarService),
  ],
)
class AppSetup {}
