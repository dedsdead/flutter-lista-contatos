import 'package:flutter/material.dart';
import 'package:formulario_contatos/form_contact.dart';
import 'package:formulario_contatos/model/user.dart';
import 'package:formulario_contatos/routes/routes.dart';
import 'package:formulario_contatos/search_contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_contact.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<UserModel>('users');

  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            shadow: Colors.black,
            primary: Colors.white,
            secondary: Colors.white),
      ),
      routes: {
        Routes.home: (context) => const HomeContact(),
        Routes.form: (context) => FormContact(),
        Routes.search: (context) => const SearchContact(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
