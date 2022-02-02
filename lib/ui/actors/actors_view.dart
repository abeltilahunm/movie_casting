import 'package:cast_actors/ui/actors/actors_viewmodel.dart';
import 'package:cast_actors/ui/shared/base_appbar.dart';
import 'package:cast_actors/ui/shared/base_colors.dart';
import 'package:cast_actors/ui/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_helper/ui_helper.dart';

class ActorsView extends StatelessWidget {
  const ActorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActorsViewModel>.reactive(
      viewModelBuilder: () => ActorsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: BaseColors.white,
        appBar: BaseAppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: "Actors and Actress",
          onSelected: model.onSelected,
          popupMenuButtonKey: model.key,
          popupMenuText: "Roster",
        ),
        body: model.isBusy
            ? loadingSpinnerWidget
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          model.isNull
                              ? const Center(
                                  child: Text(
                                      "There are no Actor / Actress registered, On Null"),
                                )
                              : model.isEmpty
                                  ? const Center(
                                      child: Text(
                                        "EMPTY\nThere are no Actor / Actress registered",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount: model.dataCount,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return model.getActorsTile(index);
                                        },
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    ButtonWidget(
                      height: 58,
                      activeButtonColor: BaseColors.buttonColor,
                      onTap: model.navigateToNewActor,
                      title: 'New Actor / Actress',
                    ),
                    verticalSpaceMedium
                  ],
                ),
              ),
      ),
    );
  }
}
