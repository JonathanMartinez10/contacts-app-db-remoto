import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/contact.dart';

void sendData(Contact contact) async {
  // URL del archivo PHP en el servidor que recibirá los datos
  const url =
      'https://thegreatestsports.000webhostapp.com/Apps/contacts_app/insert.php';

  try {
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'name': contact.name,
      'lastname': contact.lastname,
      'maternalsurname': contact.maternalsurname,
      'number': contact.number.toString(),
      'gender': contact.gender,
      'civilstatus': contact.civilstatus,
    });

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes realizar acciones adicionales si es necesario
      // ignore: avoid_print
      print('Datos enviados correctamente');
    } else {
      // La solicitud no fue exitosa, maneja el error apropiadamente
      // ignore: avoid_print
      print('Error al enviar los datos: ${response.statusCode}');
    }
  } catch (e) {
    // Ocurrió un error durante la solicitud
    // ignore: avoid_print
    print('Error de conexión: $e');
  }
}

Future<List<Contact>> getAllContacts() async {
  // URL del archivo PHP en el servidor que obtiene todos los registros
  const url =
      'https://thegreatestsports.000webhostapp.com/Apps/contacts_app/get_all.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, procesa la respuesta
      final List<dynamic> data = jsonDecode(response.body);

      List<Contact> contacts = data.map((json) {
        final id = json['id'] != null ? int.parse(json['id']) : null;
        return Contact(
          id: id,
          name: json['name'],
          lastname: json['lastname'],
          maternalsurname: json['maternalsurname'],
          number: json['number'],
          gender: json['gender'],
          civilstatus: json['civilstatus'],
        );
      }).toList();

      return contacts;
    } else {
      // La solicitud no fue exitosa, maneja el error apropiadamente
      throw Exception('Error al obtener los registros: ${response.statusCode}');
    }
  } catch (e) {
    // Ocurrió un error durante la solicitud
    throw Exception('Error de conexión: $e');
  }
}

Future<void> updateContact(Contact contact) async {
  //URL del archivo PHP en el servidor que actualiza el registro
  const url =
      'https://thegreatestsports.000webhostapp.com/Apps/contacts_app/update.php';
  try {
    final response = await http.post(Uri.parse(url), body: {
      'id': contact.id.toString(),
      'name': contact.name,
      'lastname': contact.lastname,
      'maternalsurname': contact.maternalsurname,
      'number': contact.number.toString(),
      'gender': contact.gender,
      'civilstatus': contact.civilstatus,
    });

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes realizar acciones adicionales si es necesario
      // ignore: avoid_print
      print('Registro actualizado correctamente');
    } else {
      // La solicitud no fue exitosa, maneja el error apropiadamente
      // ignore: avoid_print
      print('Error al actualizar el registro: ${response.statusCode}');
    }
  } catch (e) {
    // Ocurrió un error durante la solicitud
    // ignore: avoid_print
    print('Error de conexión: $e');
  }
}

Future<void> deleteContact(int id) async {
  // URL del archivo PHP en el servidor que maneja la eliminación del registro
  const url =
      'https://thegreatestsports.000webhostapp.com/Apps/contacts_app/delete.php';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes realizar acciones adicionales si es necesario
      // ignore: avoid_print
      print('Registro eliminado correctamente');
    } else {
      // La solicitud no fue exitosa, maneja el error apropiadamente
      throw Exception('Error al eliminar el registro: ${response.statusCode}');
    }
  } catch (e) {
    // Ocurrió un error durante la solicitud
    throw Exception('Error de conexión: $e');
  }
}
