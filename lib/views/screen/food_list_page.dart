import 'package:flutter/material.dart';
import '../../controller/jsonprovider.dart';
import 'package:provider/src/consumer.dart';

import '../../modal/json_modal.dart';

class food_list extends StatefulWidget {
  const food_list({super.key});

  @override
  State<food_list> createState() => _food_listState();
}

class _food_listState extends State<food_list> {
  @override
  Widget build(BuildContext context) {

    Restaurant restaurant =  ModalRoute.of(context)!.settings.arguments as Restaurant;
    return Scaffold(
      appBar: AppBar(
        title: Text("Food List"),

      ),
      body: Consumer<FoodProvider>(
        builder: (context, foodProvider, child) {
          if (foodProvider.foodModal.food.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          final restaurantMenu = restaurant.menu;
          return ListView.builder(
            itemCount: restaurantMenu.length,
            itemBuilder: (context, index) {
              final menu = restaurantMenu[index];

              
              return  Card(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            menu.imageUrl,
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(
                        top: 10,
                        left: 15,
                      ),
                      child: Text("MENU NAME :${menu.name}",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                        top: 10,
                        left: 15,
                      ),
                      child: Text("MENU NAME :${restaurant.name}"),
                    ),
                  ],
                ),
              );
                
              //   ListTile(
              //   leading: Container(
              //     height: 50,
              //     width: 50,
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage(
              //               menu.imageUrl,
              //             )
              //         )
              //     ),
              //   ),
              //   title: Text(menu.name),
              //   subtitle: Text(restaurant.cuisine),
              // );

            },
          );
        },
      ),
    );
  }
}
