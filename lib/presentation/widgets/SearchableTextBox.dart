import 'package:flutter/material.dart';
class SearchableTextBox extends StatefulWidget {
  const SearchableTextBox({super.key});

  @override
  State<SearchableTextBox> createState() => _SearchableTextBoxState();
}

class _SearchableTextBoxState extends State<SearchableTextBox> {

  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final _textController = TextEditingController();
  String? search = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 243,
        child: CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              child: _buildAutocompleteContainer(context),
            )));  }


  Widget _buildAutocompleteContainer(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildAutocompleteText(context)],
    );
  }

  Widget _buildAutocompleteText(BuildContext context) {
    return Expanded(
        child: TextField(
          focusNode: _focusNode,
          controller: _textController,
          autofocus: false,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
        ),);
  }

  void _onSearchChanged(String? value) {
    search = value;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

}
