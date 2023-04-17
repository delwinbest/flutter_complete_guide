import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class ProductOverViewScreen extends StatelessWidget {
  const ProductOverViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productsContainer =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Overview'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.favorites) {
                  productsContainer.showFavoritesOnly();
                } else {
                  productsContainer.showAll();
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: FilterOptions.favorites,
                        child: Text('Only Favorites')),
                    const PopupMenuItem(
                        value: FilterOptions.all, child: Text('Show All'))
                  ])
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
