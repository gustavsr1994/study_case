import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:study_case/app/misc/constant_value.dart';
import 'package:study_case/view/controller/form_controller.dart';
import 'package:study_case/view/pages/map_outlet_page.dart';

class FormOutletPage extends StatefulWidget {
  final String idDoc;
  const FormOutletPage(this.idDoc, {super.key});

  @override
  State<FormOutletPage> createState() => _FormOutletPageState();
}

class _FormOutletPageState extends State<FormOutletPage> {
  @override
  void initState() {
    super.initState();
    context.read<FormController>().initialForm(widget.idDoc);
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<FormController>();
    return Scaffold(
      appBar: AppBar(title: Text("Form Outlet")),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: controller.nameField,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return 'This field have blank';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nama Outlet',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.openOutletField,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Open Outlet',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.showTimeSelect(context, 0),
                          icon: Icon(Icons.watch_later_outlined),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller: controller.closeOutletField,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Close Outlet',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.showTimeSelect(context, 1),
                          icon: Icon(Icons.watch_later_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: controller.locationField,
                readOnly: true,
                onTap: () => Get.to(MapOutletPage()),
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tipe Bisnis",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    value: controller.businessSelected,
                    items: listBusinessType
                        .map(
                          (element) => DropdownMenuItem(
                            value: element,
                            child: Text(element),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        controller.actionSelectBusiness(value!),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Fasilitas",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: listFacility
                        .map(
                          (element) => CheckboxListTile(
                            value: element['isSelected'],
                            title: Text(element['value']),
                            onChanged: (value) => controller.actionCheckSelect(
                              element['value'],
                              value!,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                maxLines: 3,
                controller: controller.descriptionField,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field have blank';
                  }
                  if (value.length < 10) {
                    return 'Minimal 10 character';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text('Close'),
                Switch(
                  value: controller.isOpen,
                  onChanged: (value) => controller.changeStatusOpen(),
                ),
                Text('Open'),
              ],
            ),
            ElevatedButton(
              onPressed: () => widget.idDoc == "0"
                  ? controller.actionSubmit(context)
                  : controller.actionSubmitUpdate(context, widget.idDoc),
              child: Text(widget.idDoc == "0" ? "Submit" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
