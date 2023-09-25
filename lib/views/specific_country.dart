import 'package:covidtracker/components/reusable_row.dart';
import 'package:flutter/material.dart';

class SpecificCountry extends StatelessWidget {
  final String image, name;
  final int cases, death, recovered, active, critical, todayrec, test;
  SpecificCountry(
      {super.key,
      required this.image,
      required this.name,
      required this.cases,
      required this.death,
      required this.recovered,
      required this.active,
      required this.critical,
      required this.todayrec,
      required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.2),
        title: Text(name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: Colors.deepPurple.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          ReusableRow(
                              title: 'Total Cases', value: cases.toString()),
                          ReusableRow(
                              title: 'Active', value: active.toString()),
                          ReusableRow(
                              title: 'Recovered', value: recovered.toString()),
                          ReusableRow(title: 'Deaths', value: death.toString()),
                          ReusableRow(
                              title: 'Critical', value: critical.toString()),
                          ReusableRow(
                              title: 'Today Recovered',
                              value: todayrec.toString()),
                          ReusableRow(
                              title: 'Tests Done', value: test.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
