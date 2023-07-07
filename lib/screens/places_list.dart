import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:places/data/places_data.dart';
import 'package:visited_places/models/visited_place_model.dart';
import 'package:visited_places/providers/visited_place.dart';
import 'package:visited_places/screens/add_place_screen.dart';
import 'package:visited_places/screens/place_item.dart';
import 'package:visited_places/widgets/place_list_item.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({Key? key}) : super(key: key);
  @override
  ConsumerState<PlacesList> createState() {
    return _PlacesListState();
  }
}

class _PlacesListState extends ConsumerState<PlacesList> {
  //final List<VisitedPlace> _placesList = availablePlaces;

  void selectPlace(BuildContext context, VisitedPlace visitedPlace) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceItem(
          visitedPlace: visitedPlace,
        ),
      ),
    );
  }

  late Future<void> _loadPlacesList;

  @override
  void initState() {
    super.initState();
    _loadPlacesList =
        ref.read(visitedPlacesProvider.notifier).loadVisitedPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final listOfPlaces = ref.watch(visitedPlacesProvider);

    var body = Center(
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder(
              future: _loadPlacesList,
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: listOfPlaces.length,
                          itemBuilder: (ctx, index) => PlaceListItem(
                            // text: listOfPlaces[index].title,
                            // date: listOfPlaces[index].formattedDate,
                            onSelectPlace: selectPlace,
                            visitedPlace: listOfPlaces[index],
                          ),
                        ),
            ),

            // ListView.builder(
            //   itemCount: listOfPlaces.length,
            //   itemBuilder: (ctx, index) => PlaceListItem(
            //     // text: listOfPlaces[index].title,
            //     // date: listOfPlaces[index].formattedDate,
            //     onSelectPlace: selectPlace,
            //     visitedPlace: listOfPlaces[index],
            //   ),
            // ),
            // ListView.builder(
            //   itemCount: _placesList.length,
            //   itemBuilder: (ctx, index) => PlaceListItem(
            //     text: _placesList[index].title,
            //     date: _placesList[index].formattedDate,
            //     onSelectPlace: selectPlace,
            //     visitedPlace: _placesList[index],
            //   ),
            // ),
          ),
        ],
      ),
    );

    if (listOfPlaces.isEmpty) {
      body = const Center(
        child: Text('Add Your visited places.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visited Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddPlaceScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          // ),
        ],
      ),
      body: body,
    );
  }
}
