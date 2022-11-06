import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:promo_app/theme/theme.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
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
                        onPressed: () {
                          // onConfirm();
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

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      // color: Color.fromARGB(255, 245, 245, 245),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.2),
                      //     blurRadius: 5.0, // soften the shadow
                      //     spreadRadius: 1.0, //extend the shadow
                      //   )
                      // ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                          height: 50,
                          width: 50,
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
                  ),
                  title: Text(
                    "Arpico-Galle",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        // Add your onPressed code here!
                        _showMyDialog();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.circleXmark,
                        color: Colors.red,
                      ),
                      backgroundColor: Colors.white),
                  subtitle: Text(
                    "Store",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 107, 107, 107),
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  selected: true,
                  onTap: () {
                    // setState(() {
                    //   txt = 'List Tile pressed';
                    // });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
