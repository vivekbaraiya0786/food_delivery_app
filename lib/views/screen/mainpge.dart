import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/helper/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controller/jsonprovider.dart';
import '../../modal/json_modal.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    Provider.of<FoodProvider>(context, listen: false).loadjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(CupertinoIcons.power))
        ],
      ),
      body: Consumer<FoodProvider>(
        builder: (context, foodProvider, child) {
          if (foodProvider.foodModal.food.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: foodProvider.foodModal.food[0].restaurants.length,
            itemBuilder: (context, index) {
              Restaurant restaurant =
                  foodProvider.foodModal.food[0].restaurants[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  isThreeLine: true,
                  leading: ClipRect(
                    child: Image.asset(restaurant.imageUrl,),
                  ),
                  title: Text(restaurant.name),
                  subtitle: Text("${restaurant.address}\n${restaurant.phone}"),
                  trailing: IconButton(
                    onPressed: () {
                      Get.toNamed("/food_list",arguments: restaurant);
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuthHelper.firebaseAuthHelper.signOut();
    Get.offAllNamed("/");
    Get.snackbar(
      "Signed Out",
      "You have been successfully signed out",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
