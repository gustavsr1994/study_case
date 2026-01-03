import 'package:cloud_firestore/cloud_firestore.dart';

class OutletDataSource {
  var collection = FirebaseFirestore.instance.collection('outlet');
  Stream<QuerySnapshot> fetchAllOutlet() async* {
    try {
      yield* collection.snapshots();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}