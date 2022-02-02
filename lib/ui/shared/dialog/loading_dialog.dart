import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LoadingDialog extends StatelessWidget {
  final Function(DialogResponse) compeleter;
  final DialogRequest request;

  const LoadingDialog(
      {Key? key, required this.compeleter, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        width: 60,
        height: 60,
        child: const CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
