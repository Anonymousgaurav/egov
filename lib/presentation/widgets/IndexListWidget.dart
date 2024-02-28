import 'package:flutter/material.dart';

import 'text_view.dart';

class IndexListWidget extends StatelessWidget {
  ScrollController scrollController;
  List<String> charsToDisplay;
  Function(String) scrollToIndex;
   IndexListWidget({required this.scrollController,required this.charsToDisplay, required this.scrollToIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        controller: scrollController,
        itemCount: charsToDisplay.length,
        itemBuilder: (context, index) {
          final char = charsToDisplay[index];
          return InkResponse(
            onTap: () => scrollToIndex(char),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextView(
                text: char,
                fontSize: 10,
              ),
            ),
          );
        },
      ),
    );

  }
}
