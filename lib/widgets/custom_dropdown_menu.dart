import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/constants.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu(
      {Key? key,
      required this.items,
      required this.value,
      required this.onChange})
      : super(key: key);
  final List<String> items;
  final String value;
  final Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        onChanged: (String? value) {
          onChange(value);
        },
        icon: Icon(
          Icons.location_on_outlined,
          size: 28,
          color: kDpurpule,
        ),
        dropdownColor: kDpurpule,
        items: items.map<DropdownMenuItem<String>>((String country) {
          return DropdownMenuItem(
            value: country,
            child: Text(
              country,
              style: GoogleFonts.sassyFrass(color: kDpurpule, fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }
}
