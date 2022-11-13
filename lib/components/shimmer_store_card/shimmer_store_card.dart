import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerStoreCard extends StatefulWidget {
  const ShimmerStoreCard({super.key});

  @override
  State<ShimmerStoreCard> createState() => _ShimmerStoreCardState();
}

class _ShimmerStoreCardState extends State<ShimmerStoreCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          child: Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 177, 176, 176),
            highlightColor: Color.fromARGB(255, 116, 114, 114),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    height: 200,
                    width: 300,
                    imageUrl:
                        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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
                        child: Container(
                            width: 100,
                            height: 15,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            )),
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
                          Container(
                              width: 150,
                              height: 10,
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
