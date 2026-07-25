import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = '''[
  {
    "materia": "Matemáticas",
    "codigo_tema": "1.1.4",
    "titulo": "Función cuadrática",
    "contenido_markdown": "Una función cuadrática es una función polinómica con una o más variables en la que el término de grado más alto es de segundo grado. En el caso de una función de una sola variable, tiene la forma general \$f(x) = ax^2 + bx + c\$, donde \$a\$, \$b\$, y \$c\$ son constantes reales y \$a \\\\neq 0\$. La gráfica de una función cuadrática es una curva con forma de U o de U invertida llamada parábola. \\n\\nEl coeficiente \$a\$ determina la dirección y la amplitud de la apertura de la parábola. Si \$a > 0\$, la parábola se abre hacia arriba y tiene un punto mínimo absoluto. Si \$a < 0\$, la parábola se abre hacia abajo y tiene un punto máximo absoluto. El valor absoluto de \$a\$ controla cuán 'estrecha' o 'ancha' es la parábola; valores más grandes de \$|a|\$ producen parábolas más estrechas.\\n\\nEl vértice de la parábola es el punto más bajo (si \$a > 0\$) o más alto (si \$a < 0\$) de la curva. Sus coordenadas \$(h, k)\$ se pueden encontrar utilizando la fórmula \$h = -\\\\frac{b}{2a}\$ y evaluando la función en este punto para encontrar \$k\$, es decir, \$k = f(h) = f(-\\\\frac{b}{2a})\$. La recta vertical que pasa por el vértice, con ecuación \$x = -\\\\frac{b}{2a}\$, se denomina eje de simetría de la parábola. \\n\\nLas raíces, ceros o intersecciones con el eje \$x\$ de la función cuadrática se encuentran resolviendo la ecuación cuadrática asociada \$ax^2 + bx + c = 0\$. Esto se puede lograr mediante factorización, completando el cuadrado o utilizando la fórmula general \$x = \\\\frac{-b \\\\pm \\\\sqrt{b^2 - 4ac}}{2a}\$. La cantidad \$\\\\Delta = b^2 - 4ac\$ se llama discriminante y su valor determina la naturaleza de las raíces: si \$\\\\Delta > 0\$, hay dos raíces reales distintas; si \$\\\\Delta = 0\$, hay una raíz real doble; si \$\\\\Delta < 0\$, no hay raíces reales (las raíces son complejas conjugadas).\\n\\nEl punto donde la parábola interseca el eje \$y\$ se llama intersección con el eje \$y\$, y ocurre cuando \$x = 0\$. Evaluando la función, obtenemos \$f(0) = c\$. Por lo tanto, el punto de intersección con el eje \$y\$ es \$(0, c)\$. Las funciones cuadráticas modelan muchos fenómenos del mundo real, como la trayectoria de un proyectil bajo la influencia de la gravedad, la maximización de áreas o ganancias, y otros problemas de optimización. Comprender sus propiedades es fundamental en el estudio del álgebra, el cálculo y la física preuniversitaria, proporcionando una base sólida para el análisis de funciones más complejas.",
    "formula_clave": "y = ax^2+bx+c",
    "video_url": ""
  },
  {
    "materia": "Matemáticas",
    "codigo_tema": "1.1.5",
    "titulo": "Ecuaciones",
    "contenido_markdown": "Una ecuación es una igualdad matemática entre dos expresiones, denominadas miembros, separadas por el signo de igual (\$ = \$), en las que aparecen elementos conocidos y datos desconocidos o incógnitas, relacionados mediante operaciones matemáticas. El objetivo principal al resolver una ecuación es encontrar el valor o los valores de las incógnitas que hacen que la igualdad sea verdadera. A estos valores se les llama soluciones o raíces de la ecuación.\\n\\nExisten diversos tipos de ecuaciones, clasificados según sus características. Las ecuaciones polinómicas son aquellas en las que ambos miembros son polinomios. Se clasifican según su grado, que es el mayor exponente de la incógnita. Por ejemplo, una ecuación lineal o de primer grado tiene la forma general \$ax + b = 0\$, con \$a \\\\neq 0\$. Su solución es única y se encuentra aislando la incógnita: \$x = -\\\\frac{b}{a}\$. \\n\\nLas ecuaciones cuadráticas o de segundo grado, de la forma \$ax^2 + bx + c = 0\$ (\$a \\\\neq 0\$), pueden tener hasta dos soluciones reales, que se calculan con la fórmula resolvente \$x = \\\\frac{-b \\\\pm \\\\sqrt{b^2 - 4ac}}{2a}\$. El término \$b^2 - 4ac\$ es el discriminante, el cual indica si la ecuación tiene dos, una o ninguna solución real dependiendo de si es positivo, cero o negativo, respectivamente. Existen también ecuaciones de grado superior, cuyas soluciones pueden encontrarse mediante métodos como la regla de Ruffini, el teorema del resto o técnicas de factorización avanzadas.\\n\\nAdemás de las polinómicas, estudiamos ecuaciones racionales, donde la incógnita aparece en el denominador de fracciones algebraicas (ej. \$\\\\frac{1}{x} + \\\\frac{2}{x-1} = 3\$). Para resolverlas, se busca un denominador común y se reduce a una ecuación polinómica, prestando atención a descartar los valores que anulan los denominadores originales (restricciones). \\n\\nLas ecuaciones irracionales son aquellas donde la incógnita se encuentra bajo el signo radical. El método general de resolución consiste en aislar el radical y elevar ambos miembros al exponente adecuado (generalmente al cuadrado) para eliminar la raíz. Este proceso puede introducir soluciones extrañas, por lo que es crucial comprobar siempre las soluciones obtenidas en la ecuación original. El estudio de las ecuaciones es el núcleo del álgebra y es indispensable para la formulación y resolución de problemas matemáticos, físicos, químicos y económicos, donde es necesario modelar situaciones mediante igualdades matemáticas.",
    "formula_clave": "ax + b = 0",
    "video_url": ""
  },
  {
    "materia": "Matemáticas",
    "codigo_tema": "1.1.6",
    "titulo": "Intervalos e inecuaciones",
    "contenido_markdown": "En matemáticas, un intervalo es un conjunto de números reales que se encuentran comprendidos entre dos extremos, a y b, y pueden incluir o no a dichos extremos. Los intervalos se representan utilizando paréntesis o corchetes y proporcionan una forma concisa de denotar subconjuntos continuos de la recta real. Existen varios tipos de intervalos: el intervalo abierto \$(a, b)\$ incluye todos los números reales estrictamente entre \$a\$ y \$b\$, sin incluirlos a ellos (\$a < x < b\$). El intervalo cerrado \$[a, b]\$ incluye todos los números reales entre \$a\$ y \$b\$, incluyéndolos (\$a \\\\leq x \\\\leq b\$). Los intervalos semiabiertos o semicerrados, como \$[a, b)\$ o \$(a, b]\$, incluyen solo uno de los extremos. Además, los intervalos pueden extenderse hacia el infinito, como \$(a, \\\\infty)\$ que incluye todos los números mayores que \$a\$ (\$x > a\$).\\n\\nUna inecuación es una desigualdad algebraica en la que aparecen números y letras (incógnitas) relacionados por los signos \$<\$, \$>\$, \$\\\\leq\$, o \$\\\\geq\$. A diferencia de las ecuaciones, cuyas soluciones son generalmente valores discretos, la solución de una inecuación es, por lo general, un conjunto de valores, un intervalo o una unión de intervalos. \\n\\nPara resolver inecuaciones lineales (de la forma \$ax + b > 0\$), se aplican propiedades similares a las de las ecuaciones, con una diferencia fundamental: si se multiplica o divide la inecuación por un número negativo, el sentido de la desigualdad debe invertirse. Por ejemplo, si tenemos \$-2x > 4\$, al dividir entre \$-2\$, obtenemos \$x < -2\$.\\n\\nLas inecuaciones de grado superior o racionales se resuelven mediante el análisis de signos. El procedimiento general consiste en pasar todos los términos a un lado de la desigualdad para dejar un cero en el otro lado. Luego, se factoriza la expresión resultante y se determinan los puntos críticos (donde la expresión vale cero o no está definida). Estos puntos dividen la recta real en varios intervalos. Se selecciona un valor de prueba en cada intervalo y se evalúa la expresión para determinar si el resultado es positivo o negativo. Finalmente, se identifican los intervalos que satisfacen la desigualdad original. Las inecuaciones son herramientas fundamentales para definir dominios de funciones, resolver problemas de optimización con restricciones (como en programación lineal) y analizar el comportamiento de variables que deben estar limitadas dentro de ciertos márgenes.",
    "formula_clave": "a < x < b",
    "video_url": ""
  },
  {
    "materia": "Matemáticas",
    "codigo_tema": "1.1.7",
    "titulo": "Matrices reales de m x n",
    "contenido_markdown": "Una matriz es un arreglo bidimensional o rectangular de números, llamados elementos o entradas de la matriz, dispuestos en filas y columnas. Una matriz real de \$m \\\\times n\$ (se lee 'm por n') es una matriz que tiene \$m\$ filas y \$n\$ columnas, y donde cada elemento es un número real. La dimensión u orden de la matriz es precisamente \$m \\\\times n\$. Si \$A\$ es una matriz, su elemento situado en la fila \$i\$ y la columna \$j\$ se denota comúnmente como \$a_{ij}\$. Por lo tanto, la matriz \$A\$ se puede representar como \$A = (a_{ij})_{m \\\\times n}\$.\\n\\nExisten tipos especiales de matrices según sus dimensiones y elementos. Si \$m = n\$, la matriz tiene el mismo número de filas que de columnas y se llama matriz cuadrada de orden \$n\$. En una matriz cuadrada, los elementos \$a_{ii}\$ (donde el índice de fila es igual al índice de columna) forman la diagonal principal. Una matriz fila tiene dimensión \$1 \\\\times n\$, mientras que una matriz columna tiene dimensión \$m \\\\times 1\$. Una matriz donde todos sus elementos son cero se denomina matriz nula o matriz cero.\\n\\nSe pueden realizar varias operaciones algebraicas con matrices reales. Dos matrices del mismo orden se pueden sumar o restar elemento a elemento: si \$C = A \\\\pm B\$, entonces \$c_{ij} = a_{ij} \\\\pm b_{ij}\$. La multiplicación de una matriz por un escalar (un número real \$k\$) se realiza multiplicando cada elemento de la matriz por ese escalar: si \$B = kA\$, entonces \$b_{ij} = k \\\\cdot a_{ij}\$.\\n\\nEl producto de dos matrices \$A\$ y \$B\$ solo está definido si el número de columnas de la primera matriz (\$A\$) es igual al número de filas de la segunda matriz (\$B\$). Si \$A\$ es de orden \$m \\\\times p\$ y \$B\$ es de orden \$p \\\\times n\$, el producto \$C = AB\$ es una matriz de orden \$m \\\\times n\$. El elemento \$c_{ij}\$ de la matriz producto se calcula multiplicando cada elemento de la fila \$i\$ de \$A\$ por el elemento correspondiente de la columna \$j\$ de \$B\$ y sumando los resultados: \$c_{ij} = \\\\sum_{k=1}^{p} a_{ik} b_{kj}\$. Es crucial recordar que la multiplicación de matrices, en general, no es conmutativa, es decir, \$AB \\\\neq BA\$.\\n\\nOtra operación importante es la transposición. La matriz transpuesta de una matriz \$A\$ de orden \$m \\\\times n\$, denotada como \$A^T\$, es una matriz de orden \$n \\\\times m\$ que se obtiene intercambiando las filas por las columnas de \$A\$. Es decir, el elemento \$(A^T)_{ij}\$ es igual al elemento \$a_{ji}\$. Las matrices son estructuras de datos esenciales en álgebra lineal y se utilizan para representar sistemas de ecuaciones lineales, transformaciones lineales y datos en general en múltiples disciplinas como la computación, la física, la economía y la estadística.",
    "formula_clave": "A = (a_{ij})_{m \\\\times n}",
    "video_url": ""
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> teoria = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
  
  for (var p in parsed) {
    p['id'] = 't_' + p['codigo_tema'].replaceAll('.', '_');
    // Generar url de youtube dinámicamente
    String query = p['materia'].toString() + ' ' + p['titulo'].toString() + ' bachillerato ecuador';
    String encoded = Uri.encodeComponent(query);
    p['video_url'] = 'https://www.youtube.com/results?search_query=' + encoded;
    
    // Inject or update
    int idx = teoria.indexWhere((t) => t['codigo_tema'] == p['codigo_tema']);
    if (idx != -1) {
      teoria[idx] = p;
    } else {
      teoria.add(p);
    }
  }
  
  File('assets/data/teoria.json').writeAsStringSync(jsonEncode(teoria));
  print('4 Temas inyectados en teoria.json exitosamente.');
}
