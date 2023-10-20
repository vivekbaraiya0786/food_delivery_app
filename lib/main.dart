import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/screen/food_list_page.dart';
import 'package:food_delivery_app/views/screen/homepage.dart';
import 'package:food_delivery_app/views/screen/mainpge.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controller/jsonprovider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FoodProvider(),
        ),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.light(useMaterial3: true),
          initialRoute: '/MainPage',
          getPages: [
            GetPage(
              name: '/',
              page: () => HomePage(),
            ),
            GetPage(
              name: '/MainPage',
              page: () => MainPage(),
            ),
            GetPage(
              name: '/food_list',
              page: () => food_list(),
            ),
          ],
        );
      },
    ),
  );
}
