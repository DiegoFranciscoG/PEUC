import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál es la unidad base fundamental de la masa en el Sistema Internacional de Unidades (SI)?",
    "opciones": [
      "A) Gramo",
      "B) Libra",
      "C) Kilogramo",
      "D) Onza"
    ],
    "respuesta_correcta": "C) Kilogramo",
    "explicacion_detallada": "En el SI, la unidad fundamental para la masa es el kilogramo (kg). Es la única unidad base que incluye un prefijo en su nombre."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Qué magnitud física se mide en Kelvin (K) según el Sistema Internacional?",
    "opciones": [
      "A) Calor",
      "B) Temperatura termodinámica",
      "C) Energía interna",
      "D) Entalpía"
    ],
    "respuesta_correcta": "B) Temperatura termodinámica",
    "explicacion_detallada": "El Kelvin es la unidad base del SI para la temperatura termodinámica. El calor y la energía se miden en Joules."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál de las siguientes unidades NO es una unidad fundamental del Sistema Internacional?",
    "opciones": [
      "A) Metro",
      "B) Segundo",
      "C) Newton",
      "D) Amperio"
    ],
    "respuesta_correcta": "C) Newton",
    "explicacion_detallada": "El Newton es una unidad derivada que se utiliza para medir la fuerza, mientras que el metro, el segundo y el amperio son unidades fundamentales."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿A qué equivale un Newton (N) expresado en unidades fundamentales del SI?",
    "opciones": [
      "A) $kg \\cdot m^2 / s^2$",
      "B) $kg \\cdot m / s^2$",
      "C) $kg^2 \\cdot m / s$",
      "D) $kg \\cdot m / s$"
    ],
    "respuesta_correcta": "B) $kg \\cdot m / s^2$",
    "explicacion_detallada": "Por la segunda ley de Newton ($F = m \\cdot a$), la fuerza es masa (kg) por aceleración ($m/s^2$). Por lo tanto, 1 N = 1 $kg \\cdot m / s^2$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "La unidad derivada de la energía, el trabajo y el calor en el SI es:",
    "opciones": [
      "A) Watt",
      "B) Pascal",
      "C) Newton",
      "D) Joule"
    ],
    "respuesta_correcta": "D) Joule",
    "explicacion_detallada": "El Joule (J) es la unidad estándar de energía y trabajo en el SI. Equivale al trabajo realizado por una fuerza de un Newton al desplazar un objeto un metro."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál es la expresión del Joule (J) en unidades base del SI?",
    "opciones": [
      "A) $kg \\cdot m^2 / s^2$",
      "B) $kg \\cdot m / s^2$",
      "C) $kg \\cdot m^2 / s^3$",
      "D) $kg \\cdot m / s$"
    ],
    "respuesta_correcta": "A) $kg \\cdot m^2 / s^2$",
    "explicacion_detallada": "Dado que 1 Joule es 1 Newton por metro, y un Newton es $kg \\cdot m / s^2$, al multiplicarlo por la unidad de longitud ($m$) obtenemos $kg \\cdot m^2 / s^2$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Qué magnitud fundamental se mide con la unidad 'Amperio' (A)?",
    "opciones": [
      "A) Carga eléctrica",
      "B) Potencial eléctrico",
      "C) Intensidad de corriente eléctrica",
      "D) Resistencia eléctrica"
    ],
    "respuesta_correcta": "C) Intensidad de corriente eléctrica",
    "explicacion_detallada": "El amperio es la unidad base del SI que define la intensidad de corriente eléctrica. La carga eléctrica se mide en Coulombs, que es una unidad derivada."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál de las siguientes unidades representa la intensidad luminosa en el SI?",
    "opciones": [
      "A) Lumen",
      "B) Lux",
      "C) Candela",
      "D) Watt"
    ],
    "respuesta_correcta": "C) Candela",
    "explicacion_detallada": "La candela (cd) es una de las siete unidades base del SI y se usa para medir la intensidad luminosa. El lumen y el lux son unidades derivadas de esta."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "Para la cantidad de sustancia, la unidad base del SI es:",
    "opciones": [
      "A) Gramo",
      "B) Litro",
      "C) Átomo",
      "D) Mol"
    ],
    "respuesta_correcta": "D) Mol",
    "explicacion_detallada": "El mol es la unidad que mide la cantidad de sustancia, representando un número específico de entidades elementales idénticas (el número de Avogadro)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "La potencia se mide en Watts (W). ¿A qué equivale 1 Watt en función del Joule y el segundo?",
    "opciones": [
      "A) 1 $J \\cdot s$",
      "B) 1 $J / s$",
      "C) 1 $J / s^2$",
      "D) 1 $s / J$"
    ],
    "respuesta_correcta": "B) 1 $J / s$",
    "explicacion_detallada": "La potencia se define como la rapidez con la que se realiza un trabajo o se transfiere energía, es decir, energía dividida por tiempo ($J/s$)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál es la unidad del SI para medir la presión?",
    "opciones": [
      "A) Atmósfera",
      "B) Bar",
      "C) Pascal",
      "D) mmHg"
    ],
    "respuesta_correcta": "C) Pascal",
    "explicacion_detallada": "El Pascal (Pa) es la unidad derivada del SI para la presión, equivalente a aplicar una fuerza de un Newton distribuida sobre un área de un metro cuadrado ($N/m^2$)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "El prefijo 'micro' ($\\mu$) del Sistema Internacional indica un factor multiplicador de:",
    "opciones": [
      "A) $10^{-3}$",
      "B) $10^{-6}$",
      "C) $10^{-9}$",
      "D) $10^6$"
    ],
    "respuesta_correcta": "B) $10^{-6}$",
    "explicacion_detallada": "El prefijo micro representa la millonésima parte de la unidad base correspondiente, equivalente al factor multiplicador $10^{-6}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "Si una distancia se expresa en nanómetros (nm), ¿qué potencia de 10 corresponde al prefijo 'nano'?",
    "opciones": [
      "A) $10^{-12}$",
      "B) $10^{-9}$",
      "C) $10^{-6}$",
      "D) $10^{-15}$"
    ],
    "respuesta_correcta": "B) $10^{-9}$",
    "explicacion_detallada": "El prefijo nano (n) en el SI equivale a la milmillonésima parte de una unidad, es decir, un factor de multiplicación de $10^{-9}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Qué magnitud se mide con la unidad derivada Hertz (Hz)?",
    "opciones": [
      "A) Periodo",
      "B) Longitud de onda",
      "C) Velocidad angular",
      "D) Frecuencia"
    ],
    "respuesta_correcta": "D) Frecuencia",
    "explicacion_detallada": "El Hertz (Hz) mide la frecuencia de un fenómeno periódico, equivaliendo a un ciclo o evento completo por segundo ($s^{-1}$)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿A qué es igual un Coulomb (C), unidad derivada para la carga eléctrica, en términos de las unidades base del SI?",
    "opciones": [
      "A) $A / s$",
      "B) $A \\cdot s$",
      "C) $V / \\Omega$",
      "D) $J / V$"
    ],
    "respuesta_correcta": "B) $A \\cdot s$",
    "explicacion_detallada": "La carga eléctrica se define a través de la corriente en el tiempo ($Q = I \\cdot t$). Un Coulomb es la carga transportada por una corriente de un Amperio durante un segundo ($A \\cdot s$)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál es la unidad correcta en el SI para expresar la densidad volumétrica de masa?",
    "opciones": [
      "A) $g / cm^3$",
      "B) $kg / L$",
      "C) $kg / m^3$",
      "D) $g / mL$"
    ],
    "respuesta_correcta": "C) $kg / m^3$",
    "explicacion_detallada": "Dado que las unidades base del SI para la masa y la longitud son el kilogramo (kg) y el metro (m), la densidad absoluta o volumétrica se expresa como $kg/m^3$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "El prefijo 'kilo' (k) multiplica a la unidad base respectiva por un factor de:",
    "opciones": [
      "A) $10^2$",
      "B) $10^3$",
      "C) $10^6$",
      "D) $10^9$"
    ],
    "respuesta_correcta": "B) $10^3$",
    "explicacion_detallada": "El prefijo kilo significa 'mil' veces la unidad, lo cual se representa de forma exponencial como el factor $10^3$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "En el contexto de conversiones, para transformar un valor de velocidad de $km/h$ a $m/s$, ¿qué factor simplificado se debe utilizar?",
    "opciones": [
      "A) Multiplicar por 3.6",
      "B) Dividir entre 3.6",
      "C) Multiplicar por 100",
      "D) Dividir entre 1000"
    ],
    "respuesta_correcta": "B) Dividir entre 3.6",
    "explicacion_detallada": "Para pasar de $km/h$ a $m/s$, se multiplica por 1000 m y se divide entre 3600 s. Esto equivale matemáticamente a dividir la cantidad original entre el factor simplificado 3.6."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "¿Cuál es el símbolo correcto para escribir la unidad 'milisegundo'?",
    "opciones": [
      "A) ms",
      "B) mS",
      "C) Ms",
      "D) MS"
    ],
    "respuesta_correcta": "A) ms",
    "explicacion_detallada": "En las convenciones del SI, 'm' minúscula es el prefijo para mili, y 's' minúscula es el símbolo del segundo. 'mS' indicaría milisiemens."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.2.1",
    "enunciado": "El Voltio (V), unidad de diferencia de potencial eléctrico, equivale conceptualmente a la relación entre:",
    "opciones": [
      "A) Joules y Coulombs",
      "B) Newtons y Metros",
      "C) Watts y Segundos",
      "D) Amperios y Ohmios"
    ],
    "respuesta_correcta": "A) Joules y Coulombs",
    "explicacion_detallada": "El Voltio se define como la energía transferida o el trabajo realizado (en Joules) por unidad de carga eléctrica que se mueve (en Coulombs). Por ende, $1 V = 1 J/C$."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.2.1.');
}
