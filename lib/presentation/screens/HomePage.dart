import 'package:egov/presentation/styles/AppStyles.dart';
import 'package:egov/presentation/widgets/CountriesListWidget.dart';
import 'package:egov/presentation/widgets/HomePageAppbarWidget.dart';
import 'package:egov/resources/ColorsRes.dart';
import 'package:egov/utils/AppConstants.dart';
import 'package:egov/utils/DeviceUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/LocationModel.dart';
import '../widgets/IndexListWidget.dart';
import '../widgets/SearchTextFieldWidget.dart';
import '../widgets/text_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<LocationData> filteredLocations = [];
  ScrollController mainScrollController = ScrollController();
  ScrollController indexScrollController = ScrollController();
  bool isAppBarMinimized = false;
  String collapsedState = '';

  @override
  void initState() {
    super.initState();
    sortLocations();
    filteredLocations.addAll(locationList);
    mainScrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageAppbarWidget(
                  onCollapsed: onChangedState, collapsedState: collapsedState),
              _screenState(collapsedState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenState(String state) {
    switch (state) {
      case AppConstants.VERTICAL_COLLAPSED_STATE:
        return verticalCollapsed();
      case AppConstants.HORIZONTAL_COLLAPSED_STATE:
        return horizontalCollapsed();
      default:
        return buildBody();
    }
  }

  /// build app bar based on state events
  void onChangedState(String state) {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(
            () {
          collapsedState = state;
        },
      ),
    );
  }

  /// build vertical widget
  Widget verticalCollapsed() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: DeviceUtils.fractionHeight(context, fraction: 4.0),
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.fractionHeight(context, fraction: 10.0)),
        padding: const EdgeInsets.symmetric(
          horizontal: _Dimens.PADDING_VERTICAL,
          vertical: _Dimens.PADDING_VERTICAL,),
        decoration: BoxDecoration(
          color: ColorsRes.greyColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// The number of clockwise quarter turns the child should be rotated.
            InkWell(
                onTap: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                    collapsedState = '';
                  }));
                },

                /// -2 shows rotate widget by 180 degree
                child: const RotatedBox(
                    quarterTurns: -2,
                    child: Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ))),
            const Spacer(),

            /// The number of clockwise quarter turns the child should be rotated.
            /// -1 shows rotate widget by 90 degree clockwise
            RotatedBox(
              quarterTurns: -1,
              child: TextView(
                text: "Locations",
                fontWeight: FontWeight.bold,
                fontSize: DeviceUtils.fractionWidth(context, fraction: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// build horizontal collapsed
  Widget horizontalCollapsed() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.fractionWidth(context, fraction: 15.0),
            vertical: DeviceUtils.fractionWidth(context, fraction: 15.0)),
        margin: EdgeInsets.symmetric(
            horizontal: DeviceUtils.fractionWidth(context, fraction: 15.0)),
        decoration: BoxDecoration(
          color: ColorsRes.greyColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextView(
              text: "Locations",
              fontSize: 20,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {
                  collapsedState = '';
                }));
              },
              child: const Icon(
                Icons.home_max_outlined,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {
                  collapsedState = '';
                }));
              },
              child: const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    bool isAnyItemSelected =
    filteredLocations.any((location) => location.isSelected);
    List<String> charsToDisplay = getCharsToDisplay();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.fractionWidth(context, fraction: 20.0)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              controller: searchController,
              filterLocation: getFilterLocation,
            ),
            SizedBox(
              height: DeviceUtils.fractionHeight(context, fraction: 40.0),
            ),
            isAnyItemSelected
                ? InkResponse(
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {
                  for (var location in filteredLocations) {
                    location.isSelected = false;
                  }
                }));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.clear, color: Colors.blue),
                  const SizedBox(
                    width: _Dimens.WHITE_BOX,
                  ),
                  TextView(
                    textStyle: AppStyles.clearTextStyle,
                    text: 'Clear All',
                  )
                ],
              ),
            )
                : const SizedBox.shrink(),
            isAnyItemSelected
                ? const SizedBox(
              height: 14,
            )
                : const SizedBox.shrink(),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountriesListWidget(
                    scrollController: mainScrollController,
                    filteredLocations: filteredLocations,
                    countrySelected: (selectedCountry) {
                      setState(() {});
                    },
                  ),
                  IndexListWidget(
                    scrollController: indexScrollController,
                    charsToDisplay: charsToDisplay,
                    scrollToIndex: scrollToSpecificIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollToSpecificIndex(String character) {
    scrollToIndex(character);
  }

  /// compare the countries alphabetically
  void sortLocations() {
    locationList.sort((a, b) => a.city.compareTo(b.city));
  }

  /// filter the locations based on user query
  void getFilterLocation(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredLocations = locationList
          .where((location) =>
      location.city.toLowerCase().contains(query) ||
          location.country.toLowerCase().contains(query))
          .toList();
    });
  }

  /// scrolling the list to specific index
  void scrollToIndex(String char) {
    for (int i = 0; i < filteredLocations.length; i++) {
      if (filteredLocations[i].city.startsWith(char)) {
        // match is found, scroll to the corresponding index using mainScrollController
        mainScrollController.animateTo(
          i * 55.0, // Scroll to the calculated position (index * item height)
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        // Exit the loop after scrolling to the desired index
        break;
      }
    }
  }

  /// sed to retrieve a list of characters to display based on a search query and a list of filtered locations.
  List<String> getCharsToDisplay() {
    // empty set to store unique characters
    Set<String> chars = {};
    /// user have some query in text field
    if (searchController.text.isNotEmpty) {
      for (var location in filteredLocations) {
        /// searchable query matches with original list
        if (location.city.toLowerCase().startsWith(searchController.text.toLowerCase()) ||
            location.country.toLowerCase().startsWith(searchController.text.toLowerCase())) {
          // Add the first character of the city to the set
          chars.add(location.city.substring(0, 1).toUpperCase());
        }
      }
    } else {
      // If the search query is empty, add the first character of each city to the set
      for (var location in filteredLocations) {
        chars.add(location.city.substring(0, 1).toUpperCase());
      }
    }
    // Convert the set to a list and sort the list
    List<String> sortedChars = chars.toList()..sort();
    return sortedChars;
  }
}

abstract class _Dimens {
  static const double PADDING_VERTICAL = 20.0;
  static const double WHITE_BOX = 8.0;
}
