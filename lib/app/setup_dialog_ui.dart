import 'package:cast_actors/enum/dialoge_type.dart';
import 'package:cast_actors/ui/shared/dialog/basic_dialoge.dart';
import 'package:cast_actors/ui/shared/dialog/form_dialog.dart';
import 'package:cast_actors/ui/shared/dialog/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form: (context, sheetRequest, completer) =>
        FormDialog(request: sheetRequest, completer: completer),
    DialogType.loading: (context, sheetRequest, completer) => LoadingDialog(
          compeleter: completer,
          request: sheetRequest,
        )
  };

  dialogService.registerCustomDialogBuilders(builders);
}
