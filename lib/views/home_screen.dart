import 'dart:async';

import 'package:covidtracker/Model/worldstate.dart';
import 'package:covidtracker/Services/fetchworldstate.dart';
import 'package:covidtracker/components/reusable_row.dart';
import 'package:covidtracker/views/countries_list.dart';
import 'package:covidtracker/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animation =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat();

  List<Color> colorlist = [Colors.blue, Colors.green, Colors.red];

  final WorldStates _states = WorldStates();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animation.dispose();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.of(context).pop(const SplashScreen());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: FutureBuilder(
          future: _states.fetchdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitFadingCircle(
                  // commented properties are for wavespinner
                  // trackColor: Colors.white.withOpacity(0.2),
                  // waveColor: Colors.blue,
                  color: Colors.white,
                  // curve: Curves.bounceOut,
                  controller: _animation,
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  PieChart(
                    animationDuration: const Duration(milliseconds: 1200),
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    dataMap: {
                      "Total": double.parse(snapshot.data!.cases.toString()),
                      "Recovered":
                          double.parse(snapshot.data!.recovered.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths.toString())
                    },
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true),
                    colorList: colorlist,
                    chartType: ChartType.ring,
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left,
                        legendTextStyle: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .04,
                        horizontal: 10),
                    child: Card(
                      color: Colors.deepPurple.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(
                                title: 'Total',
                                value: snapshot.data!.cases.toString()),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Active',
                              value: snapshot.data!.active.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Critical',
                              value: snapshot.data!.critical.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Recovered',
                              value: snapshot.data!.recovered.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Deaths',
                              value: snapshot.data!.deaths.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Today Cases',
                              value: snapshot.data!.todayCases.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                              title: 'Today Deaths',
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CountriesListScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff1aa260),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Track Countries",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
