// lib/bloc/order_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/orders.dart';
import '../storage/shared_prefs.dart';

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]);

  Future<void> loadOrders() async {
    List<Order> orders = await SharedPrefs.getOrders();
    emit(orders);
  }

  Future<void> addOrder(Order order) async {
    final currentOrders = state;
    final updatedOrders = List<Order>.from(currentOrders)..add(order);
    emit(updatedOrders);
    // Also save to local storage
    final encodedOrders = updatedOrders.map((e) => e.toJson()).toList();
    await SharedPrefs.saveOrders(encodedOrders.cast<Order>());
  }
}
