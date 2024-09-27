import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // ใช้สำหรับกราฟ
import 'package:intl/intl.dart'; // ใช้ในการจัดการวันที่

class ExpenseDashboard extends StatefulWidget {
  const ExpenseDashboard({Key? key}) : super(key: key);

  @override
  _ExpenseDashboardState createState() => _ExpenseDashboardState();
}

class _ExpenseDashboardState extends State<ExpenseDashboard> {

  // ฟังก์ชันดึงข้อมูลยอดรวมรายรับรายจ่าย
  Future<Map<String, double>> _getSummary() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('expenses')
        .where('userId', isEqualTo: 'user_id') // ใช้ userId ที่ล็อกอิน
        .snapshots()
        .first;

    double totalIncome = 0;
    double totalExpense = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['type'] == 'รายรับ') {
        totalIncome += data['amount'];
      } else {
        totalExpense += data['amount'];
      }
    }

    return {'รายรับ': totalIncome, 'รายจ่าย': totalExpense};
  }

  // ฟังก์ชันสร้างกราฟวงกลมจากข้อมูล Firestore
  Widget _buildPieChart() {
    return FutureBuilder(
      future: _getSummary(),
      builder: (context, AsyncSnapshot<Map<String, double>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final summary = snapshot.data!;

        // เตรียมข้อมูลสำหรับกราฟวงกลม
        final List<ChartData> chartData = [
          ChartData('รายรับ', summary['รายรับ']!),
          ChartData('รายจ่าย', summary['รายจ่าย']!),
        ];

        return SfCircularChart(
          title: ChartTitle(text: 'กราฟแสดงสัดส่วนรายรับรายจ่าย'),
          legend: Legend(isVisible: true),
          series: <PieSeries<ChartData, String>>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.amount,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันแสดงรายการแยกตามรายรับ/รายจ่าย
  Widget _buildTransactionList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('expenses')
          .where('userId', isEqualTo: 'user_id') // ใช้ userId ที่ล็อกอิน
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final expenses = snapshot.data!.docs;
        List<Widget> incomeItems = [];
        List<Widget> expenseItems = [];

        for (var doc in expenses) {
          final data = doc.data() as Map<String, dynamic>;
          final date = (data['date'] as Timestamp).toDate();
          final formattedDate = DateFormat('dd/MM/yyyy').format(date);
          final amount = data['amount'];

          if (data['type'] == 'รายรับ') {
            incomeItems.add(
              ListTile(
                title: Text('รายรับ: ${amount.toString()} บาท'),
                subtitle: Text('วันที่: $formattedDate'),
              ),
            );
          } else {
            expenseItems.add(
              ListTile(
                title: Text('รายจ่าย: ${amount.toString()} บาท'),
                subtitle: Text('วันที่: $formattedDate'),
              ),
            );
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รายการรายรับ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...incomeItems,
            const SizedBox(height: 10),
            const Text(
              'รายการรายจ่าย',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...expenseItems,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แผงควบคุมค่าใช้จ่าย'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ปุ่มกลับไปหน้า expense_form.dart
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/expenseForm'); // นำทางไปหน้า ExpenseForm
              },
              icon: const Icon(Icons.add),
              label: const Text('บันทึกรายรับรายจ่าย'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // แสดงยอดรวมรายรับ รายจ่าย และยอดคงเหลือ
            FutureBuilder<Map<String, double>>(
              future: _getSummary(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final summary = snapshot.data!;
                final totalIncome = summary['รายรับ'] ?? 0.0;
                final totalExpense = summary['รายจ่าย'] ?? 0.0;
                final balance = totalIncome - totalExpense;

                return Column(
                  children: [
                    Text('รายรับรวม: ${totalIncome.toStringAsFixed(2)} บาท', style: const TextStyle(fontSize: 18)),
                    Text('รายจ่ายรวม: ${totalExpense.toStringAsFixed(2)} บาท', style: const TextStyle(fontSize: 18)),
                    Text('ยอดคงเหลือ: ${balance.toStringAsFixed(2)} บาท', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),

            // แสดงรายการบันทึก
            Expanded(
              child: SingleChildScrollView(
                child: _buildTransactionList(),
              ),
            ),
            const SizedBox(height: 20),

            // สรุปและกราฟวงกลม
            Expanded(
              child: _buildPieChart(),
            ),
          ],
        ),
      ),
    );
  }
}

// คลาสสำหรับข้อมูลกราฟวงกลม
class ChartData {
  ChartData(this.category, this.amount);
  final String category;
  final double amount;
}
