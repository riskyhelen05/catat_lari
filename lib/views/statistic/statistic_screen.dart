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

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Statistik"),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: getRuns(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          // 🔥 EMPTY STATE
          if (data.isEmpty) {

            return Center(

              child: Padding(

                padding: const EdgeInsets.all(24),

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.bar_chart,
                      size: 90,
                      color: Colors.grey.shade400,
                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "Belum Ada Statistik",

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      "Mulai catat aktivitas larimu\nuntuk melihat perkembangan.",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          List<FlSpot> spots = [];

          double totalDistance = 0;

          for (int i = 0; i < data.length; i++) {

            final distance =
                double.parse(
                  data[i]['distance'].toString(),
                );

            totalDistance += distance;

            spots.add(
              FlSpot(i.toDouble(), distance),
            );
          }

          final averageDistance =
              totalDistance / data.length;

          return SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // 🔥 HEADER
                const Text(

                  "Progress Larimu 📈",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(

                  "Pantau perkembangan aktivitas lari kamu",

                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 24),

                // 🔥 SUMMARY CARD
                Container(

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    gradient: const LinearGradient(

                      colors: [
                        Color(0xFF2196F3),
                        Color(0xFF4CAF50),
                      ],

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius:
                        BorderRadius.circular(28),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,

                    children: [

                      // TOTAL RUN
                      Column(

                        children: [

                          const Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: 30,
                          ),

                          const SizedBox(height: 10),

                          Text(

                            "${data.length}",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(

                            "Total Run",

                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: 1,
                        height: 80,
                        color: Colors.white24,
                      ),

                      // TOTAL DISTANCE
                      Column(

                        children: [

                          const Icon(
                            Icons.route,
                            color: Colors.white,
                            size: 30,
                          ),

                          const SizedBox(height: 10),

                          Text(

                            "${totalDistance.toStringAsFixed(1)} km",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(

                            "Distance",

                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔥 AVERAGE CARD
                Container(

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    color: isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,

                    borderRadius:
                        BorderRadius.circular(24),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(

                    children: [

                      Container(

                        padding:
                            const EdgeInsets.all(14),

                        decoration: BoxDecoration(

                          color: Colors.orange
                              .withOpacity(0.15),

                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.insights,
                          color: Colors.orange,
                          size: 32,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(

                              "Rata-rata Jarak",

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(

                              "${averageDistance.toStringAsFixed(1)} km / lari",

                              style: TextStyle(
                                color:
                                    Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // 🔥 CHART TITLE
                const Text(

                  "Grafik Performa",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 CHART CARD
                Container(

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    color: isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,

                    borderRadius:
                        BorderRadius.circular(28),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: SizedBox(

                    height: 300,

                    child: LineChart(

                      LineChartData(

                        minY: 0,

                        gridData: FlGridData(

  show: true,

  getDrawingHorizontalLine: (value) {

    return FlLine(

      color: isDark
          ? Colors.white12
          : Colors.black12,

      strokeWidth: 1,
    );
  },
),

                        borderData:
                            FlBorderData(show: false),

                        titlesData: FlTitlesData(

                          topTitles: AxisTitles(
                            sideTitles:
                                SideTitles(
                              showTitles: false,
                            ),
                          ),

                          rightTitles: AxisTitles(
                            sideTitles:
                                SideTitles(
                              showTitles: false,
                            ),
                          ),

                          leftTitles: AxisTitles(

  sideTitles: SideTitles(

    showTitles: true,

    reservedSize: 40,

    getTitlesWidget: (value, meta) {

      return Text(

        value.toInt().toString(),

        style: TextStyle(

          fontSize: 12,

          color: isDark
              ? Colors.white70
              : Colors.black87,
        ),
      );
    },
  ),
),

                          bottomTitles: AxisTitles(

                            sideTitles:
                                SideTitles(

                              showTitles: true,

                              getTitlesWidget:
                                  (value, meta) {

                                return Padding(

                                  padding:
                                      const EdgeInsets.only(
                                    top: 8,
                                  ),

                                  child: Text(
                                    "${value.toInt() + 1}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Colors.grey.shade600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        lineBarsData: [

                          LineChartBarData(

                            spots: spots,

                            isCurved: true,

                            barWidth: 5,

                            color: Colors.green,

                            dotData: FlDotData(
                              show: true,
                            ),

                            belowBarData:
                                BarAreaData(

                              show: true,

                              color: Colors.green
                                  .withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // 🔥 MOTIVATION
                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(

                    color: Colors.green
                        .withOpacity(0.12),

                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: Column(

                    children: [

                      const Icon(
                        Icons.favorite,
                        color: Colors.green,
                        size: 34,
                      ),

                      const SizedBox(height: 12),

                      const Text(

                        "Tetap Konsisten 💪",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(

                        "Konsistensi kecil setiap hari menghasilkan perubahan besar.",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}