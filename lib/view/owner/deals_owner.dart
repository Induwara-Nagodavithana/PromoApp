import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/owner/add_deals.dart';

class DealOwnerPage extends StatefulWidget {
  const DealOwnerPage({super.key});

  @override
  State<DealOwnerPage> createState() => _DealOwnerPageState();
}

class _DealOwnerPageState extends State<DealOwnerPage> {
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
      },
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
      },
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Deals",
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 5),
        child: FloatingActionButton(
          // elevation: 0,

          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddDealsPage();
                  // return LandingDrawerView();
                },
              ),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.fileCirclePlus,
            color: Colors.white,
          ),
          backgroundColor: AppTheme.kPrimaryColor,
        ),
      ),
      body: ListView.builder(
        // scrollDirection: Axis.horizontal,
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
    );
  }

  Padding DealCard(String image, String name, String description, String price,
      String offers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // margin: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              height: 180,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                            height: 50,
                            width: 50,
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
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        name,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs $price",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: AppTheme.kPrimaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "$offers Offers",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 90,
            left: 8,
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
            top: 90,
            right: 8,
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
        ],
      ),
    );
  }
}
