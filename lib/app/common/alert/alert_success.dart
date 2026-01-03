import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:study_case/app/style/color_pallete.dart';

class AlertSuccess {
  Future<Widget> showAlert(
    BuildContext context,
    String title,
    String body,
  ) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: title,
      body: Text(body, style: TextStyle(fontSize: 14, color: colorPrimary)),
    ).show();
  }
}
