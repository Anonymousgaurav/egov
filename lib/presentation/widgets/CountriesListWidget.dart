import 'package:flutter/material.dart';

import '../../model/LocationModel.dart';
import 'text_view.dart';

class CountriesListWidget extends StatelessWidget {
  ScrollController scrollController;
  List<LocationData> filteredLocations;
  Function(bool) countrySelected;
   CountriesListWidget({required this.scrollController,required this.filteredLocations, required this.countrySelected,super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        controller: scrollController,
        itemCount: filteredLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
                value: filteredLocations[index].isSelected,
                onChanged: (val) {
                  countrySelected(filteredLocations[index].isSelected = val!);
                }),
            title: TextView(
                text:
                '${filteredLocations[index].city} - ${filteredLocations[index].country}'),
          );
        },
      ),
    );
  }
}
