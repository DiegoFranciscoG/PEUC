/// Rules of the Universidad de Cuenca 2026 admission exam.
///
/// Sources (see docs/investigacion.md):
///  * Guía del Examen de Admisión 2026 (UCuenca, julio 2026): 60 preguntas,
///    12 por componente, 70 minutos, +1 / −1/3 / 0, +50 % de tiempo para
///    personas con discapacidad.
///  * www.ucuenca.edu.ec/admisiones/examen/: ponderación por campo prioritario
///    de conocimiento y puntaje de postulación (60 % examen, 40 % antecedentes).
abstract final class AdmissionRules {
  static const int questionsPerArea = 12;
  static const int totalQuestions = 60;
  static const Duration examDuration = Duration(minutes: 70);
  static const double accessibilityExtraTime = 0.5;

  static const double correctPoints = 1;
  static const double wrongPoints = -1 / 3;
  static const double blankPoints = 0;

  static const double examWeight = 0.6;
  static const double academicBackgroundWeight = 0.4;

  /// Order in which the official guide lists the five components.
  static const List<String> areaOrder = ['MAT', 'LEN', 'CSO', 'CNA', 'RAB'];
}

/// A "campo prioritario de conocimiento": every career belongs to one and it
/// decides the weight of each exam component.
class KnowledgeField {
  const KnowledgeField({
    required this.code,
    required this.name,
    required this.weights,
    required this.careers,
  });

  final String code;
  final String name;

  /// Percentage (0..100) of the exam score coming from each area code.
  final Map<String, int> weights;
  final List<String> careers;
}

const List<KnowledgeField> knowledgeFields = [
  KnowledgeField(
    code: 'CN',
    name: 'Ciencias Naturales+',
    weights: {'CNA': 45, 'CSO': 10, 'LEN': 10, 'MAT': 15, 'RAB': 20},
    careers: [
      'Enfermería',
      'Estimulación Temprana en Salud',
      'Fisioterapia',
      'Fonoaudiología',
      'Laboratorio Clínico',
      'Medicina',
      'Medicina Veterinaria',
      'Nutrición y Dietética',
      'Odontología',
      'Pedagogía de la Actividad Física y Deporte',
      'Pedagogía de las Ciencias Experimentales: Química y Biología',
      'Psicología',
      'Psicología Educativa',
    ],
  ),
  KnowledgeField(
    code: 'CS',
    name: 'Ciencias Sociales+',
    weights: {'CNA': 10, 'CSO': 30, 'LEN': 20, 'MAT': 20, 'RAB': 20},
    careers: [
      'Artes Escénicas',
      'Artes Musicales',
      'Artes Visuales',
      'Comunicación',
      'Derecho',
      'Diseño de Interiores',
      'Diseño Gráfico',
      'Educación Inicial',
      'Género y Desarrollo',
      'Orientación Familiar',
      'Pedagogía de las Artes y las Humanidades',
      'Sociología',
      'Trabajo Social',
    ],
  ),
  KnowledgeField(
    code: 'LL',
    name: 'Lengua y Literatura+',
    weights: {'CNA': 15, 'CSO': 25, 'LEN': 25, 'MAT': 15, 'RAB': 20},
    careers: [
      'Cine',
      'Educación Básica',
      'Pedagogía de la Historia y Ciencias Sociales',
      'Pedagogía de la Lengua y la Literatura',
      'Pedagogía de los Idiomas Nacionales y Extranjeros',
      'Periodismo',
    ],
  ),
  KnowledgeField(
    code: 'M',
    name: 'Matemática+',
    weights: {'CNA': 15, 'CSO': 10, 'LEN': 10, 'MAT': 45, 'RAB': 20},
    careers: [
      'Administración de Empresas',
      'Administración de Empresas Dual',
      'Administración de Infraestructura y Plataformas Tecnológicas',
      'Agronomía',
      'Arquitectura',
      'Automatización e Instrumentación',
      'Computación',
      'Contabilidad y Auditoría',
      'Economía',
      'Electricidad',
      'Emprendimiento e Innovación',
      'Gastronomía',
      'Hospitalidad y Hotelería',
      'Ingeniería Civil',
      'Instalaciones de Redes Eléctricas',
      'Mercadotecnia',
      'Telecomunicaciones',
      'Turismo',
    ],
  ),
  KnowledgeField(
    code: 'MCN',
    name: 'Matemática y Ciencias Naturales+',
    weights: {'CNA': 20, 'CSO': 10, 'LEN': 10, 'MAT': 40, 'RAB': 20},
    careers: [
      'Bioquímica y Farmacia',
      'Imagenología y Radiología',
      'Ingeniería Ambiental',
      'Ingeniería Industrial',
      'Ingeniería Química',
      'Pedagogía de las Ciencias Experimentales: Matemáticas y Física',
    ],
  ),
];

KnowledgeField fieldByCode(String code) =>
    knowledgeFields.firstWhere((f) => f.code == code, orElse: () => knowledgeFields.first);

KnowledgeField? fieldOfCareer(String career) {
  for (final field in knowledgeFields) {
    if (field.careers.contains(career)) return field;
  }
  return null;
}
