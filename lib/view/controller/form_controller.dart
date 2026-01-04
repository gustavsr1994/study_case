import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:study_case/app/common/alert/alert_error.dart';
import 'package:study_case/app/common/alert/alert_success.dart';
import 'package:study_case/app/misc/constant_value.dart';
import 'package:study_case/data/outlet_data_source.dart';

class FormController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();
  TextEditingController openOutletField = TextEditingController();
  TextEditingController closeOutletField = TextEditingController();
  TextEditingController locationField = TextEditingController();
  Set<Marker> markers = {};
  bool isOpen = false;

  String businessSelected = listBusinessType[1];
  OutletDataSource _outletDataSource = OutletDataSource();

  void actionSelectBusiness(String type) {
    businessSelected = type;
    notifyListeners();
  }

  void actionCheckSelect(String value, bool isSelect) {
    listFacility
            .where((element) => element['value'] == value)
            .first['isSelected'] =
        isSelect;
    notifyListeners();
  }

  void showTimeSelect(BuildContext context, int index) async {
    var timeSelect = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );

    if (index == 0) {
      openOutletField.text =
          '${timeSelect!.hour.toString().padLeft(2, '0')}:${timeSelect.minute.toString().padLeft(2, '0')}';
    } else {
      closeOutletField.text =
          '${timeSelect!.hour.toString().padLeft(2, '0')}:${timeSelect.minute.toString().padLeft(2, '0')}';
    }
    notifyListeners();
  }

  void changeStatusOpen() {
    isOpen = !isOpen;
    notifyListeners();
  }

  void selectLocation(LatLng value) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId('location'), position: value));
    locationField.text = '${value.latitude};${value.longitude}';
    notifyListeners();
    Get.back();
  }

  void actionSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var request = {
        'name': nameField.text,
        'hour_operation': {
          'open': openOutletField.text,
          'close': closeOutletField.text,
        },
        'type_business': businessSelected,
        'facilities': listFacility
            .where((element) => element['isSelected'] == true)
            .map((item) => item['value'])
            .toList(),
        'is_open': isOpen,
        'description': descriptionField.text,
        'position': GeoPoint(
          double.parse(locationField.text.split(';').first),
          double.parse(locationField.text.split(';').last),
        ),
      };
      await _outletDataSource.insertOutlet(request);
      AlertSuccess().showAlert(
        context,
        "Success Submit",
        "Submited have success",
      );
    } else {
      AlertError().showAlert(context, "Check Form", "Please, check all field");
    }
  }

  void actionSubmitUpdate(BuildContext context, String idDoc) async {
    if (formKey.currentState!.validate()) {
      var request = {
        'name': nameField.text,
        'hour_operation': {
          'open': openOutletField.text,
          'close': closeOutletField.text,
        },
        'type_business': businessSelected,
        'facilities': listFacility
            .where((element) => element['isSelected'] == true)
            .map((item) => item['value'])
            .toList(),
        'is_open': isOpen,
        'description': descriptionField.text,
        'position': GeoPoint(
          double.parse(locationField.text.split(';').first),
          double.parse(locationField.text.split(';').last),
        ),
      };
      await _outletDataSource.updateOutlet(idDoc, request);
      AlertSuccess().showAlert(
        context,
        "Success Submit",
        "Submited have success",
      );
    } else {
      AlertError().showAlert(context, "Check Form", "Please, check all field");
    }
  }

  void initialForm(String idDoc) async {
    if (idDoc == "0") {
      nameField.clear();
      descriptionField.clear();
      locationField.clear();
      businessSelected = '';
      isOpen = false;
      openOutletField.clear();
      closeOutletField.clear();
      listFacility.map((item) => item['isSelected'] = false);
    } else {
      var result = await _outletDataSource.detailOutlet(idDoc);
      nameField.text = result['name'];
      descriptionField.text = result['description'];
      openOutletField.text = result['hour_operation']['open'];
      closeOutletField.text = result['hour_operation']['close'];
      businessSelected = result['type_business'];
      for (var item in result['facilities']) {
        listFacility
                .where(
                  (element) => element['value']
                      .toString()
                      .toLowerCase()
                      .contains(item.toString().toLowerCase()),
                )
                .first['isSelected'] =
            true;
      }
      var position = result['position'] as GeoPoint;
      locationField.text = '${position.latitude};${position.longitude}';
      isOpen = result['is_open'];
    }
    notifyListeners();
  }
}
