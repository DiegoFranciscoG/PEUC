import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> nuevasPreguntas = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Qué magnitud física se caracteriza por tener módulo, dirección y sentido?",
      "opciones": [
        "A) Magnitud escalar",
        "B) Magnitud vectorial",
        "C) Magnitud fundamental",
        "D) Magnitud derivada"
      ],
      "respuesta_correcta": "B) Magnitud vectorial",
      "explicacion_detallada": "Una magnitud vectorial requiere para su completa definición un valor numérico (módulo), una unidad, una dirección y un sentido."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Si un vector tiene componentes \$A_x = 3\$ y \$A_y = 4\$, ¿cuál es el módulo del vector \$\\vec{A}\$?",
      "opciones": [
        "A) 5",
        "B) 7",
        "C) 1",
        "D) 25"
      ],
      "respuesta_correcta": "A) 5",
      "explicacion_detallada": "El módulo se calcula usando el Teorema de Pitágoras: \$|\\vec{A}| = \\sqrt{3^2 + 4^2} = \\sqrt{9 + 16} = \\sqrt{25} = 5\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Dados los vectores \$\\vec{u} = (2, -1)\$ y \$\\vec{v} = (3, 4)\$, ¿cuál es el resultado de la suma \$\\vec{u} + \\vec{v}\$?",
      "opciones": [
        "A) (5, 3)",
        "B) (1, 5)",
        "C) (6, -4)",
        "D) (-1, -5)"
      ],
      "respuesta_correcta": "A) (5, 3)",
      "explicacion_detallada": "La suma se realiza sumando componente a componente: \$(2+3, -1+4) = (5, 3)\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Cuál es el vector unitario en la dirección del eje X positivo en un sistema de coordenadas cartesianas tridimensional?",
      "opciones": [
        "A) \$\\hat{i} = (1, 0, 0)\$",
        "B) \$\\hat{j} = (0, 1, 0)\$",
        "C) \$\\hat{k} = (0, 0, 1)\$",
        "D) \$\\hat{u} = (1, 1, 1)\$"
      ],
      "respuesta_correcta": "A) \$\\hat{i} = (1, 0, 0)\$",
      "explicacion_detallada": "Por convención, el vector unitario en la dirección del eje X se denota como \$\\hat{i}\$ y sus componentes son \$(1, 0, 0)\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Si multiplicamos un vector \$\\vec{A}\$ por un escalar negativo, ¿qué le ocurre al vector resultante?",
      "opciones": [
        "A) Conserva su dirección y sentido.",
        "B) Invierte su dirección y conserva su sentido.",
        "C) Conserva su dirección pero invierte su sentido.",
        "D) Se vuelve cero siempre."
      ],
      "respuesta_correcta": "C) Conserva su dirección pero invierte su sentido.",
      "explicacion_detallada": "Multiplicar un vector por un escalar negativo cambia su sentido, manteniéndolo en la misma recta de acción (misma dirección)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Cuál es el producto escalar (punto) de los vectores perpendiculares \$\\hat{i}\$ y \$\\hat{j}\$?",
      "opciones": [
        "A) 1",
        "B) 0",
        "C) \$\\hat{k}\$",
        "D) -1"
      ],
      "respuesta_correcta": "B) 0",
      "explicacion_detallada": "El producto escalar de dos vectores perpendiculares es cero, ya que \$\\cos(90^\\circ) = 0\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Sean \$\\vec{P} = 2\\hat{i} + 3\\hat{j}\$ y \$\\vec{Q} = 4\\hat{i} - \\hat{j}\$. ¿Cuál es el producto escalar \$\\vec{P} \\cdot \\vec{Q}\$?",
      "opciones": [
        "A) 5",
        "B) 11",
        "C) 8",
        "D) -3"
      ],
      "respuesta_correcta": "A) 5",
      "explicacion_detallada": "El producto escalar es \$(2)(4) + (3)(-1) = 8 - 3 = 5\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "El producto vectorial (cruz) de dos vectores paralelos da como resultado:",
      "opciones": [
        "A) Un escalar igual a 1",
        "B) Un escalar igual a 0",
        "C) El vector nulo \$\\vec{0}\$",
        "D) Un vector perpendicular a ambos"
      ],
      "respuesta_correcta": "C) El vector nulo \$\\vec{0}\$",
      "explicacion_detallada": "Si los vectores son paralelos, el ángulo entre ellos es \$0^\\circ\$ o \$180^\\circ\$. Como \$\\sin(0^\\circ) = 0\$, el producto cruz es el vector nulo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Dados dos vectores de magnitud 3 y 4 respectivamente. Si el ángulo entre ellos es de \$90^\\circ\$, ¿cuál es la magnitud de su vector suma?",
      "opciones": [
        "A) 7",
        "B) 5",
        "C) 1",
        "D) 12"
      ],
      "respuesta_correcta": "B) 5",
      "explicacion_detallada": "Al ser perpendiculares, la magnitud de la suma forma la hipotenusa de un triángulo rectángulo de catetos 3 y 4. \$\\sqrt{3^2 + 4^2} = 5\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Qué método gráfico se utiliza comúnmente para sumar dos vectores con el mismo punto de origen?",
      "opciones": [
        "A) Método del polígono",
        "B) Método del paralelogramo",
        "C) Método de la regla de la mano derecha",
        "D) Método del triángulo"
      ],
      "respuesta_correcta": "B) Método del paralelogramo",
      "explicacion_detallada": "El método del paralelogramo consiste en trazar paralelas a cada vector desde el extremo del otro; la diagonal desde el origen común representa el vector suma."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Si \$\\vec{A} \\times \\vec{B} = \\vec{0}\$ y ni \$\\vec{A}\$ ni \$\\vec{B}\$ son nulos, esto implica que:",
      "opciones": [
        "A) Son ortogonales",
        "B) Son colineales o paralelos",
        "C) Tienen la misma magnitud",
        "D) Forman un ángulo de \$45^\\circ\$"
      ],
      "respuesta_correcta": "B) Son colineales o paralelos",
      "explicacion_detallada": "El producto vectorial es nulo cuando el seno del ángulo entre los vectores es cero, lo que ocurre cuando el ángulo es \$0^\\circ\$ o \$180^\\circ\$, es decir, son paralelos."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Para hallar el ángulo \$\\theta\$ entre dos vectores \$\\vec{u}\$ y \$\\vec{v}\$, se puede utilizar la fórmula:",
      "opciones": [
        "A) \$\\cos\\theta = \\frac{\\vec{u} \\cdot \\vec{v}}{|\\vec{u}||\\vec{v}|}\$",
        "B) \$\\sin\\theta = \\frac{\\vec{u} \\cdot \\vec{v}}{|\\vec{u}||\\vec{v}|}\$",
        "C) \$\\cos\\theta = \\frac{|\\vec{u} \\times \\vec{v}|}{|\\vec{u}||\\vec{v}|}\$",
        "D) \$\\tan\\theta = \\frac{\\vec{u} \\cdot \\vec{v}}{|\\vec{u} \\times \\vec{v}|}\$"
      ],
      "respuesta_correcta": "A) \$\\cos\\theta = \\frac{\\vec{u} \\cdot \\vec{v}}{|\\vec{u}||\\vec{v}|}\$",
      "explicacion_detallada": "Se deriva directamente de la definición geométrica del producto escalar: \$\\vec{u} \\cdot \\vec{v} = |\\vec{u}||\\vec{v}|\\cos\\theta\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "La proyección escalar de un vector \$\\vec{A}\$ sobre otro vector \$\\vec{B}\$ está dada por:",
      "opciones": [
        "A) \$\\frac{\\vec{A} \\cdot \\vec{B}}{|\\vec{A}|}\$",
        "B) \$\\frac{\\vec{A} \\cdot \\vec{B}}{|\\vec{B}|}\$",
        "C) \$\\frac{\\vec{A} \\times \\vec{B}}{|\\vec{B}|}\$",
        "D) \$|\\vec{A}| \\sin\\theta\$"
      ],
      "respuesta_correcta": "B) \$\\frac{\\vec{A} \\cdot \\vec{B}}{|\\vec{B}|}\$",
      "explicacion_detallada": "La proyección escalar de \$\\vec{A}\$ en la dirección de \$\\vec{B}\$ es \$|\\vec{A}|\\cos\\theta\$, que equivale a \$(\\vec{A} \\cdot \\vec{B}) / |\\vec{B}|\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Un vector unitario \$\\hat{u}\$ en la dirección del vector \$\\vec{v}\$ se calcula mediante:",
      "opciones": [
        "A) \$\\hat{u} = \\vec{v} / |\\vec{v}|\$ si \$\\vec{v} \\neq \\vec{0}\$",
        "B) \$\\hat{u} = \\vec{v} \\cdot |\\vec{v}|\$",
        "C) \$\\hat{u} = \\vec{v} \\times \\vec{v}\$",
        "D) \$\\hat{u} = |\\vec{v}| / \\vec{v}\$"
      ],
      "respuesta_correcta": "A) \$\\hat{u} = \\vec{v} / |\\vec{v}|\$ si \$\\vec{v} \\neq \\vec{0}\$",
      "explicacion_detallada": "Para obtener un vector unitario, se divide el vector entre su propio módulo o magnitud."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Qué indica la regla de la mano derecha en el contexto del producto vectorial \$\\vec{A} \\times \\vec{B}\$?",
      "opciones": [
        "A) La magnitud del vector resultante.",
        "B) La dirección y sentido del vector resultante.",
        "C) El ángulo entre los dos vectores.",
        "D) Si los vectores son coplanares."
      ],
      "respuesta_correcta": "B) La dirección y sentido del vector resultante.",
      "explicacion_detallada": "La regla de la mano derecha permite determinar el sentido del vector resultante del producto cruz, el cual es siempre ortogonal al plano formado por los vectores originales."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Sean \$\\vec{A} = (1, 2, 3)\$ y \$\\vec{B} = (2, -1, 0)\$. El vector diferencia \$\\vec{A} - \\vec{B}\$ es:",
      "opciones": [
        "A) (-1, 3, 3)",
        "B) (3, 1, 3)",
        "C) (-1, 1, 3)",
        "D) (1, -3, -3)"
      ],
      "respuesta_correcta": "A) (-1, 3, 3)",
      "explicacion_detallada": "Se restan las componentes respectivas: \$(1-2, 2-(-1), 3-0) = (-1, 3, 3)\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Cuál es la magnitud del vector \$\\vec{v} = 6\\hat{i} - 8\\hat{j} + 0\\hat{k}\$?",
      "opciones": [
        "A) -2",
        "B) 10",
        "C) 14",
        "D) 100"
      ],
      "respuesta_correcta": "B) 10",
      "explicacion_detallada": "La magnitud es \$|\\vec{v}| = \\sqrt{6^2 + (-8)^2 + 0^2} = \\sqrt{36 + 64} = \\sqrt{100} = 10\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Si la magnitud del producto vectorial de dos vectores es igual al producto de sus magnitudes, ¿qué se puede afirmar sobre los vectores?",
      "opciones": [
        "A) Son paralelos.",
        "B) Son ortogonales (perpendiculares).",
        "C) Su producto escalar es máximo.",
        "D) Al menos uno de ellos es un vector unitario."
      ],
      "respuesta_correcta": "B) Son ortogonales (perpendiculares).",
      "explicacion_detallada": "La magnitud del producto cruz es \$|\\vec{A} \\times \\vec{B}| = |\\vec{A}||\\vec{B}|\\sin\\theta\$. Si esto es igual a \$|\\vec{A}||\\vec{B}|\$, entonces \$\\sin\\theta = 1\$, lo que implica que \$\\theta = 90^\\circ\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "Un objeto se mueve 10 m hacia el este y luego 10 m hacia el norte. ¿Cuál es el módulo del vector desplazamiento resultante?",
      "opciones": [
        "A) 20 m",
        "B) 10 m",
        "C) \$10\\sqrt{2}\$ m",
        "D) 0 m"
      ],
      "respuesta_correcta": "C) \$10\\sqrt{2}\$ m",
      "explicacion_detallada": "El desplazamiento total es la hipotenusa de un triángulo rectángulo con catetos de 10 m. \$d = \\sqrt{10^2 + 10^2} = \\sqrt{200} = 10\\sqrt{2}\$ m."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.10.1",
      "enunciado": "¿Qué propiedad asegura que la suma de vectores no depende del orden en el que se sumen (es decir, \$\\vec{A} + \\vec{B} = \\vec{B} + \\vec{A}\$)?",
      "opciones": [
        "A) Propiedad asociativa",
        "B) Propiedad conmutativa",
        "C) Propiedad distributiva",
        "D) Elemento neutro"
      ],
      "respuesta_correcta": "B) Propiedad conmutativa",
      "explicacion_detallada": "La suma vectorial es conmutativa, lo que significa que el orden de los sumandos no altera la resultante."
    }
  ];

  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < nuevasPreguntas.length; i++) {
    var p = nuevasPreguntas[i];
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    // Normalizar la respuesta correcta
    String letra = p['respuesta_correcta'].toString().replaceAll(')', '').trim();
    if (letra.length > 2) letra = letra.substring(0, 1);
    for (var op in p['opciones']) {
      if (op.startsWith(letra + ')')) {
        p['respuesta_correcta'] = op;
        break;
      }
    }
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.10.1 mediante Dart List.');
}
