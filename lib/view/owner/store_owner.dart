import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';

class StoreOwnerPage extends StatefulWidget {
  const StoreOwnerPage({super.key});

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPageState();
}

class _StoreOwnerPageState extends State<StoreOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Store",
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
        body: Container());
  }
}
