import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' show Orders;
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../widgets/order_items.dart';

import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
        (_) => Provider.of<Orders>(context, listen: false).fetchAndSetOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Orders orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        child: ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (ctx, index) =>
                OrderItems(order: orderData.orders[index])),
      ),
    );
  }
}
