import 'package:flutter/material.dart';
import '../../models/horario.dart';
import 'formulario.dart';

class ListaHorarios extends StatefulWidget {
  const ListaHorarios({super.key});

  @override
  State<ListaHorarios> createState() => ListaHorariosState();
}

class ListaHorariosState extends State<ListaHorarios> {
  final List<Horario> _horarios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Horários Escolares'),
      ),
      body: ListView.builder(
        itemCount: _horarios.length,
        itemBuilder: (context, indice) {
          final horario = _horarios[indice];
          return ItemHorario(
            horario,
            onDelete: () => _confirmarExclusao(indice),
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
          ).then((horarioRecebido) => _atualiza(horarioRecebido));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Horario? horarioRecebido) {
    if (horarioRecebido != null) {
      setState(() {
        _horarios.add(horarioRecebido);
      });
    }
  }

  void _confirmarExclusao(int indice) {
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
              onPressed: () {
                setState(() {
                  _horarios.removeAt(indice);
                });
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