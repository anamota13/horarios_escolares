class Horario {
  int? id; // O banco de dados vai gerar esse ID automaticamente
  String disciplina;
  String hora;
  String diaSemana;

  Horario({
    this.id,
    required this.disciplina,
    required this.hora,
    required this.diaSemana,
  });

  factory Horario.fromMap(Map<String, dynamic> map) {
    return Horario(
      id: map['id'],
      disciplina: map['disciplina'] ?? '',
      hora: map['hora'] ?? '',
      diaSemana: map['diaSemana'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'disciplina': disciplina,
      'hora': hora,
      'diaSemana': diaSemana,
    };
  }
}