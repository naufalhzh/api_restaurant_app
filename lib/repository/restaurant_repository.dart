import 'dart:convert';
import 'package:api_restaurant_app/models/restaurant_detail_model.dart';
import 'package:api_restaurant_app/models/restaurant_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://restaurant-api.dicoding.dev';

Future<List<Restaurant>> fetchRestaurants() async {
  final response = await http.get(Uri.parse('$baseUrl/list'));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final list = result['restaurants'] as List<dynamic>;
    return list.map((item) => Restaurant.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load restaurants');
  }
}

Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
  final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    return RestaurantDetail.fromJson(result['restaurant']);
  } else {
    throw Exception('Failed to load restaurant detail');
  }
}

Future<List<Restaurant>> searchRestaurants(String query) async {
  final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final list = result['restaurants'] as List<dynamic>;
    return list.map((item) => Restaurant.fromJson(item)).toList();
  } else {
    throw Exception('Failed to search restaurants');
  }
}