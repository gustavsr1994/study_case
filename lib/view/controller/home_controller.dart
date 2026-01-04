import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:study_case/app/common/alert/alert_warning.dart';
import 'package:study_case/data/outlet_data_source.dart';
import 'package:study_case/entity/detail_entity.dart';
import 'package:study_case/view/pages/detail_outlet_page.dart';

class HomeController extends ChangeNotifier {
  String keywordSearch = '';
  OutletDataSource _dataSource = OutletDataSource();

  Stream<List<DocumentSnapshot>> getAllOutlet() async* {
    try {
      var result = _dataSource.fetchAllOutlet();
      yield* result.map((item) {
        if (keywordSearch != '') {
          return item.docs
              .where(
                (element) => element['name'].toString().toLowerCase().contains(
                  keywordSearch.toLowerCase(),
                ),
              )
              .toList();
        }
        return item.docs;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void searchOutlet(String keyword) {
    keywordSearch = keyword;
    notifyListeners();
  }

  void actionDelete(BuildContext context, String idDoc) async {
    try {
      await _dataSource.deleteOutlet(idDoc);
    } catch (e) {
      AlertWarning().showAlert(
        context,
        "Failed Delete",
        "Error: ${e.toString()}",
      );
    }
  }

  void actionViewDetail(String idDoc) async {
    var result = await _dataSource.detailOutlet(idDoc);
    var position = result['position'] as GeoPoint;

    List<String> facilities = [];
    for (var element in result['facilities']) {
      facilities.add(element);
    }
    DetailEntity entity = DetailEntity(
      result['name'],
      result['type_business'],
      result['description'],
      LatLng(position.latitude, position.longitude),
      result['hour_operation']['open'],
      result['hour_operation']['close'],
      facilities,
    );
    Get.to(DetailOutletPage(entity));
  }
}
