import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItems extends StatelessWidget {
  final ord.OrderItem order;
  const OrderItems({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('MM/dd/yyyy hh:mm').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
