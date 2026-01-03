import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:study_case/view/controller/form_controller.dart';

class MapOutletPage extends StatefulWidget {
  const MapOutletPage({super.key});

  @override
  State<MapOutletPage> createState() => _MapOutletPageState();
}

class _MapOutletPageState extends State<MapOutletPage> {
  @override
  Widget build(BuildContext context) {
    var controller = context.watch<FormController>();
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.341952481686441, 106.69173186753038),
          zoom: 13
        ),
        markers: controller.markers,
        onTap: (argument) => controller.selectLocation(argument),
      ),
    );
  }
}
