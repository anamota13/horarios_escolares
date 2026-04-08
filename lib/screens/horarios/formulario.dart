import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/horario.dart';

class FormularioHorario extends StatelessWidget {
  final TextEditingController _controladorCampoDisciplina = TextEditingController();
  final TextEditingController _controladorCampoHora = TextEditingController();
  final TextEditingController _controladorCampoDia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criando Horário')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoDisciplina,
              rotulo: 'Disciplina',
              dica: 'Ex: Matemática',
            ),
            Editor(
              controlador: _controladorCampoHora,
              rotulo: 'Hora',
              dica: '08:00',
              icone: Icons.access_time,
            ),
            Editor(
              controlador: _controladorCampoDia,
              rotulo: 'Dia da Semana',
              dica: 'Segunda-feira',
              icone: Icons.calendar_today,
            ),
            ElevatedButton(
              onPressed: () => _criaHorario(context),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _criaHorario(BuildContext context) {
    final String disciplina = _controladorCampoDisciplina.text;
    final String hora = _controladorCampoHora.text;
    final String dia = _controladorCampoDia.text;

    if (disciplina.isNotEmpty && hora.isNotEmpty) {
      final horarioCriado = Horario(disciplina, hora, dia);
      Navigator.pop(context, horarioCriado);
    }
  }
}