import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedType = 'รายรับ';
  DateTime _selectedDate = DateTime.now();

  // ฟังก์ชันบันทึกข้อมูลไปยัง Firestore
  void _saveData() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกจำนวนเงินที่ถูกต้อง')),
      );
      return;
    }

    final userId = 'user_id';  // จำเป็นต้องใช้ userId จาก Firebase Authentication

    FirebaseFirestore.instance.collection('expenses').add({
      'amount': amount,
      'type': _selectedType,
      'note': _noteController.text,
      'date': _selectedDate,
      'userId': userId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อยแล้ว')),
    );

    _amountController.clear();
    _noteController.clear();
  }

  // ฟังก์ชันสำหรับเลือกวันที่
  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('บันทึกรายรับรายจ่าย'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // แสดงฟิลด์สำหรับจำนวนเงิน
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงิน',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              const SizedBox(height: 20),

              // แสดง dropdown สำหรับเลือกประเภท
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ประเภท:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedType,
                    items: const [
                      DropdownMenuItem(value: 'รายรับ', child: Text('รายรับ')),
                      DropdownMenuItem(value: 'รายจ่าย', child: Text('รายจ่าย')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // แสดงการเลือกวันที่
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'วันที่:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ฟิลด์สำหรับบันทึกโน้ต
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'โน้ต',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              const SizedBox(height: 30),

              // ปุ่มบันทึกข้อมูล
              ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // ปุ่มไปที่ Dashboard
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.dashboard, color: Colors.white),
                label: const Text(
                  'ไปที่ Dashboard',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
