import 'dart:async';

import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/model/actors_model.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class FireStoreService {
  final CollectionReference _actorsRef =
      FirebaseFirestore.instance.collection('actors_New');

  final _authService = locator<FirebaseAuthenticationService>();

  final StreamController<List<Actor>> _actorStreamController =
      StreamController<List<Actor>>.broadcast();

  //Creating actors recored in side the actors ref, this
  Future<void> createActorRecord(Map data) async {
    await _actorsRef.add(data);
  }

  //This stream is used to fetch actors as a stream. This stream is listened on the
  //On the actors screen
  Stream<List<Actor>> fetchActors() {
    _actorsRef
        .where('castedBy', isEqualTo: 'none')
        .snapshots()
        .listen((event) {
          logger.d('message');
      List<Actor> actors = List.from(event.docs.map((value) {
        return Actor.fromMap(value.data() as Map, value.id);
      }));
      actors.sort((a, b)=> a.cost.compareTo(b.cost));
      _actorStreamController.add(actors.reversed.toList());
    });

    return _actorStreamController.stream;
  }

  //This method is used to cast actors(Add them to roaster) of the logged in user.
  Future<void> castActor(Actor selectedActor) async {
    Actor updated = Actor(
        name: selectedActor.name,
        description: selectedActor.description,
        cost: selectedActor.cost,
        castedBy: _authService.firebaseAuth.currentUser!.uid);
    await _actorsRef.doc(selectedActor.id).update(updated.toMap());
  }

  //Used to fetch casted actors.
  Future<List<Actor>?> fetchCastedActors() async {
    QuerySnapshot snapshot = await _actorsRef
        .where('castedBy',
            isEqualTo: _authService.firebaseAuth.currentUser!.uid)
        .get();
    if (snapshot.size != 0) {
      List<Actor> actors = List.from(snapshot.docs.map((actorsDoc) {
        return Actor.fromMap(actorsDoc.data() as Map, actorsDoc.id);
      }));
      actors.sort((a, b)=> a.cost.compareTo(b.cost));
      return actors.reversed.toList();
    } else {
      return null;
    }
  }

  Future<void> removeCastedActors(Actor castedActor) async {
    Actor updated = Actor(
        name: castedActor.name,
        description: castedActor.description,
        cost: castedActor.cost,
        castedBy: "none");
    await _actorsRef.doc(castedActor.id).update(updated.toMap());

  }
}
