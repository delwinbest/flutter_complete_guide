import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' show Orders;
import '../widgets/order_items.dart';

import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Orders orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, index) =>
              OrderItems(order: orderData.orders[index])),
    );
  }
}
