import 'dart:convert';

import '../models/dish.dart';
import 'abstract_service.dart';

class DishService extends AbstractService {
  Future<List<Dish>> fetchDishes() async {
    final response = await get('dish');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final stringData = response.body;
      var responseJson = json.decode(stringData);

      return (responseJson as List).map((p) => Dish.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dishes');
    }
  }

  Future<Dish> createDish(Dish dish) async {
    final response = await post('dish', jsonEncode(dish));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final stringData = response.body;
      var responseJson = json.decode(stringData);

      return Dish.fromJson(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to add dish');
    }
  }

  Future<Dish> updateDish(Dish dish) async {
    final response = await put('dish', jsonEncode(dish));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final stringData = response.body;
      var responseJson = json.decode(stringData);

      return Dish.fromJson(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update dish');
    }
  }

  Future<Dish> deleteDish(Dish dish) async {
    final response = await delete('dish', jsonEncode(dish));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final stringData = response.body;
      var responseJson = json.decode(stringData);

      return Dish.fromJson(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to delete dish');
    }
  }
}
