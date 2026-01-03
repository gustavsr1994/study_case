import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_case/app/common/alert/alert_warning.dart';
import 'package:study_case/data/outlet_data_source.dart';

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
}
