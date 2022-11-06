import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:random_color/random_color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, i) {
                  return NotificationCard(context, 'KFC Deal', '2022/11/06',
                      'New Deal available in KFC Store.');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Container NotificationCard(
      BuildContext context, String title, String dateTime, String subtitle) {
    RandomColor _randomColor = RandomColor();
    List<ColorHue> colors = [ColorHue.red, ColorHue.green, ColorHue.yellow];
    Color _color = _randomColor.randomColor(
        colorSaturation: ColorSaturation.lowSaturation,
        colorBrightness: ColorBrightness.light,
        colorHue: ColorHue.multiple(colorHues: colors));
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            stops: [0.02, 0.02], colors: [_color, Colors.white]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5, // soften the shadow
            spreadRadius: 1, //extend the shadow
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                dateTime,
                textAlign: TextAlign.left,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.left,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
