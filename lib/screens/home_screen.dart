import 'package:flutter/material.dart';
import 'package:visited_places/screens/places_list.dart';

import 'package:visited_places/widgets/image_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places App'),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ImageContainer(
              nextPage: PlacesList(),
              startImage: 'assets/images/morze.jpg',
              buttonName: 'Visited places',
              icon: Icons.airplanemode_active,
            ),
          ],
        ),
      ),
    );
  }
}
