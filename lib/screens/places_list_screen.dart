import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places_provider.dart';
import 'package:flutter_complete_guide/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreeen extends StatelessWidget {
  const PlacesListScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Consumer<GreatPlacesProvider>(
                  child: const Center(
                    child: Text('No places added yet'),
                  ),
                  builder: (context, provider, child) => provider.items.isEmpty
                      ? child as Widget
                      : ListView.builder(
                          itemCount: provider.items.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(provider.items[index].image),
                            ),
                            title: Text(provider.items[index].title),
                            onTap: () {
                              // Go to detail page
                            },
                          ),
                        ),
                ),
              ),
      ),
    );
  }
}
