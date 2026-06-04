import 'package:flutter/material.dart';
import '../../models/horario.dart';
import '../../repository/horario_repository.dart';
import 'formulario.dart';

class ListaHorarios extends StatefulWidget {
  const ListaHorarios({super.key});

  @override
  State<ListaHorarios> createState() => ListaHorariosState();
}

class ListaHorariosState extends State<ListaHorarios> {
  final HorarioRepository _repository = HorarioRepository();
  late Future<List<Horario>> _futureHorarios;

  @override
  void initState() {
    super.initState();
    _carregarHorarios();
  }

  void _carregarHorarios() {
    _futureHorarios = _repository.obterTodos();
  }

  void _atualizarLista() {
    setState(() {
      _carregarHorarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Horários Escolares'),
      ),
      body: FutureBuilder<List<Horario>>(
        future: _futureHorarios, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os horários.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum horário cadastrado.'));
          }

          final horarios = snapshot.data!;

          return ListView.builder(
            itemCount: horarios.length,
            itemBuilder: (context, indice) {
              final horario = horarios[indice];
              return ItemHorario(
                horario,
                onDelete: () => _confirmarExclusao(horario),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioHorario(),
            ),
          ).then((sucesso) {
            if (sucesso == true) {
              _atualizarLista();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarExclusao(Horario horario) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir horário'),
          content: const Text('Tem certeza que deseja excluir este horário?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (horario.id != null) {
                  await _repository.excluir(horario.id!);
                  _atualizarLista(); 
                }
                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}

class ItemHorario extends StatelessWidget {
  final Horario _horario;
  final VoidCallback onDelete;

  const ItemHorario(this._horario, {required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(_horario.disciplina),
        subtitle: Text('${_horario.diaSemana} - ${_horario.hora}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}