import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:visited_places/models/visited_place_model.dart';
import 'package:visited_places/screens/place_item.dart';

class PlaceListItem extends ConsumerWidget {
  const PlaceListItem(
      {Key? key, required this.onSelectPlace, required this.visitedPlace})
      : super(key: key);

  final void Function(BuildContext context, VisitedPlace visitedPlace)
      onSelectPlace;
  final VisitedPlace visitedPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => PlaceItem(
                    visitedPlace: visitedPlace,
                  )),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundImage: FileImage(visitedPlace.image),
        ),
        title: Text(
          visitedPlace.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        trailing: Text(
          visitedPlace.formattedDate,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
        ),
      ),
    );
  }
}
