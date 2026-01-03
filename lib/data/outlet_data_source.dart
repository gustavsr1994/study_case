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

  Future insertOutlet(Map<String, dynamic> request) async {
    try {
      await collection.add(request);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future deleteOutlet(String idDoc) async {
    try {
      await collection.doc(idDoc).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateOutlet(String idDoc, Map<String, dynamic> request) async {
    try {
      await collection.doc(idDoc).update(request);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DocumentSnapshot> detailOutlet(String idDoc) async {
    try {
      return await collection.doc(idDoc).get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}