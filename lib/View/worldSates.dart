import 'package:covid19_tracker/Services/utilities/statesServices.dart';
import 'package:covid19_tracker/View/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Models/worldStatesModel.dart';

class worldStates extends StatefulWidget {
  const worldStates({super.key});

  @override
  State<worldStates> createState() => _worldStatesState();
}

class _worldStatesState extends State<worldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    statesService StatesService = statesService();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          FutureBuilder(
              future: StatesService.fetchWorldStates(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Card(
                          child: Column(
                            children: [
                              reusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              reusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              reusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              reusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              reusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              reusableRow(
                                  title: 'Tests',
                                  value: snapshot.data!.tests.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => countriesList()));
                        },
                        child: Container(
                          height: 50,
                          width: 355,
                          decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text("Track Countries")),
                        ),
                      )
                    ],
                  );
                }
              }),
        ],
      )),
    );
  }
}

class reusableRow extends StatefulWidget {
  String title, value;
  reusableRow({super.key, required this.title, required this.value});

  @override
  State<reusableRow> createState() => _reusableRowState();
}

class _reusableRowState extends State<reusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Text(widget.value),
              ],
            ),
          )
        ],
      ),
    );
  }
}
