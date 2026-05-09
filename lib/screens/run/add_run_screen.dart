import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../database/session.dart';

class AddRunScreen extends StatefulWidget {
  @override
  State<AddRunScreen> createState() => _AddRunScreenState();
}

class _AddRunScreenState extends State<AddRunScreen> {
  final _formKey = GlobalKey<FormState>();

  final distanceController = TextEditingController();
  final noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // DATE PICKER
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // TIME PICKER
  Future<void> pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  String formatTime(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  void saveRun() async {
    if (!_formKey.currentState!.validate()) return;

    final db = DBHelper();

    await db.insertRun({
      'userId': Session.userId,
      'distance': double.parse(distanceController.text),
      'duration': formatTime(selectedTime),
      'note': noteController.text,
      'date': selectedDate.toString(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Lari")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: distanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Jarak (km)"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Wajib diisi" : null,
              ),

              SizedBox(height: 12),

              // TIME PICKER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Durasi: ${formatTime(selectedTime)}"),
                  ElevatedButton(
                    onPressed: () => pickTime(context),
                    child: Text("Pilih"),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // DATE PICKER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tanggal: ${selectedDate.toLocal().toString().split(' ')[0]}",
                  ),
                  ElevatedButton(
                    onPressed: () => pickDate(context),
                    child: Text("Pilih"),
                  ),
                ],
              ),

              SizedBox(height: 12),

              TextFormField(
                controller: noteController,
                decoration: InputDecoration(labelText: "Catatan"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveRun,
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}