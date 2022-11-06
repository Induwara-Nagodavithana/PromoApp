import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';

class RectangleTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String value;
  final ValueChanged<String> onChanged;
  const RectangleTextField({super.key, required this.labelText, required this.hintText, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: TextField(
        cursorHeight: 20,
        autofocus: false,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: AppTheme.kPrimaryColor,
              fontSize: 15.0,
              fontWeight: FontWeight.normal),
        ),
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: AppTheme.kPrimaryColor,
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
          ),
          hintStyle: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: AppTheme.kPrimaryColor,
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
          ),
          focusColor: AppTheme.kPrimaryColor,
          // prefixIcon: Icon(Icons.star),
          // suffixIcon: Icon(Icons.keyboard_arrow_down),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppTheme.kPrimaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 159, 119, 211), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppTheme.kPrimaryColor, width: 1.5),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
