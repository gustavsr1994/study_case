import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        onPressed: () => Get.to(FormOutletPage("0")),
        backgroundColor: colorPrimary,
        child: Icon(Icons.add, color: colorAccent),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              suffixIcon: Icon(Icons.search),
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
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${element['name'].toString().toUpperCase()} - ${element['type_business']}',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => controller.actionViewDetail(element.id),
                                  icon: Icon(
                                    Icons.visibility,
                                    color: colorPrimary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => context.read<HomeController>().actionDelete(context, element.id),
                                  icon: Icon(Icons.delete, color: colorRed),
                                ),
                                IconButton(
                                  onPressed: () => Get.to(FormOutletPage(element.id)),
                                  icon: Icon(Icons.edit, color: colorGreen),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
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
