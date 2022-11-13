import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:promo_app/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDealCard extends StatefulWidget {
  final double? width;
  const ShimmerDealCard({
    Key? key,
    this.width, // nullable and optional
  }) : super(key: key);

  @override
  State<ShimmerDealCard> createState() => _ShimmerDealCardState();
}

class _ShimmerDealCardState extends State<ShimmerDealCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                // margin: EdgeInsets.all(10.0),
                width: widget.width ?? 300,
                height: 180,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Shimmer.fromColors(
                  baseColor: Color.fromARGB(255, 177, 176, 176),
                  highlightColor: Color.fromARGB(255, 116, 114, 114),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                                height: 50,
                                width: 50,
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
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 150,
                              height: 15,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 250,
                                height: 15,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                            Container(
                                width: 150,
                                height: 15,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ],
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
                            Container(
                                width: 80,
                                height: 15,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                            Container(
                                width: 80,
                                height: 15,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
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
