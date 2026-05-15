import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/run_viewmodel.dart';

class EditRunScreen extends StatefulWidget {

  final Map<String, dynamic> run;

  const EditRunScreen({
    super.key,
    required this.run,
  });

  @override
  State<EditRunScreen> createState() =>
      _EditRunScreenState();
}

class _EditRunScreenState
    extends State<EditRunScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController distanceController;
  late TextEditingController durationController;
  late TextEditingController noteController;

  DateTime selectedDate =
      DateTime.now();

  @override
  void initState() {

    super.initState();

    distanceController =
        TextEditingController(
      text:
          widget.run['distance'].toString(),
    );

    durationController =
        TextEditingController(
      text:
          widget.run['duration'].toString(),
    );

    noteController =
        TextEditingController(
      text: widget.run['note'] ?? "",
    );

    selectedDate = DateTime.parse(
      widget.run['date'],
    );
  }

  // 🔥 DATE PICKER
  Future<void> pickDate() async {

    final picked =
        await showDatePicker(

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

  // 🔥 UPDATE RUN
  void updateRun() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final runVM =
        Provider.of<RunViewModel>(
      context,
      listen: false,
    );

    await runVM.updateRun(

      id: widget.run['id'],

      distance: double.parse(
        distanceController.text,
      ),

      duration:
          durationController.text,

      note: noteController.text,

      date: selectedDate.toString(),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Edit Aktivitas"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

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

                decoration:
                    InputDecoration(

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
                      18,
                    ),
                  ),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Jarak wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(
                  height: 20),

              // 🔥 DURATION
              TextFormField(

                controller:
                    durationController,

                decoration:
                    InputDecoration(

                  labelText:
                      "Durasi",

                  hintText:
                      "Contoh: 45 menit",

                  prefixIcon:
                      const Icon(
                    Icons.timer,
                  ),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Durasi wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(
                  height: 20),

              // 🔥 DATE
              Card(

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: ListTile(

                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.green,
                  ),

                  title:
                      const Text("Tanggal"),

                  subtitle: Text(

                    selectedDate
                        .toLocal()
                        .toString()
                        .split(' ')[0],

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  trailing:
                      ElevatedButton(

                    onPressed: pickDate,

                    child:
                        const Text("Pilih"),
                  ),
                ),
              ),

              const SizedBox(
                  height: 20),

              // 🔥 NOTE
              TextFormField(

                controller:
                    noteController,

                maxLines: 4,

                decoration:
                    InputDecoration(

                  labelText:
                      "Catatan",

                  alignLabelWithHint:
                      true,

                  prefixIcon:
                      const Padding(

                    padding:
                        EdgeInsets.only(
                      bottom: 70,
                    ),

                    child:
                        Icon(Icons.notes),
                  ),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  height: 30),

              // 🔥 BUTTON
              SizedBox(

                width: double.infinity,

                child:
                    ElevatedButton.icon(

                  style:
                      ElevatedButton
                          .styleFrom(

                    padding:
                        const EdgeInsets
                            .symmetric(
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

                  onPressed:
                      updateRun,

                  icon: const Icon(
                    Icons.save,
                  ),

                  label: const Text(

                    "Update Aktivitas",

                    style: TextStyle(
                      fontSize: 16,
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