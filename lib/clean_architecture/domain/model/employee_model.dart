// To parse this JSON data, do
//
//     final employee = employeeFromMap(jsonString);

import 'dart:convert';

Employee employeeFromMap(String str) => Employee.fromMap(json.decode(str));

String employeeToMap(Employee data) => json.encode(data.toMap());

class Employee {
  Employee({
    this.idEmpleado,
    this.nombre,
    this.apellido,
    this.edad,
    this.fechaNacimiento,
    this.fechaIngreso,
    this.fechaTerminoContrato,
    this.flgEstd,
  });

  final String? idEmpleado;
  final String? nombre;
  final String? apellido;
  final String? edad;
  final DateTime? fechaNacimiento;
  final DateTime? fechaIngreso;
  final DateTime? fechaTerminoContrato;
  final String? flgEstd;

  Employee copyWith({
    String? idEmpleado,
    String? nombre,
    String? apellido,
    String? edad,
    DateTime? fechaNacimiento,
    DateTime? fechaIngreso,
    DateTime? fechaTerminoContrato,
    String? flgEstd,
  }) =>
      Employee(
        idEmpleado: idEmpleado ?? this.idEmpleado,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        edad: edad ?? this.edad,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaTerminoContrato: fechaTerminoContrato ?? this.fechaTerminoContrato,
        flgEstd: flgEstd ?? this.flgEstd,
      );

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
    idEmpleado: json["id_empleado"] == null ? null : json["id_empleado"],
    nombre: json["nombre"] == null ? null : json["nombre"],
    apellido: json["apellido"] == null ? null : json["apellido"],
    edad: json["edad"] == null ? null : json["edad"],
    fechaNacimiento: json["fecha_nacimiento"] == null ? null : DateTime.parse(json["fecha_nacimiento"]),
    fechaIngreso: json["fecha_ingreso"] == null ? null : DateTime.parse(json["fecha_ingreso"]),
    fechaTerminoContrato: json["fecha_termino_contrato"] == null ? null : DateTime.parse(json["fecha_termino_contrato"]),
    flgEstd: json["flg_estd"] == null ? null : json["flg_estd"],
  );

  Map<String, dynamic> toMap() => {
    "id_empleado": idEmpleado == null ? null : idEmpleado,
    "nombre": nombre == null ? null : nombre,
    "apellido": apellido == null ? null : apellido,
    "edad": edad == null ? null : edad,
    "fecha_nacimiento": fechaNacimiento == null ? null : "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
    "fecha_ingreso": fechaIngreso == null ? null : "${fechaIngreso!.year.toString().padLeft(4, '0')}-${fechaIngreso!.month.toString().padLeft(2, '0')}-${fechaIngreso!.day.toString().padLeft(2, '0')}",
    "fecha_termino_contrato": fechaTerminoContrato == null ? null : "${fechaTerminoContrato!.year.toString().padLeft(4, '0')}-${fechaTerminoContrato!.month.toString().padLeft(2, '0')}-${fechaTerminoContrato!.day.toString().padLeft(2, '0')}",
    "flg_estd": flgEstd == null ? null : flgEstd,
  };
}
