import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:visited_places/providers/visited_place.dart';

import 'package:visited_places/widgets/add_main_image.dart';
import 'package:visited_places/widgets/alert_dialog.dart';

final formatedDate = DateFormat.yMd();

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  DateTime? chooseDate;
  final _titleController = TextEditingController();
  File? _imageChosen;
  String _alertText = '';

  void _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100);
    final initialDate = now;
    final lastDate = DateTime(now.year + 30);

    final pickedDate = await showDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      context: context,
    );
    setState(() {
      chooseDate = pickedDate;
    });
  }

  void saveNewPlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || chooseDate == null || _imageChosen == null) {
      _imageChosen ?? {_alertText = 'Pick an image or take a photo'};
      chooseDate ?? {_alertText = 'Choose Date'};
      if (enteredTitle.isEmpty) {
        _alertText = 'Add a title to this place, eg. Name of country or city';
      }

      showDialog(
        context: context,
        builder: (context) => TextButtonAlertDialog(dialogText: _alertText),
      );
      return;
    }
    ref
        .read(visitedPlacesProvider.notifier)
        .addVisitedPlace(enteredTitle, chooseDate!, _imageChosen!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      fontSize: 20,
      color: Theme.of(context).colorScheme.copyWith().primary,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: const Text(
                    'Pick date',
                  ),
                ),
                Text(
                  chooseDate == null
                      ? 'No date added'
                      : formatedDate.format(chooseDate!),
                  // style: TextStyle(
                  //   color: Theme.of(context).colorScheme.copyWith().primary,
                  // ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: saveNewPlace,
                  child: const Text('Submit'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Text(
              'Your main photo:',
              style: mainTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddMainImage(
                onChosenImage: (picture) {
                  _imageChosen = picture;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
