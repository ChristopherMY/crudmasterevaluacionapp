import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/home/home_bloc.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatelessWidget {
  const Index._({Key? key}) : super(key: key);

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(
        //  localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (context, child) => const Index._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(builder: (context, provider, child) {
      return MaterialApp(
        title: 'Empleados CRUD Evaluacion',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      );
    });
    ;
  }
}
