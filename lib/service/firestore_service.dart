import 'dart:async';

import 'package:cast_actors/app/app.locator.dart';
import 'package:cast_actors/model/actors_model.dart';
import 'package:cast_actors/util/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class FireStoreService {
  final CollectionReference _actorsRef =
      FirebaseFirestore.instance.collection('actors');
  final CollectionReference _castedUserRef =
      FirebaseFirestore.instance.collection('casted');

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
    _actorsRef.orderBy('cost', descending: true).snapshots().listen((event) {
      List<Actor> actors = List.from(event.docs.map((value) {
        return Actor.fromMap(value.data() as Map, value.id);
      }));
      _actorStreamController.add(actors);
    });

    return _actorStreamController.stream;
  }

  //This method is used to cast actors(Add them to roaster) of the logged in user.
  Future<void> castActor(Actor selectedActor) async {
    await _castedUserRef
        .doc(_authService.firebaseAuth.currentUser!.uid)
        .collection('castedActors')
        .add(selectedActor.toMap());

    await _actorsRef.doc(selectedActor.id).delete();
  }

  //Used to fetch casted actors.
  Future<List<Actor>?> fetchCastedActors() async {
    QuerySnapshot snapshot = await _castedUserRef
        .doc(_authService.firebaseAuth.currentUser!.uid)
        .collection('castedActors')
        .orderBy('cost', descending: true)
        .get();
    if (snapshot.size != 0) {
      List<Actor> actors = List.from(snapshot.docs.map((actorsDoc) {
        return Actor.fromMap(actorsDoc.data() as Map, actorsDoc.id);
      }));
      return actors;
    } else {
      return null;
    }
  }

  Future<void> removeCastedActors(Actor castedActor) async {
    await createActorRecord(castedActor.toMap());
    await _castedUserRef
        .doc(_authService.firebaseAuth.currentUser!.uid)
        .collection('castedActors')
        .doc(castedActor.id)
        .delete();
  }
}
