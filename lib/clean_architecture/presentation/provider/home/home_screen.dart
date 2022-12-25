import 'package:crudmasterevaluacion/clean_architecture/helper/size_config.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/employee_screen.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homeBloc = context.read<HomeBloc>();
      homeBloc.loadEmployees(context);
    });
    super.initState();
  }

  void _openMaintenance() async {
    final homeBloc = context.read<HomeBloc>();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EmployeeScreen.init(context, false, "1");
      },
    ));

    homeBloc.loadEmployees(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.watch<HomeBloc>();
    SizeConfig().init(context);
    return LoaderOverlay(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("MAIN"),
        // ),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Lista de Empleados"),
              centerTitle: false,
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: homeBloc.employees.length,
                (context, index) {
                  final employee = homeBloc.employees[index];
                  final admissionDate =
                      "${employee.fechaIngreso!.day}/${employee.fechaIngreso!.month}/${employee.fechaIngreso!.year}";
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nombre: ${employee.nombre}"),
                        Text("Apellido: ${employee.apellido}"),
                        Text("Edad: ${employee.edad}"),
                        Text("Fecha de Ingreso: $admissionDate"),
                      ],
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return EmployeeScreen.init(
                              context, true, employee.idEmpleado.toString());
                        },
                      ));
                      homeBloc.loadEmployees(context);
                    },
                    isThreeLine: false,
                    leading: const Icon(
                      Icons.supervised_user_circle_sharp,
                      size: 48,
                    ),
                    trailing: GestureDetector(
                      onTap: () => homeBloc.deleteEmployed(
                        context,
                        employedId: employee.idEmpleado.toString(),
                      ),
                      child: const Icon(
                        Icons.restore_from_trash,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
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
          onPressed: _openMaintenance,
          tooltip: 'Nuevo Empleado',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
