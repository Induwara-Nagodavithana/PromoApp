import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/theme/theme.dart';

class AddDealsPage extends StatefulWidget {
  const AddDealsPage({super.key});

  @override
  State<AddDealsPage> createState() => _AddDealsPageState();
}

class _AddDealsPageState extends State<AddDealsPage> {
  String description = '';
  String price = '';
  String offercount = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "All Offers",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: AppTheme.kPrimaryColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    cursorHeight: 20,
                    autofocus: false,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: AppTheme.kPrimaryColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                    ),
                    controller: TextEditingController(text: description),
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter the description of deal",

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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppTheme.kPrimaryColor, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 159, 119, 211),
                            width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppTheme.kPrimaryColor, width: 1.5),
                      ),
                    ),
                    onChanged: ((value) {
                      // setState(() {
                      description = value;
                      // });
                    }),
                  ),
                ),
                RectangleTextField(
                    labelText: "Price",
                    hintText: "Enter price of the deal",
                    value: price,
                    onChanged: ((value) {
                      // setState(() {
                      price = value;
                      // });
                    })),
                RectangleTextField(
                    labelText: "Offer Count",
                    hintText: "Enter offer count",
                    value: offercount,
                    onChanged: ((value) {
                      // setState(() {
                      offercount = value;
                      // });
                    })),
                    SizedBox(
                      height: 50,
                    ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.kPrimaryColor,
                    onSurface: Colors.red,
                    minimumSize: Size(200, 40),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
