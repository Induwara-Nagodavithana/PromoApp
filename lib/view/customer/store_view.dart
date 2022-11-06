import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/divider/mySeparator.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:random_color/random_color.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class StoreViewPage extends StatefulWidget {
  const StoreViewPage({super.key});

  @override
  State<StoreViewPage> createState() => _StoreViewPageState();
}

class _StoreViewPageState extends State<StoreViewPage> {
  final Color _color = RandomColor().randomColor(
      colorSaturation: ColorSaturation.mediumSaturation,
      colorBrightness: ColorBrightness.dark,
      colorHue: ColorHue.multiple(
          colorHues: [ColorHue.red, ColorHue.yellow, ColorHue.red]));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Store",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(1.0),
                    width: 300,
                    height: 500,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 198, 40, 40),
                      color: _color,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ClipOval(
                          child: CachedNetworkImage(
                              height: 150,
                              width: 150,
                              imageUrl:
                                  'https://play-lh.googleusercontent.com/0loj-whL4XSeF4v5W3d213b1pH0RRTQUlmK1VESE-Rsydp06rVyPTq_Hwpwm1avB8URL',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.store,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  ),
                              errorWidget: (context, url, error) => Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.store,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "KFC",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Open between",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                          "10.00 am to 10.00 pm",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Address",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                          "Niladeniya, Hapugala, Wackwella, sdfdsfsfsd",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Category",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Text(
                                  "Foods",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 2,
                              height: 50,
                              child: VerticalDivider(
                                color: Colors.white,
                                thickness: 2,
                                // width: 3,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ContactNo",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Text(
                                  "0123456789",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          height: 50,
                          child: SfBarcodeGenerator(
                            value: 'www.syncfusion.com',
                            barColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 400,
                    left: -1,
                    child: Container(
                      width: 10,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 400,
                    right: -1,
                    child: Container(
                      width: 10,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 410,
                    left: -1,
                    child: Container(
                        width: size.width,
                        child: MySeparator(
                          color: Colors.white,
                          height: 3,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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
                  'Subscribe',
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
