import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_case/app/style/color_pallete.dart';
import 'package:study_case/view/controller/home_controller.dart';
import 'package:study_case/view/pages/form_outlet_page.dart';

class HomeOutletPage extends StatelessWidget {
  const HomeOutletPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Outlet")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(FormOutletPage()),
        backgroundColor: colorPrimary,
        child: Icon(Icons.add, color: colorAccent,),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onChanged: (value) => controller.searchOutlet(value),
          ),
          StreamBuilder(
            stream: controller.getAllOutlet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Shimmer.fromColors(
                    child: Text(
                      "Please Wait...",
                      style: TextStyle(fontSize: 40),
                    ),
                    baseColor: colorPrimary,
                    highlightColor: colorSecondary,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error",
                    style: TextStyle(color: colorRed, fontSize: 40),
                  ),
                );
              }
              var items = snapshot.data;
              if (items!.isEmpty) {
                return Center(
                  child: Text("No Data", style: TextStyle(fontSize: 40)),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var element = items[index];
                      return Card(child: Text(element['name']));
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
