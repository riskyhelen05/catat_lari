import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/session.dart';
import '../../viewmodels/run_viewmodel.dart';

class AddRunScreen extends StatefulWidget {

  const AddRunScreen({super.key});

  @override
  State<AddRunScreen> createState() =>
      _AddRunScreenState();
}

class _AddRunScreenState
    extends State<AddRunScreen> {

  final _formKey = GlobalKey<FormState>();

  final distanceController =
      TextEditingController();

  final noteController =
      TextEditingController();

  DateTime selectedDate =
      DateTime.now();

  TimeOfDay selectedTime =
      TimeOfDay.now();

  // 🔥 DATE PICKER
  Future<void> pickDate(
      BuildContext context) async {

    final picked = await showDatePicker(

      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2020),

      lastDate: DateTime.now(),
    );

    if (picked != null) {

      setState(() {
        selectedDate = picked;
      });
    }
  }

  // 🔥 TIME PICKER
  Future<void> pickTime(
      BuildContext context) async {

    final picked = await showTimePicker(

      context: context,

      initialTime: selectedTime,
    );

    if (picked != null) {

      setState(() {
        selectedTime = picked;
      });
    }
  }

  // 🔥 FORMAT DURASI
  String formatDuration(
      TimeOfDay time) {

    final h =
        time.hour.toString().padLeft(2, '0');

    final m =
        time.minute.toString().padLeft(2, '0');

    return "$h:$m menit";
  }

  // 🔥 SAVE RUN
  void saveRun() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final runVM =
        Provider.of<RunViewModel>(
      context,
      listen: false,
    );

    await runVM.addRun(

      userId: Session.userId!,

      distance: double.parse(
        distanceController.text,
      ),

      duration:
          formatDuration(selectedTime),

      note: noteController.text,

      date: selectedDate.toString(),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tambah Lari"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              // 🔥 DISTANCE
              TextFormField(

                controller:
                    distanceController,

                keyboardType:
                    TextInputType.number,

                decoration: InputDecoration(

                  labelText:
                      "Jarak (km)",

                  prefixIcon:
                      const Icon(
                    Icons.route,
                  ),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                ),

                validator: (v) =>
                    v == null || v.isEmpty
                        ? "Wajib diisi"
                        : null,
              ),

              const SizedBox(height: 18),

              // 🔥 DURASI
              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  border: Border.all(
                    color:
                        Colors.grey.shade400,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Text(

                      "⏱ ${formatDuration(selectedTime)}",

                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    ElevatedButton(

                      onPressed: () =>
                          pickTime(context),

                      child: const Text(
                        "Pilih",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 🔥 DATE
              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  border: Border.all(
                    color:
                        Colors.grey.shade400,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Text(

                      "📅 ${selectedDate.toLocal().toString().split(' ')[0]}",

                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    ElevatedButton(

                      onPressed: () =>
                          pickDate(context),

                      child: const Text(
                        "Pilih",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 🔥 NOTE
              TextFormField(

                controller:
                    noteController,

                maxLines: 3,

                decoration: InputDecoration(

                  labelText:
                      "Catatan",

                  prefixIcon:
                      const Icon(
                    Icons.notes,
                  ),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔥 BUTTON
              SizedBox(

                width: double.infinity,

                child:
                    ElevatedButton.icon(

                  onPressed: saveRun,

                  icon: const Icon(
                    Icons.save,
                  ),

                  label: const Text(
                    "Simpan Aktivitas",
                  ),

                  style:
                      ElevatedButton.styleFrom(

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}