import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rounded_search_field/rounded_search_field_widget.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/store_view.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data = [
      {
        "image":
            "https://play-lh.googleusercontent.com/0loj-whL4XSeF4v5W3d213b1pH0RRTQUlmK1VESE-Rsydp06rVyPTq_Hwpwm1avB8URL",
        "name": "MacDoneld",
        "description":
            "Get Big Burger and Pepsi 1L bottle 50% off before 12th Nov 2022.",
        "price": "1250",
        "offers": "100"
      },
      {
        "image":
            "https://w7.pngwing.com/pngs/476/680/png-transparent-colonel-sanders-kfc-fried-chicken-fast-food-restaurant-beauty-parlor-s-food-fast-food-restaurant-logo.png",
        "name": "KFC",
        "description":
            "Get Big Burger and Pepsi 1L bottle 50% off before 12th Nov 2022.",
        "price": "4520",
        "offers": "300"
      },
      {
        "image":
            "https://static.wikia.nocookie.net/tacobell/images/1/18/Pizza_Hut_logo.svg.png/revision/latest?cb=20161212011454",
        "name": "Pizza Hut",
        "description":
            "Get Big Burger and Pepsi 1L bottle 50% off before 12th Nov 2022.",
        "price": "3500",
        "offers": "1000"
      }
    ];
    return Container(
      color: Colors.white,
      height: size.height - 86,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stores",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Get our newest and best deals today.",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 134, 134, 134),
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: RoundedSearchField(
                      onChanged: (value) {
                        // viewModel.setEmail = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Foods",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return DealCard(
                      data[i]['image'].toString(),
                      data[i]['name'].toString(),
                      data[i]['description'].toString(),
                      data[i]['price'].toString(),
                      data[i]['offers'].toString());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clothes",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StoreViewPage();
                            // return LandingDrawerView();
                          },
                        ),
                      );
                    }),
                    child: DealCard(
                        data[i]['image'].toString(),
                        data[i]['name'].toString(),
                        data[i]['description'].toString(),
                        data[i]['price'].toString(),
                        data[i]['offers'].toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding DealCard(String image, String name, String description, String price,
      String offers) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                  height: 200,
                  width: 300,
                  imageUrl: image,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: AppTheme.kPrimaryColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "All around the island",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 143, 143, 143),
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
