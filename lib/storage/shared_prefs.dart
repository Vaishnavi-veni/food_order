import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/orders.dart';

class SharedPrefs {
  static const String ordersKey = 'orders';

  // Save list of Order objects
  static Future<void> saveOrders(List<Order> orders) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedOrders =
        orders.map((order) => jsonEncode(order.toJson())).toList();
    await prefs.setStringList(ordersKey, encodedOrders);
  }

  // Load list of Order objects
  static Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedOrders = prefs.getStringList(ordersKey);
    if (encodedOrders == null) return [];

    return encodedOrders.map((str) => Order.fromJson(jsonDecode(str))).toList();
  }
}
