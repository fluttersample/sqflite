import 'package:flutter/material.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';
import 'package:phone_book/screens/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.black
          )
        )
      ),
      home: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc()..add(LoadFromDb()),
        child: const HomeSc(),
      ),
    );
  }
}
