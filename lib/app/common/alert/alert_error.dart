
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:study_case/app/style/color_pallete.dart';

class AlertError {
  Future<Widget> showAlert(
    BuildContext context,
    String title,
    String body,
  ) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: title,
      titleTextStyle: TextStyle(color: colorRed),
      body: Text(body, style: TextStyle(fontSize: 14, color: colorRed)),
    ).show();
  }
}