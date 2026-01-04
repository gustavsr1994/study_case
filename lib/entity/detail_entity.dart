import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailEntity {
  final String name;
  final String description;
  final LatLng location;
  final String typeBusiness;
  final List<String> facilities;
  final String openOutlet;
  final String closeOutlet;
  DetailEntity(
    this.name,
    this.typeBusiness,
    this.description,
    this.location,
    this.openOutlet,
    this.closeOutlet,
    this.facilities,
  );
}
