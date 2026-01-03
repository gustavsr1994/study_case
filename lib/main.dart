import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:study_case/view/controller/home_controller.dart';
import 'package:study_case/view/pages/home_outlet_page.dart';

import 'firebase_options.dart';
import 'view/controller/form_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialFirebase();
  runApp(const MyApp());
}

Future initialFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => FormController()),

      ],
      child: GetMaterialApp(title: 'Flutter Demo', home: HomeOutletPage()),
    );
  }
}
