import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // นำเข้า Firestore
import 'package:flutter_6_9/screen/expense_dashboard.dart';
import 'package:flutter_6_9/screen/expense_form.dart';
import 'package:flutter_6_9/screen/signin_screen.dart';
import 'package:flutter_6_9/firebase_options.dart';
import 'package:flutter_6_9/screen/signup_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/signup',  // กำหนดหน้าแรกเป็นหน้า Signin
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninScreen(),
        '/expenseForm': (context) => const ExpenseForm(),
        '/dashboard': (context) => const ExpenseDashboard(), // เส้นทางไปยังหน้า Dashboard
      },
    );
  }
}
