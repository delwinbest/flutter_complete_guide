import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        ),
        backgroundColor: Colors.black87,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
