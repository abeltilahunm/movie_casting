import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/app/app.router.dart';
import 'package:cast_actors/model/actors_model.dart';
import 'package:cast_actors/service/firestore_service.dart';
import 'package:cast_actors/ui/shared/widgets/actors_tile.dart';
import 'package:cast_actors/ui/shared/widgets/casted_actors_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class RoasterViewModel extends FutureViewModel<List<Actor>?> {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  GlobalKey<PopupMenuButtonState<int>> get key => _key;
  final _authService = locator<FirebaseAuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<FireStoreService>();
  final formatCurrency = NumberFormat.simpleCurrency();

  int _totalCost = 0;

  void onSelected(int val) {
    if (val == 0) {
      _navigationService.popRepeated(1);
    } else {
      _authService.logout();
    }
  }

  int get actorsLength {
    return data!.length;
  }

  bool get isNull {
    return data == null ? true : false;
  }

  bool get isEmpty {
    return data!.isEmpty;
  }

  int get totalCost {
    return _totalCost;
  }

  String get formattedCost {
    return formatCurrency.format(totalCost);
  }

  Widget getCastedUser(int index) {
    return CastedActors(
        actor: data![index],
        unCastAction: () {
          unCastActor(index);
        });
  }

  void unCastActor(int index) {
    setBusy(true);
    _databaseService.removeCastedActors(data![index]);
    data!.removeAt(index);
    setBusy(false);
    calculateTotalCoast();
    notifyListeners();
  }

  void calculateTotalCoast() {
    //I made this to zero becoase i recalculate
    //the total coast again. So when i do, the totalCoast is already set.
    //So i need it to be cleared.
    _totalCost = 0;

    data!.forEach((element) {
      _totalCost += element.cost;
    });
  }

  @override
  void onData(List<Actor>? data) {
    // TODO: implement onData
    super.onData(data);
    calculateTotalCoast();
  }

  @override
  Future<List<Actor>?> futureToRun() {
    // TODO: implement futureToRun
    return _databaseService.fetchCastedActors();
  }
}
