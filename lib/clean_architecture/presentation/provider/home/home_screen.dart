import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initHome() async {
    final homeBloc = context.read<HomeBloc>();
    homeBloc.employees = await homeBloc.getEmployees();
    homeBloc.notifyListeners();
  }

  @override
  void initState() {
    // TODO: implement initState
    initHome();
    super.initState();
  }

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.watch<HomeBloc>();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("MAIN"),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Lista de Empleados"),
            centerTitle: true,
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: homeBloc.employees.length,
              (context, index) {
                final employee = homeBloc.employees[index];
                // final fechaIngreso = DateTime.parse(employee.fechaIngreso!.toString());
                final fechaIngreso = "${employee.fechaIngreso!.day}/${employee.fechaIngreso!.month}/${employee.fechaIngreso!.year}";
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre: ${employee.nombre}"),
                      Text("Apellido: ${employee.apellido}"),
                      Text("Edad: ${employee.edad}"),
                      Text("Fecha de Ingreso: $fechaIngreso"),
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  onTap: () {

                  },
                  isThreeLine: false,
                  leading: Icon(Icons.supervised_user_circle_sharp, size: 48),
                  shape: const Border(
                    bottom: BorderSide(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
