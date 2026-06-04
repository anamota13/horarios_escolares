import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/horario.dart';

class HorarioService {
  final String baseUrl = "https://horarios-api-1.onrender.com/horarios";

  Future<List<Horario>> buscarTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((h) => Horario.fromMap(h)).toList();
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      throw Exception('Falha na conexão com a API: $e');
    }
  }

  Future<void> criar(Horario horario) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(horario.toMap()),
    );
  }

  Future<void> atualizar(Horario horario) async {
    await http.put(
      Uri.parse('$baseUrl/${horario.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(horario.toMap()),
    );
  }

  Future<void> deletar(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}