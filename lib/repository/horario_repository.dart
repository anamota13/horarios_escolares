import '../db/database_helper.dart';
import '../models/horario.dart';
import '../services/horario_service.dart';

class HorarioRepository {
  final HorarioService _apiService = HorarioService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;


  bool usarLocal = false; 

  Future<List<Horario>> obterTodos() async {
    if (usarLocal) {
      final dadosLocais = await _dbHelper.queryAll();
      return dadosLocais.map((e) => Horario.fromMap(e)).toList();
    } else {
      return await _apiService.buscarTodos();
    }
  }

  Future<void> adicionar(Horario horario) async {
    if (usarLocal) {
      await _dbHelper.insert(horario.toMap());
    } else {
      await _apiService.criar(horario);
    }
  }

  Future<void> editar(Horario horario) async {
    if (usarLocal) {
      await _dbHelper.update(horario.toMap());
    } else {
      await _apiService.atualizar(horario);
    }
  }

  Future<void> excluir(int id) async {
    if (usarLocal) {
      await _dbHelper.delete(id);
    } else {
      await _apiService.deletar(id);
    }
  }
}