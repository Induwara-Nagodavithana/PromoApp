import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/components/rectangle_text_field/rectangle_text_field.dart';
import 'package:promo_app/helpers/data_store.dart';
import 'package:promo_app/httpService/httpService.dart';
import 'package:promo_app/model/deal.dart';
import 'package:promo_app/theme/theme.dart';

class AddDealsPage extends StatefulWidget {
  final Message? data;
  const AddDealsPage({
    Key? key,
    this.data, // nullable and optional
  }) : super(key: key);

  @override
  State<AddDealsPage> createState() => _AddDealsPageState();
}

class _AddDealsPageState extends State<AddDealsPage> {
  String description = '';
  String price = '';
  String offercount = '';

  Future<void> addDeals() async {
    // _refreshController.refreshToIdle();
    String storeId = await DataStore.shared.getStoreId();

    ///whatever you want to run on page build

    HttpService().getInstance().post('/deals', data: {
      "description": description,
      "price": price,
      "offerCount": offercount,
      "store": storeId
    }).then((value) async {
      print(value);
      ;
      Fluttertoast.showToast(
          msg: "Deal Added",
          backgroundColor: Color.fromARGB(255, 46, 125, 50),
          textColor: Colors.white,
          fontSize: 15.0);
      Navigator.pop(context);
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Add Deal",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  Future<void> saveDeals(String dealId) async {
    // _refreshController.refreshToIdle();
    String storeId = await DataStore.shared.getStoreId();

    ///whatever you want to run on page build

    HttpService().getInstance().put('/deals/$dealId', data: {
      "description": description,
      "price": price,
      "offerCount": offercount,
      "store": storeId
    }).then((value) async {
      print(value);
      Fluttertoast.showToast(
          msg: "Deal Saved",
          backgroundColor: Color.fromARGB(255, 46, 125, 50),
          textColor: Colors.white,
          fontSize: 15.0);
      Navigator.pop(context);
    }).catchError((err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot Save Deal",
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          textColor: Colors.white,
          fontSize: 15.0);
    });
    // ....
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        description = widget.data!.description!;
        price = widget.data!.price!;
        offercount = widget.data!.offerCount!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Offers",
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
                    labelText: "Expire Date",
                    hintText: "Enter expire date of the deal",
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
                  onPressed: () {
                    if (widget.data != null) {
                      saveDeals(widget.data!.sId!);
                    } else {
                      addDeals();
                    }
                  },
                  child: Text(
                    'Save',
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
