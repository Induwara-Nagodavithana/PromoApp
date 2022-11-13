import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/deal.dart';
import 'package:promo_app/model/store.dart' as StoreModel;
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/owner/add_deals.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DealOwnerPage extends StatefulWidget {
  const DealOwnerPage({super.key});

  @override
  State<DealOwnerPage> createState() => _DealOwnerPageState();
}

class _DealOwnerPageState extends State<DealOwnerPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Message> deals = [];
  String userId = '';
  String storeId = '';
  void getDeals() async {
    ///whatever you want to run on page build
    ///
    userId = await DataStore.shared.getUserId();

    print('userId');
    print(userId);

    HttpService()
        .getInstance()
        .get('/stores/getStoreByOwnerId/$userId')
        .then((value) async {
      print(value);
      Map<String, dynamic> data = jsonDecode(value.data);
      print(data['message']);
      print(data['message']['_id']);
      // StoreModel.StoreModel storeModel =
      //     StoreModel.StoreModel.fromJson(jsonDecode(value.data));
      // print(storeModel.message);
      DataStore.shared.setStoreId = data['message']['_id'];
      storeId = data['message']['_id'];
      print(storeId);

      HttpService()
          .getInstance()
          .get('/deals/getDealsByStore/$storeId')
          .then((value) async {
        print(value);
        print('dfgdgdfgfdg');

        DealModel dealModel = DealModel.fromJson(jsonDecode(value.data));
        print('123456');

        print(dealModel.message);

        setState(() {
          deals = dealModel.message!;
          storeId = storeId;
        });
      }).catchError((err) {
        print(err);
        Fluttertoast.showToast(
            msg: "Cannot Get Deals",
            backgroundColor: Color.fromARGB(255, 211, 47, 47),
            textColor: Colors.white,
            fontSize: 15.0);
      });
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get Store",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });

    // ....
  }

  @override
  void initState() {
    super.initState();
    getDeals();
  }

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

    Future<void> deleteDeal(String dealId) async {
      print(dealId);

      ///whatever you want to run on page build
      HttpService().getInstance().delete('/deals/$dealId').then((value) async {
        print(value);
        getDeals();
      }).catchError((err) {
        print(err);
        Fluttertoast.showToast(
            msg: "Cannot Delete Deal",
            backgroundColor: Color.fromARGB(255, 211, 47, 47),
            textColor: Colors.white,
            fontSize: 15.0);
      });
      // ....
    }

    Future<void> _showMyDialog(String dealId) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: AlertDialog(
              title: Column(
                children: [
                  Lottie.asset('assets/images/question.json'),
                  Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text(
                "Are you sure to delete this",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 102, 102, 102),
                          onSurface: Colors.red,
                          minimumSize: Size(80, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        onPressed: () {
                          // onCancell();
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.kPrimaryColor,
                          onSurface: Colors.red,
                          minimumSize: Size(80, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Confirm',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        onPressed: () async {
                          // onConfirm();
                          await deleteDeal(dealId);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

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
          heroTag: "btn2",

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
      body: SmartRefresher(
        onRefresh: () async {
          getDeals();
          await Future.delayed(Duration(milliseconds: 1000));
          _refreshController.refreshCompleted();
        },
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.white,
          color: AppTheme.kPrimaryColor,
        ),
        child: ListView.builder(
          itemCount: deals.length,
          itemBuilder: (context, i) {
            return DealCard(
                deals[i].store!.imageUrl!,
                deals[i].store!.name!,
                deals[i].description!,
                deals[i].price!,
                deals[i].offerCount!,
                deals[i].sId!,
                _showMyDialog,
                deals[i]);
          },
        ),
      ),
    );
  }

  Padding DealCard(
      String image,
      String name,
      String description,
      String price,
      String offers,
      String dealId,
      Future<void> Function(String dealId) showMyDialog,
      Message data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddDealsPage(
                        data: data,
                      );
                      // return LandingDrawerView();
                    },
                  ),
                );
              },
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          name,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                            heroTag: "btn1$dealId",
                            elevation: 0,
                            onPressed: () {
                              // Add your onPressed code here!
                              showMyDialog(
                                dealId,
                              );
                            },
                            child: FaIcon(
                              FontAwesomeIcons.circleXmark,
                              color: Colors.red,
                            ),
                            backgroundColor: Colors.white),
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
                           price,
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
