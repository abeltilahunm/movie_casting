import 'package:cast_actors/ui/roaster/roaster_viewmodel.dart';
import 'package:cast_actors/ui/shared/base_appbar.dart';
import 'package:cast_actors/ui/shared/base_colors.dart';
import 'package:cast_actors/ui/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_helper/ui_helper.dart';

class RoasterView extends StatelessWidget {
  const RoasterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<RoasterViewModel>.reactive(
      viewModelBuilder: () => RoasterViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: BaseColors.white,
        appBar: BaseAppBar(
          centerTitle: false,
          title: "Roster View",
          onSelected: model.onSelected,
          automaticallyImplyLeading: false,
          popupMenuButtonKey: model.key,
          popupMenuText: "Actors and Actress",
        ),
        body: model.isBusy
            ? loadingSpinnerWidget
            : model.isNull
                ? const Center(
                    child: Text(
                      "You haven't casted any actors",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  )
                : model.isEmpty
                    ? const Center(
                        child: Text(
                          "Empty\nYou haven't casted any actors",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                children: const [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Cost",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            verticalSpaceSmall,
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: model.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return model.getCastedUser(index);
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: BaseColors.greyColor,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Total ",
                                ),
                                const Spacer(),
                                Text(
                                  model.formattedCost,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            verticalSpaceLarge,
                          ],
                        ),
                      ),
      ),
    );
  }
}
