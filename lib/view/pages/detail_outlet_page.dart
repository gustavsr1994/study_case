import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:study_case/app/style/color_pallete.dart';
import 'package:study_case/entity/detail_entity.dart';

class DetailOutletPage extends StatelessWidget {
  final DetailEntity entity;
  const DetailOutletPage(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Outlet")),
      body: ListView(
        children: [
          containerData("Name Outlet", entity.name),
          containerData("Type Business", entity.typeBusiness),
          containerData(
            "Hour Operational",
            '${entity.openOutlet} - ${entity.closeOutlet}',
          ),
          containerData("Description", entity.description),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: colorSecondary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Facilities",
                  style: TextStyle(
                    color: colorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entity.facilities
                      .map(
                        (element) => Text(
                          element,
                          style: TextStyle(color: colorPrimary, fontSize: 16),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 3,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: entity.location,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(entity.name),
                  position: entity.location,
                  infoWindow: InfoWindow(title: entity.name),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget containerData(String title, String value) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: colorSecondary),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(color: colorPrimary, fontSize: 16),
        ),
      ),
    );
  }
}
