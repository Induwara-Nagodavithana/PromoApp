import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rounded_search_field/rounded_search_field_widget.dart';
import 'package:promo_app/components/shimmer_store_card/shimmer_store_card.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/store.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/store_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  List<Message> stores = [];
  HashMap<String?, List<Message>> hashMap = HashMap<String?, List<Message>>();
  bool isLoading = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void getStores() async {
    ///whatever you want to run on page build
    setState(() {
      isLoading = true;
    });
    HttpService().getInstance().get('/stores').then((value) async {
      print(value);

      StoreModel storeModel = StoreModel.fromJson(jsonDecode(value.data));
      print(storeModel.message);
      HashMap<String?, List<Message>> hashMapTemp =
          HashMap<String?, List<Message>>();

      for (Message element in storeModel.message!) {
        // if (hashMapTemp.containsKey(element.catergory)) {
        //   hashMapTemp.update(element.catergory, (value) {
        //     value.insert(element);
        //   });
        //   // hashMapTemp.addAll({element.catergory: element});
        // } else {
        //   hashMapTemp.putIfAbsent(element.catergory, () => [element]);
        // }
        hashMapTemp.update(element.catergory, (v) {
          v.add(element);
          return v;
        }, ifAbsent: () => [element]);
        print("hashMapTemp.toString()");
        print(hashMapTemp.toString());
      }
      // await storeModel.message!.map(
      //   (e) {
      //     if (hashMap.containsKey(e.catergory)) {
      //       hashMap.addAll({e.catergory: e});
      //     } else {
      //       hashMap.putIfAbsent(e.catergory, () => e);
      //     }
      //     print("hashMap.toString()");
      //     print(hashMap.toString());
      //     // e.catergory
      //   },
      // );
      setState(() {
        stores = storeModel.message!;
        hashMap = hashMapTemp;
        hashMap.forEach((key, value) {
          print('$key : ${value.length} ${value[0].name} ');
        });
        isLoading = false;
      });
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get Stores",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  @override
  void initState() {
    super.initState();
    getStores();
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
      }
    ];
    return Container(
      color: Colors.white,
      height: size.height - 86,
      child: SmartRefresher(
        onRefresh: () async {
          getStores();
          await Future.delayed(Duration(milliseconds: 1000));
          _refreshController.refreshCompleted();
        },
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.white,
          color: AppTheme.kPrimaryColor,
        ),
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
                    // Text(
                    //   "Foods",
                    //   style: GoogleFonts.dmSans(
                    //     textStyle: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 300,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     // shrinkWrap: true,
              //     itemCount: data.length,
              //     itemBuilder: (context, i) {
              //       return DealCard(
              //           data[i]['image'].toString(),
              //           data[i]['name'].toString(),
              //           data[i]['description'].toString(),
              //           data[i]['price'].toString(),
              //           data[i]['offers'].toString());
              //     },
              //   ),
              // ),
              isLoading
                  ? Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 177, 176, 176),
                                highlightColor:
                                    Color.fromARGB(255, 116, 114, 114),
                                child: Container(
                                    width: 200,
                                    height: 25,
                                    // margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              // shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, i) {
                                return ShimmerStoreCard();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // height: 800,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: hashMap.length,
                        itemBuilder: (context, i) {
                          return StoreList(hashMap.keys.elementAt(i)!,
                              hashMap.values.elementAt(i));
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Container StoreList(String title, List<Message> data) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
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
          isLoading
              ? SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, i) {
                      return ShimmerStoreCard();
                    },
                  ),
                )
              : SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StoreViewPage(
                                    data: data[i],
                                  );
                                  // return LandingDrawerView();
                                },
                              ),
                            );
                          }),
                          child: DealCard(data[i].imageUrl!, data[i].name!,
                              data[i].address!));
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Padding DealCard(String image, String name, String address) {
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
                          address,
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
