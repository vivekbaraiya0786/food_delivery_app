import 'dart:convert';

class Food {
  List<Restaurant> restaurants;

  Food({
    required this.restaurants,
  });


  factory Food.fromJson({required Map<String, dynamic> json}) => Food(
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(json: x))),
  );


}

class Restaurant {
  int id;
  String name;
  String cuisine;
  String address;
  String phone;
  String imageUrl;
  List<Menu> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.address,
    required this.phone,
    required this.imageUrl,
    required this.menu,
  });



  factory Restaurant.fromJson({required Map<String, dynamic> json}) => Restaurant(
    id: json["id"],
    name: json["name"],
    cuisine: json["cuisine"],
    address: json["address"],
    phone: json["phone"],
    imageUrl: json["image_url"],
    menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(json: x))),
  );


}

class Menu {
  int itemId;
  String name;
  double price;
  String imageUrl;

  Menu({
    required this.itemId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });



  factory Menu.fromJson({required Map<String, dynamic> json}) => Menu(
    itemId: json["item_id"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    imageUrl: json["image_url"],
  );


}
