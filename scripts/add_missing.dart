import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('assets/data/preguntas.json');
  final List<dynamic> data = jsonDecode(file.readAsStringSync(encoding: utf8));
  
  final Map<String, dynamic> newQs = {
    '3.1.3': {
      'enunciado': 'El organelo encargado de la respiración celular y producción de ATP es:',
      'opciones': ['Mitocondria', 'Ribosoma', 'Cloroplasto', 'Aparato de Golgi'],
      'respuesta': 'Mitocondria'
    },
    '3.4.3': {
      'enunciado': 'La unidad anatómica y funcional del riñón encargada de filtrar la sangre es:',
      'opciones': ['Nefrona', 'Alvéolo', 'Neurona', 'Osteocito'],
      'respuesta': 'Nefrona'
    },
    '3.4.4': {
      'enunciado': 'El intercambio de gases en los pulmones humanos ocurre específicamente en:',
      'opciones': ['Los alvéolos', 'Los bronquios', 'La tráquea', 'La laringe'],
      'respuesta': 'Los alvéolos'
    },
    '3.4.5': {
      'enunciado': 'La bilis, producida por el hígado y esencial para la digestión de grasas, se almacena en:',
      'opciones': ['La vesícula biliar', 'El páncreas', 'El estómago', 'El duodeno'],
      'respuesta': 'La vesícula biliar'
    },
    '3.4.6': {
      'enunciado': 'El vaso sanguíneo de mayor calibre que lleva sangre oxigenada desde el corazón al resto del cuerpo es:',
      'opciones': ['La arteria aorta', 'La vena cava', 'La arteria pulmonar', 'La vena yugular'],
      'respuesta': 'La arteria aorta'
    },
    '3.7.2': {
      'enunciado': 'Según el Sistema Internacional (SI), la unidad de medida de la fuerza es el:',
      'opciones': ['Newton', 'Joule', 'Watt', 'Pascal'],
      'respuesta': 'Newton'
    },
    '3.7.3': {
      'enunciado': 'La energía cinética de un cuerpo en movimiento depende de su:',
      'opciones': ['Masa y velocidad', 'Masa y altura', 'Peso y volumen', 'Fuerza y distancia'],
      'respuesta': 'Masa y velocidad'
    },
    '3.7.4': {
      'enunciado': 'La primera ley de la termodinámica es una aplicación del principio de:',
      'opciones': ['Conservación de la energía', 'Aumento de la entropía', 'Cero absoluto', 'Relatividad especial'],
      'respuesta': 'Conservación de la energía'
    },
    '3.7.7': {
      'enunciado': 'En un circuito eléctrico conectado en serie, la intensidad de corriente:',
      'opciones': ['Es la misma en todos los componentes', 'Se divide entre las resistencias', 'Es inversamente proporcional al voltaje', 'Aumenta en cada nodo'],
      'respuesta': 'Es la misma en todos los componentes'
    },
    '3.7.8': {
      'enunciado': 'La Ley de Ohm establece la relación fundamental entre voltaje, corriente y resistencia, y se expresa matemáticamente como:',
      'opciones': ['V = I * R', 'P = V * I', 'F = m * a', 'E = m * c²'],
      'respuesta': 'V = I * R'
    },
    '3.8.1': {
      'enunciado': 'El número de Avogadro representa la cantidad de partículas elementales en un mol y su valor aproximado es:',
      'opciones': ['6.022 × 10²³', '3.1416', '9.81', '2.99 × 10⁸'],
      'respuesta': '6.022 × 10²³'
    },
    '3.9.1': {
      'enunciado': 'En la escala de pH, el agua pura a 25°C tiene un valor de:',
      'opciones': ['7 (Neutro)', '0 (Muy ácido)', '14 (Muy básico)', '5.5 (Ligeramente ácido)'],
      'respuesta': '7 (Neutro)'
    },
    '3.10.1': {
      'enunciado': 'Un ácido fuerte, según la teoría de Arrhenius, es aquel que en solución acuosa:',
      'opciones': ['Se disocia completamente liberando iones H+', 'Acepta protones de otras moléculas', 'No conduce la electricidad', 'Mantiene un pH superior a 7'],
      'respuesta': 'Se disocia completamente liberando iones H+'
    },
    '4.4.1': {
      'enunciado': 'El Renacimiento, movimiento cultural que marcó la transición de la Edad Media a la Edad Moderna, se originó en:',
      'opciones': ['Italia', 'Francia', 'Inglaterra', 'Alemania'],
      'respuesta': 'Italia'
    },
    '4.5.1': {
      'enunciado': 'La Revolución Francesa, acontecimiento que inició la Edad Contemporánea, estalló en el año:',
      'opciones': ['1789', '1492', '1810', '1914'],
      'respuesta': '1789'
    },
    '4.5.2': {
      'enunciado': 'La Primera Revolución Industrial, caracterizada por la invención de la máquina de vapor, comenzó en:',
      'opciones': ['Gran Bretaña', 'Estados Unidos', 'Rusia', 'España'],
      'respuesta': 'Gran Bretaña'
    },
    '4.5.3': {
      'enunciado': 'El conflicto global conocido como la Primera Guerra Mundial finalizó en el año:',
      'opciones': ['1918', '1914', '1939', '1945'],
      'respuesta': '1918'
    },
    '4.6.1': {
      'enunciado': 'El río que atraviesa mayor cantidad de países en América del Sur y posee la mayor cuenca hidrográfica del mundo es el:',
      'opciones': ['Río Amazonas', 'Río de la Plata', 'Río Orinoco', 'Río Paraná'],
      'respuesta': 'Río Amazonas'
    },
    '4.7.1': {
      'enunciado': 'De acuerdo con la división política del Ecuador, la capital de la provincia de Azuay es:',
      'opciones': ['Cuenca', 'Quito', 'Guayaquil', 'Loja'],
      'respuesta': 'Cuenca'
    },
    '4.8.1': {
      'enunciado': 'En la Constitución del Ecuador, la Función Ejecutiva es ejercida por:',
      'opciones': ['El Presidente de la República', 'La Asamblea Nacional', 'El Consejo de la Judicatura', 'La Corte Constitucional'],
      'respuesta': 'El Presidente de la República'
    },
    '4.9.1': {
      'enunciado': 'Los Derechos Humanos se caracterizan por ser universales, inalienables e indivisibles. La Declaración Universal fue adoptada por la ONU en:',
      'opciones': ['1948', '1789', '1914', '2008'],
      'respuesta': '1948'
    },
    '4.10.1': {
      'enunciado': 'El filósofo griego autor de la obra "La República" y creador del Mito de la Caverna fue:',
      'opciones': ['Platón', 'Aristóteles', 'Sócrates', 'Tales de Mileto'],
      'respuesta': 'Platón'
    },
    '4.11.1': {
      'enunciado': 'La "Mayéutica" es el método filosófico de indagación y enseñanza que consiste en hacer preguntas para que el interlocutor descubra la verdad. Fue atribuido a:',
      'opciones': ['Sócrates', 'Descartes', 'Kant', 'Hegel'],
      'respuesta': 'Sócrates'
    }
  };

  int idCounter = 900;
  newQs.forEach((codigo, qData) {
    String materia = codigo.startsWith('3.') ? 'Ciencias Naturales' : 'Ciencias Sociales';
    data.add({
      'id': 'fix_real_' + idCounter.toString(),
      'materia': materia,
      'codigo_tema': codigo,
      'enunciado': qData['enunciado'],
      'es_opciones_imagen': false,
      'opciones': qData['opciones'],
      'respuesta_correcta': qData['respuesta'],
      'explicacion_detallada': 'Explicación: La respuesta correcta es ' + qData['respuesta'] + '.',
      'pasos_resolucion': ['Paso 1: Leer el enunciado.', 'Paso 2: Identificar el concepto clave.', 'Paso 3: Seleccionar la opción correcta.'],
      'video_explicativo_url': 'https://www.youtube.com/results?search_query=preparacion+examen+ucuenca'
    });
    idCounter++;
  });

  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data), encoding: utf8);
  print('Added ' + newQs.length.toString() + ' questions.');
}
