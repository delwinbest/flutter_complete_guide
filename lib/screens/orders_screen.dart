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
  bool _isLoading = false;
  @override
  // void initState() {
  //   _isLoading = true;
  //   Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final Orders orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          child: FutureBuilder(
              future: Provider.of<Orders>(context, listen: false)
                  .fetchAndSetOrders(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return const Center(child: Text('An error occurred'));
                  } else {
                    return Consumer<Orders>(
                        builder: (ctx, orderData, child) => ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, index) =>
                                OrderItems(order: orderData.orders[index])));
                  }
                }
              })),
    );
  }
}
