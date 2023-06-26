import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../model/user.dart';

class UsuarioService {
  static const baseUrl = 'http://34.125.126.121:8081/user';
  static const _baseUrls = 'http://localhost:8081/user/list';

  static final client = http.Client();

  Future <List<Usuario>> fetchPersons() async {
    print('Iniciando');
    print(Uri.parse(_baseUrls));
    final response = await client.get(
      Uri.parse('$baseUrl/list'),
      headers: {'Access-Control-Allow-Origin': '*'},
    );
    print(convert.jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = convert.jsonDecode(response.body);
      return jsonData.map((json) => Usuario.fromJson(json)).toList();
    } else {

      throw Exception('Error al listar');

    }
  }

  Future<void> createPerson(Usuario us) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(us.toJson()), // Convertir a JSON utilizando toJson()
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create person' + response.body);
    }
  }

  Future<void> updatePerson(Usuario us) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${us.dni}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(us),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update person');
    }
  }

  Future<void> deletePerson(int dni) async {
    final response = await http.delete(Uri.parse('$baseUrl/persons/$dni'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete person');
    }
  }
}
