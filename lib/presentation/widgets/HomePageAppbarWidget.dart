import 'package:egov/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'text_view.dart';

class HomePageAppbarWidget extends StatefulWidget {
  String collapsedState;
  Function(String) onCollapsed;

  HomePageAppbarWidget({required this.collapsedState, required this.onCollapsed,super.key});

  @override
  State<HomePageAppbarWidget> createState() => _HomePageAppbarWidgetState();
}

class _HomePageAppbarWidgetState extends State<HomePageAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.collapsedState.isEmpty ? AppBar(
      centerTitle: false,
      title: const TextView(
        text: 'Locations',
        fontSize: 18,
      ),
      actions: [
        InkResponse(
            onTap: () {
              widget.onCollapsed(AppConstants.HORIZONTAL_COLLAPSED_STATE);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(
                Icons.minimize,
                color: Colors.blue,
              ),
            )),
        InkResponse(
          onTap: () {
            widget.onCollapsed(AppConstants.VERTICAL_COLLAPSED_STATE);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.logout, color: Colors.blue),
          ),
        )
      ],
    ) : const SizedBox();
  }
}
