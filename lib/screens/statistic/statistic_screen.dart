import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../database/session.dart';

class StatisticScreen extends StatefulWidget {

  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() =>
      _StatisticScreenState();
}

class _StatisticScreenState
    extends State<StatisticScreen> {

  Future<List<Map<String, dynamic>>> getRuns() async {

    final db = await DBHelper().database;

    return await db.query(
      'runs',
      where: 'userId = ?',
      whereArgs: [Session.userId],
      orderBy: 'date ASC',
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Statistik Lari"),
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: getRuns(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return Center(
              child: Text("Belum ada data statistik"),
            );
          }

          List<FlSpot> spots = [];

          for (int i = 0; i < data.length; i++) {

            spots.add(

              FlSpot(
                i.toDouble(),
                double.parse(
                  data[i]['distance'].toString(),
                ),
              ),
            );
          }

          return Padding(

            padding: EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "Grafik Jarak Lari",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                Expanded(

                  child: LineChart(

                    LineChartData(

                      gridData: FlGridData(
                        show: true,
                      ),

                      borderData: FlBorderData(
                        show: true,
                      ),

                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                          ),
                        ),
                      ),

                      lineBarsData: [

                        LineChartBarData(

                          spots: spots,

                          isCurved: true,

                          dotData: FlDotData(
                            show: true,
                          ),

                          belowBarData:
                              BarAreaData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}