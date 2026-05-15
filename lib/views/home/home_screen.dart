import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/session.dart';

import '../../viewmodels/run_viewmodel.dart';

import '../run/add_run_screen.dart';
import '../run/detail_run_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      Provider.of<RunViewModel>(
        context,
        listen: false,
      ).fetchRuns();
    });
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    final runVM =
        Provider.of<RunViewModel>(context);

    final data = runVM.runs;

    double totalDistance = 0;

    for (var run in data) {

      totalDistance += double.parse(
        run['distance'].toString(),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Catat Lari"),
        centerTitle: true,
      ),

      body: runVM.isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              child: Padding(

                padding: const EdgeInsets.only(
                  bottom: 100,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // 🔥 GREETING
                    Padding(

                      padding:
                          const EdgeInsets.all(20),

                      child: Row(

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundColor:
                                Colors.blue,

                            child: Text(

                              Session.username !=
                                      null
                                  ? Session
                                      .username![0]
                                      .toUpperCase()
                                  : "U",

                              style:
                                  const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(

                                  "Halo, ${Session.username ?? 'User'} 👋",

                                  style:
                                      const TextStyle(
                                    fontSize: 24,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                const Text(

                                  "Siap untuk lari hari ini?",

                                  style: TextStyle(
                                    color:
                                        Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔥 DASHBOARD
                    Container(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      padding:
                          const EdgeInsets.all(22),

                      decoration: BoxDecoration(

                        gradient:
                            const LinearGradient(

                          colors: [
                            Color(0xFF2196F3),
                            Color(0xFF4CAF50),
                          ],

                          begin: Alignment.topLeft,
                          end:
                              Alignment.bottomRight,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),

                        boxShadow: [

                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Row(

                            children: [

                              Container(

                                padding:
                                    const EdgeInsets
                                        .all(14),

                                decoration:
                                    BoxDecoration(

                                  color: Colors.white
                                      .withOpacity(
                                    0.2,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    18,
                                  ),
                                ),

                                child: const Icon(
                                  Icons
                                      .directions_run,
                                  color:
                                      Colors.white,
                                  size: 30,
                                ),
                              ),

                              const SizedBox(
                                width: 14,
                              ),

                              const Expanded(

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(

                                      "Tetap Semangat 💪",

                                      style:
                                          TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 4,
                                    ),

                                    Text(

                                      "Jaga kesehatan dengan rutin berolahraga",

                                      style:
                                          TextStyle(
                                        color: Colors
                                            .white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          Row(

                            children: [

                              Expanded(

                                child: _buildStatCard(
                                  Icons.flag,
                                  "${data.length}",
                                  "Total Run",
                                ),
                              ),

                              const SizedBox(
                                width: 14,
                              ),

                              Expanded(

                                child: _buildStatCard(
                                  Icons.route,
                                  "${totalDistance.toStringAsFixed(1)} km",
                                  "Distance",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 🔥 MOTIVATION
                    Container(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      padding:
                          const EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        color: isDark
                            ? Colors.orange
                                .withOpacity(0.15)
                            : Colors.orange
                                .shade100,

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),

                        border: Border.all(

                          color: isDark
                              ? Colors.orange
                                  .withOpacity(0.4)
                              : Colors.orange
                                  .shade300,
                        ),
                      ),

                      child: Row(

                        children: [

                          const Icon(
                            Icons.favorite,
                            color: Colors.orange,
                            size: 34,
                          ),

                          const SizedBox(width: 14),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Text(

                                  "Hidup Sehat 🌿",

                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(

                                  "Lari rutin membantu menjaga kesehatan tubuh dan pikiran.",

                                  style: TextStyle(

                                    color: isDark
                                        ? Colors
                                            .white70
                                        : Colors
                                            .black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // 🔥 TITLE
                    const Padding(

                      padding:
                          EdgeInsets.symmetric(
                        horizontal: 20,
                      ),

                      child: Text(

                        "Recent Activity",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 🔥 EMPTY STATE
                    if (data.isEmpty)

                      Padding(

                        padding:
                            const EdgeInsets.only(
                          top: 80,
                        ),

                        child: Center(

                          child: Column(

                            children: const [

                              Icon(
                                Icons
                                    .directions_run,
                                size: 80,
                                color: Colors.grey,
                              ),

                              SizedBox(height: 14),

                              Text(

                                "Belum ada data lari",

                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                "Yuk mulai catat aktivitas larimu 🚀",
                                style: TextStyle(
                                  color:
                                      Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // 🔥 LIST ACTIVITY
                    ListView.builder(

                      itemCount:
                          data.length > 3
                              ? 3
                              : data.length,

                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      itemBuilder:
                          (context, index) {

                        final run =
                            data[index];

                        return Card(

                          elevation: 3,

                          margin:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),
                          ),

                          child: InkWell(

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),

                            onTap: () async {

                              final result =
                                  await Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      DetailRunScreen(
                                    run: run,
                                  ),
                                ),
                              );

                              if (result ==
                                  true) {

                                runVM.fetchRuns();
                              }
                            },

                            child: Padding(

                              padding:
                                  const EdgeInsets.all(
                                18,
                              ),

                              child: Row(

                                children: [

                                  Container(

                                    padding:
                                        const EdgeInsets
                                            .all(14),

                                    decoration:
                                        BoxDecoration(

                                      color: Colors
                                          .blue
                                          .withOpacity(
                                        0.12,
                                      ),

                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        18,
                                      ),
                                    ),

                                    child:
                                        const Icon(
                                      Icons
                                          .directions_run,
                                      color:
                                          Colors
                                              .blue,
                                      size: 28,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 16,
                                  ),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(

                                          "${run['distance']} km",

                                          style:
                                              const TextStyle(
                                            fontSize:
                                                18,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 4,
                                        ),

                                        Text(

                                          run['date']
                                              .toString()
                                              .split(
                                                  ' ')[0],

                                          style:
                                              const TextStyle(
                                            color: Colors
                                                .grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Icon(
                                    Icons
                                        .arrow_forward_ios,
                                    size: 18,
                                    color:
                                        Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  AddRunScreen(),
            ),
          ).then((_) {

            runVM.fetchRuns();
          });
        },

        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
  ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(0.2),

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Column(

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(

            value,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(

            label,

            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}