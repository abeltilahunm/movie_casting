import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BasicDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${request.title}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () =>
                        completer(DialogResponse(confirmed: true, data: {
                          "name": "Abel",
                        })),
                    child: Text(request.mainButtonTitle!),
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.red))),
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: Text(
                    request.secondaryButtonTitle!,
                    style: const TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
