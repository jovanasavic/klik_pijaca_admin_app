import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:klik_pijaca_admin_app/providers/admin.dart';
import 'package:klik_pijaca_admin_app/providers/category.dart';
import 'package:klik_pijaca_admin_app/providers/app.dart';
import 'package:klik_pijaca_admin_app/providers/product.dart';
import 'package:klik_pijaca_admin_app/screens/dashboart.dart';
import 'package:klik_pijaca_admin_app/screens/login.dart';
import 'package:klik_pijaca_admin_app/screens/registration.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppProvider()),
      ChangeNotifierProvider.value(value: AdminProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klik pijaca',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AdminProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return RegistrationScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return DashboardScreen();
      default:
        return LoginScreen();
    }
  }
}
