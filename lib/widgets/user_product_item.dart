import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id});

  final String title;
  final String imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Deleting failed!',
                      textAlign: TextAlign.center,
                    )));
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ))
          ],
        ),
      ),
    );
  }
}
