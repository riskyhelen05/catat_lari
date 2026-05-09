import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class EditRunScreen extends StatefulWidget {
  final Map<String, dynamic> run;

  EditRunScreen({required this.run});

  @override
  State<EditRunScreen> createState() => _EditRunScreenState();
}

class _EditRunScreenState extends State<EditRunScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController distanceController;
  late TextEditingController noteController;

  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    distanceController =
        TextEditingController(text: widget.run['distance'].toString());

    noteController =
        TextEditingController(text: widget.run['note'] ?? "");

    selectedDate = DateTime.parse(widget.run['date']);

    // parse "13:05"
    final timeParts = widget.run['duration'].split(":");
    selectedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
  }

  String formatTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  void updateRun() async {
    if (!_formKey.currentState!.validate()) return;

    final db = DBHelper();

    await db.updateRun(widget.run['id'], {
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
      appBar: AppBar(title: Text("Edit Lari")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: distanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Jarak"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Wajib isi" : null,
              ),

              SizedBox(height: 10),

              Text("Durasi: ${formatTime(selectedTime)}"),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null) setState(() => selectedTime = picked);
                },
                child: Text("Pilih Jam"),
              ),

              SizedBox(height: 10),

              Text("Tanggal: ${selectedDate.toLocal().toString().split(' ')[0]}"),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => selectedDate = picked);
                },
                child: Text("Pilih Tanggal"),
              ),

              SizedBox(height: 10),

              TextFormField(
                controller: noteController,
                decoration: InputDecoration(labelText: "Catatan"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: updateRun,
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}