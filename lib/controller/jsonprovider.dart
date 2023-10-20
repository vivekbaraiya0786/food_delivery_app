import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../modal/food_modal.dart';
import '../modal/json_modal.dart';

class FoodProvider with ChangeNotifier {
  FoodModal foodModal = FoodModal(food: []);

  Future<void> loadjson() async {
    try {
      String data = await rootBundle.loadString("assets/json/food.json");
      List jsonList = jsonDecode(data);
      foodModal.food = jsonList.map((e) => Food.fromJson(json: e)).toList();
      notifyListeners();
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }
}
