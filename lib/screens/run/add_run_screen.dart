import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../database/session.dart';

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

  final durationController =
      TextEditingController();

  final noteController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

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

  void saveRun() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final db = DBHelper();

    await db.insertRun({

      'userId': Session.userId,

      'distance': double.parse(
        distanceController.text,
      ),

      // 🔥 SIMPAN MENIT SAJA
      'duration': int.parse(
        durationController.text,
      ),

      'note': noteController.text,

      'date': selectedDate.toString(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tambah Lari"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(

                controller: distanceController,

                keyboardType:
                    TextInputType.number,

                decoration: InputDecoration(

                  labelText: "Jarak (km)",

                  prefixIcon:
                      const Icon(Icons.route),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                validator: (v) =>
                    v == null || v.isEmpty
                        ? "Wajib diisi"
                        : null,
              ),

              const SizedBox(height: 18),

              TextFormField(

                controller: durationController,

                keyboardType:
                    TextInputType.number,

                decoration: InputDecoration(

                  labelText:
                      "Durasi (menit)",

                  hintText:
                      "Contoh: 45",

                  prefixIcon:
                      const Icon(Icons.timer),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                validator: (v) =>
                    v == null || v.isEmpty
                        ? "Wajib diisi"
                        : null,
              ),

              const SizedBox(height: 18),

              Container(

                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Text(

                      "📅 ${selectedDate.toLocal().toString().split(' ')[0]}",

                      style: const TextStyle(
                        fontSize: 16,
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

              TextFormField(

                controller: noteController,

                maxLines: 3,

                decoration: InputDecoration(

                  labelText: "Catatan",

                  prefixIcon:
                      const Icon(Icons.notes),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  onPressed: saveRun,

                  icon: const Icon(Icons.save),

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