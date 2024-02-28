import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) filterLocation;
   const SearchTextField({required this.controller,required this.filterLocation,super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.comfortaa(),
      onChanged: (value) {
        filterLocation(value);
      },
      decoration: const InputDecoration(
        hintText: 'Filter Countries',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }
}
