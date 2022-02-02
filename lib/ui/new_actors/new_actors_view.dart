import 'package:cast_actors/ui/new_actors/new_actors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewActorsView extends StatelessWidget {
  const NewActorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewActorsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(),
      ),
    );
  }
}
