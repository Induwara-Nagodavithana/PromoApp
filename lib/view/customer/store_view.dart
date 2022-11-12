import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/divider/mySeparator.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/store.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:random_color/random_color.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class StoreViewPage extends StatefulWidget {
  final Message data;
  const StoreViewPage({Key? key, required this.data}) : super(key: key);

  @override
  State<StoreViewPage> createState() => _StoreViewPageState();
}

class _StoreViewPageState extends State<StoreViewPage> {
  final Color _color = RandomColor().randomColor(
      colorSaturation: ColorSaturation.mediumSaturation,
      colorBrightness: ColorBrightness.dark,
      colorHue: ColorHue.multiple(
          colorHues: [ColorHue.red, ColorHue.yellow, ColorHue.red]));
  bool isSubed = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void checkSubscriptions() async {
    String userId = await DataStore.shared.getUserId();

    ///whatever you want to run on page build
    HttpService()
        .getInstance()
        .post('/subscriptions/getSubscriptionsByUserAndStore', data: {
      "userId": userId,
      "storeId": widget.data.sId
    }).then((value) async {
      print(value);
      print(value.data);
      print("123456");

      Map<String, dynamic> data = jsonDecode(value.data);
      print("data.keys.contains('message')");
      print(data.keys.contains('message'));
      print(data.keys.contains('error'));
      print(data['message']);
      // print(data['message']['user']);
      print('dfgdfg');
      // print(data['message']['user']);
      _refreshController.refreshCompleted();
      if (data['message'].length < 1) {
        setState(() {
          isSubed = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Already Subscribed",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0);
      }
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Get Subscription",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  Future<void> addSubscriptions(String subId) async {
    print(subId);
    // _refreshController.refreshToIdle();
    String userId = await DataStore.shared.getUserId();

    ///whatever you want to run on page build

    HttpService().getInstance().post('/subscriptions',
        data: {"user": userId, "store": widget.data.sId}).then((value) async {
      print(value);
      await FirebaseMessaging.instance.subscribeToTopic(widget.data.sId!);
      setState(() {
        isSubed = true;
      });
      Fluttertoast.showToast(
          msg: "Subscription Added",
          backgroundColor: Color.fromARGB(255, 46, 125, 50),
          textColor: Colors.white,
          fontSize: 15.0);
      _refreshController.refreshCompleted();
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Delete Subscription",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  @override
  void initState() {
    super.initState();
    checkSubscriptions();
  }

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
        body: SmartRefresher(
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropMaterialHeader(
            backgroundColor: Colors.white,
            color: AppTheme.kPrimaryColor,
          ),
          child: Container(
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
                      // padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 198, 40, 40),
                        color: _color,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ClipOval(
                                  child: CachedNetworkImage(
                                      height: 150,
                                      width: 150,
                                      imageUrl: widget.data.imageUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.store,
                                              color: AppTheme.kPrimaryColor,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Center(
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
                                  widget.data.name!,
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
                                  widget.data.openHours!,
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
                                  widget.data.address!,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                          widget.data.catergory!,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          widget.data.contactNo!,
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
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.centerLeft,
                          //       child: Container(
                          //         width: 10,
                          //         height: 20,
                          //         decoration: const BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.only(
                          //               bottomRight: Radius.circular(10.0),
                          //               topRight: Radius.circular(10.0),
                          //             )),
                          //       ),
                          //     ),
                          //     Align(
                          //       alignment: Alignment.center,
                          //       child: Container(
                          //           width: size.width-113,
                          //           child: MySeparator(
                          //             color: Colors.white,
                          //             height: 3,
                          //           )),
                          //     ),
                          //     Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Container(
                          //         width: 10,
                          //         height: 20,
                          //         decoration: const BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.only(
                          //               bottomLeft: Radius.circular(10.0),
                          //               topLeft: Radius.circular(10.0),
                          //             )),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 35.0),
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
                isSubed
                    ? SizedBox(
                        height: 1,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.kPrimaryColor,
                          onSurface: Colors.red,
                          minimumSize: Size(200, 40),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          await addSubscriptions(widget.data.sId!);
                        },
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
          ),
        ));
  }
}
