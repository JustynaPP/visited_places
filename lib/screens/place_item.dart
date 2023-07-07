import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visited_places/models/visited_place_model.dart';

class PlaceItem extends ConsumerStatefulWidget {
  const PlaceItem({Key? key, required this.visitedPlace}) : super(key: key);
  final VisitedPlace visitedPlace;

  @override
  ConsumerState<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends ConsumerState<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visited place: ${widget.visitedPlace.title}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            children: [
              Container(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.visitedPlace.title,
                    style: const TextStyle(
                        //color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 23),
                  ),
                  Text(
                    widget.visitedPlace.formattedDate,
                    style: const TextStyle(
                        //color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 17),
                  ),
                ],
              ),
              Container(
                height: 15,
              ),
              const Divider(),
              Container(
                height: 15,
              ),
              Image.file(widget.visitedPlace.image,
                  fit: BoxFit.cover, height: 300, width: double.infinity),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
