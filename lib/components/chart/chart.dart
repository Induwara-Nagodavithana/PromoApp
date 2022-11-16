import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promo_app/view/owner/home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  final ChartSeriesController? chartController;
  final Function chartControllerSetter;
  const Chart({super.key, required this.chartController, required this.chartControllerSetter});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
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
                                                  widget.chartControllerSetter(controller);
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
                        );
  }
}