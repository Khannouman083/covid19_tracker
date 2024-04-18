import 'package:covid19_tracker/View/worldSates.dart';
import 'package:flutter/material.dart';

class countryDetails extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
   countryDetails({super.key,
    required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
   });

  @override
  State<countryDetails> createState() => _countryDetailsState();
}

class _countryDetailsState extends State<countryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.067),
                child: Card(
                  child: Column(
                    children: [
                      reusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      reusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      reusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      reusableRow(title: 'Active', value: widget.active.toString()),
                      reusableRow(title: 'Tests', value: widget.test.toString()),
                      reusableRow(title: 'Cases', value: widget.totalCases.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      ),
    );
  }
}
