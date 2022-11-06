import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/text_field_container/text_field_container_widget.dart';
import 'package:promo_app/theme/theme.dart';

class RoundedSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedSearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 20,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          focusColor: AppTheme.kPrimaryColor,
          prefixIconColor: AppTheme.kPrimaryLightColor,
          iconColor: AppTheme.kPrimaryLightColor,
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: Color.fromARGB(255, 160, 160, 160),
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
