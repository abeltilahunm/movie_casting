import 'package:cast_actors/ui/shared/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_helper/ui_helper.dart';

class FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  FormDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${request.title}",
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
              ),
              verticalSpaceSmall,
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: "Name", border: OutlineInputBorder()),
              ),
              verticalSpaceTiny,
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceTiny,
              TextField(
                keyboardType: TextInputType.number,
                controller: _costController,
                decoration: const InputDecoration(
                  hintText: "Cost",
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceMedium,
              ButtonWidget(
                title: request.mainButtonTitle!,
                activeButtonColor: BaseColors.buttonColor,
                onTap: () => completer(
                  DialogResponse(confirmed: true, data: {
                    "name": _nameController.text,
                    "cost": _costController.text,
                    "description": _descController.text,
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
