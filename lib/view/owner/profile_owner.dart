import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/profile.dart';

class ProfileOwnerPage extends StatefulWidget {
  const ProfileOwnerPage({super.key});

  @override
  State<ProfileOwnerPage> createState() => _ProfileOwnerPageState();
}

class _ProfileOwnerPageState extends State<ProfileOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
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
        body: Profile());
  }
}
