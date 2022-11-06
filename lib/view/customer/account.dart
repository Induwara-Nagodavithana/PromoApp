import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:promo_app/view/customer/profile.dart';
import 'package:promo_app/view/customer/subscription.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    // TabController _tabController =
    //     TabController(vsync: this, length: 3);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Account",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            backgroundColor: AppTheme.kPrimaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Subscription',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [Profile(), SubscriptionPage()],
              ),
            ],
          )),
    );
  }
}
