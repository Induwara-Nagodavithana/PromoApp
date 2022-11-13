import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:promo_app/components/rounded_search_field/rounded_search_field_widget.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/deal.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/offers.dart';
import 'package:promo_app/view/login.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class SplineAreaWeightData {
  // SplineAreaData(this.year, this.y1, this.y2);
  // final double year;
  // final double y1;
  // final double y2;
  SplineAreaWeightData(this.y1);
  final double y1;
}

class _HomePageState extends State<HomePage> {
  ChartSeriesController? _chartSeriesController;

  List<SplineAreaWeightData> _chartData = <SplineAreaWeightData>[
    // SplineAreaWeightData(1),
    // SplineAreaWeightData(3),
    // SplineAreaWeightData(5),
    // SplineAreaWeightData(10),
    SplineAreaWeightData(1),
    SplineAreaWeightData(7),
    SplineAreaWeightData(12),
    SplineAreaWeightData(9),
    SplineAreaWeightData(20),
    SplineAreaWeightData(16),
    SplineAreaWeightData(20),
    SplineAreaWeightData(15),
    SplineAreaWeightData(30),
    SplineAreaWeightData(20),
    SplineAreaWeightData(20),
    SplineAreaWeightData(20),
    // SplineAreaWeightData(16),
    // SplineAreaWeightData(12),
    // SplineAreaWeightData(8),
    // SplineAreaWeightData(5),
    // SplineAreaWeightData(3),
    // SplineAreaWeightData(1),
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Message> deals = [];
  String name = '';
  void getDeals() async {
    ///whatever you want to run on page build
    name = await DataStore.shared.getUserName();
    HttpService().getInstance().get('/deals').then((value) async {
      print(value);

      DealModel dealModel = DealModel.fromJson(jsonDecode(value.data));
      print(dealModel.message);

      setState(() {
        deals = dealModel.message!;
        name = name;
      });
      _refreshController.refreshCompleted();
    }).catchError((err) {
      print(err);
      _refreshController.refreshCompleted();

      Fluttertoast.showToast(
          msg: "Cannot Get Deals",
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
      }
    ];
    return SmartRefresher(
      onRefresh: () async {
        _chartSeriesController?.animate();
        getDeals();
        await Future.delayed(Duration(milliseconds: 1000));
        // if failed,use refreshFailed()
        // _chartSeriesController?.updateDataSource(
        //           addedDataIndexes: <int>[_chartData.length -1],
        //           removedDataIndexes: <int>[0],
        //         );
      },
      controller: _refreshController,
      enablePullDown: true,
      // enablePullUp: true,
      header: WaterDropMaterialHeader(
        // offset: 10,
        // distance: 100,
        backgroundColor: Colors.white,
        color: AppTheme.kPrimaryColor,

        // idleIcon: FaIcon(
        //   FontAwesomeIcons.rightFromBracket,
        //   color: Colors.red,
        // ),
        // waterDropColor: AppTheme.kPrimaryColor,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: size.height * 0.5,
                      color: AppTheme.kPrimaryColor),
                  Column(
                    children: [
                      SizedBox(
                        height: 180,
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height - 226,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Hi, ",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Text(
                                            name,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Get our newest and best deals today.",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FloatingActionButton(
                                    heroTag: "btn4",
                                    elevation: 0,
                                    onPressed: () async {
                                      // Add your onPressed code here!
                                      await DataStore.shared.clearAll();

                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: LoginPage(),
                                        withNavBar:
                                            false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.rightFromBracket,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: AppTheme.kPrimaryColor,
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
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 200,
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
                        Center(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            width: size.width,
                            height: 250,
                            // width: size.width * 0.85,
                            decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 58, 38, 156),
                                  Color.fromARGB(255, 79, 89, 230),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              // color: Colors.red[800],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                )
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.all(0),
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                // color: Colors.red[800],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 10, top: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          child: SfCartesianChart(
                                            // enableAxisAnimation: true,
                                            legend: Legend(
                                                isVisible: false, opacity: 0.7),
                                            // title: ChartTitle(text: 'Inflation rate'),

                                            plotAreaBorderWidth: 0,
                                            primaryXAxis: NumericAxis(
                                                isVisible: false,
                                                maximumLabels: 5,
                                                interval: 1,
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 0),
                                                edgeLabelPlacement:
                                                    EdgeLabelPlacement.shift),
                                            primaryYAxis: NumericAxis(
                                                isVisible: false,
                                                labelFormat: '{value}%',
                                                axisLine:
                                                    const AxisLine(width: 0),
                                                majorTickLines:
                                                    const MajorTickLines(
                                                        size: 0)),
                                            series: <ChartSeries>[
                                              SplineAreaSeries<
                                                  SplineAreaWeightData, double>(
                                                animationDuration: 2000,
                                                // animationDelay: 10,
                                                markerSettings: MarkerSettings(
                                                    isVisible: true,
                                                    borderColor: Colors.white,
                                                    height: 4,
                                                    width: 4),
                                                // gradient: LinearGradient(
                                                //   colors: <Color>[
                                                //     Colors.white.withAlpha(100),
                                                //     Colors.white.withAlpha(10),
                                                //   ],
                                                //   begin: Alignment.topCenter,
                                                //   end: Alignment.bottomCenter,
                                                // ),
                                                onRendererCreated:
                                                    (ChartSeriesController
                                                        controller) {
                                                  _chartSeriesController =
                                                      controller;
                                                },
                                                enableTooltip: true,
                                                dataSource: _chartData,
                                                borderColor: Colors.white,
                                                splineType: SplineType.natural,
                                                color: Colors.transparent,
                                                borderWidth: 3,
                                                name: 'Weight',
                                                xValueMapper:
                                                    (SplineAreaWeightData sales,
                                                            index) =>
                                                        index.toDouble(),
                                                yValueMapper:
                                                    (SplineAreaWeightData sales,
                                                            _) =>
                                                        sales.y1 - 45,
                                              )
                                            ],
                                            tooltipBehavior:
                                                TooltipBehavior(enable: false),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Deals',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  '45',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Subscriptions',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  '241k',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   height: 60,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Offers",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return OfferPage(
                                          data: deals,
                                        );
                                      },
                                    ),
                                  );
                                  // _chartSeriesController?.animate();
                                },
                                child: Text(
                                  "Show All",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 90, 90, 90),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            itemCount: deals.length > 5 ? 5 : deals.length,
                            itemBuilder: (context, i) {
                              return DealCard(
                                  deals[i].store!.imageUrl!,
                                  deals[i].store!.name!,
                                  deals[i].description!,
                                  deals[i].price!,
                                  deals[i].offerCount!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding DealCard(String image, String name, String description, String price,
      String offers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // margin: EdgeInsets.all(10.0),
              width: 300,
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
