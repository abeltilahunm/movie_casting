import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/app/app.router.dart';
import 'package:cast_actors/enum/dialoge_type.dart';
import 'package:cast_actors/model/actors_model.dart';
import 'package:cast_actors/service/firestore_service.dart';
import 'package:cast_actors/service/flushbar_service.dart';
import 'package:cast_actors/ui/shared/widgets/actors_tile.dart';
import 'package:cast_actors/util/format_currency.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class ActorsViewModel extends StreamViewModel<List<Actor>> {
  final _authService = locator<FirebaseAuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _fireStoreService = locator<FireStoreService>();
  final _flushbarService = locator<FlushBarService>();

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  GlobalKey<PopupMenuButtonState<int>> get key => _key;

  @override
  // TODO: implement stream
  Stream<List<Actor>> get stream => _fireStoreService.fetchActors();

  bool get isNull {
    return data == null ? true : false;
  }

  bool get isEmpty {
    return data!.isEmpty;
  }

  int get dataCount {
    return data!.length;
  }


  void onSelected(int val) {
    if (val == 0) {
      _navigationService.navigateTo(Routes.roasterView);
    } else {
      _authService.logout();
    }
  }

  void navigateToNewActor() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: "New Actor/Actress",
      barrierDismissible: true,
      mainButtonTitle: "Submit",
    );

    if (response != null) {
      Actor actor = Actor(
          cost: int.parse(response.data['cost']),
          description: response.data['description'],
          name: response.data['name']!);
      await _fireStoreService.createActorRecord(actor.toMap());
      logger.d(actor.toMap());
    }
  }

  Widget getActorsTile(int index) {
    return ActorsTile(
        actor: data![index],
        function: () async {
          _flushbarService.showFlushBar();
          await _fireStoreService.castActor(data![index]);
          _flushbarService.dismissFlushBar();
          _flushbarService.showSuccessFlushBar();
          // data!.removeAt(index);
        });
  }
}
