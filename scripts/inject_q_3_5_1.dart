import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué representa una ecuación química?",
    "opciones": [
      "A) La mezcla física de varias sustancias puras.",
      "B) El cambio de estado de una sustancia química.",
      "C) La representación simbólica de una reacción química.",
      "D) La distribución de electrones en un átomo."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Una ecuación química es la representación escrita y simbólica de un proceso real llamado reacción química, donde se muestran los reactivos y los productos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "En la ecuación química $2H_2 + O_2 \\rightarrow 2H_2O$, el número 2 delante de la molécula de $H_2$ y de $H_2O$ se denomina:",
    "opciones": [
      "A) Subíndice",
      "B) Coeficiente estequiométrico",
      "C) Número de oxidación",
      "D) Superíndice"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los números grandes que se colocan delante de las fórmulas en una ecuación química para balancearla se llaman coeficientes estequiométricos e indican la proporción en moles o moléculas."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué principio fundamental debe cumplirse siempre al balancear una ecuación química?",
    "opciones": [
      "A) Ley de las proporciones múltiples.",
      "B) Ley de la conservación de la energía.",
      "C) Ley de los volúmenes de combinación.",
      "D) Ley de la conservación de la masa."
    ],
    "respuesta_correcta": "D",
    "explicacion_detallada": "La ley de la conservación de la masa (Lavoisier) establece que la masa de los reactivos debe ser igual a la masa de los productos, lo que implica que debe haber la misma cantidad de átomos de cada elemento a ambos lados de la ecuación."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué tipo de reacción química representa la siguiente ecuación: $CaCO_3 \\rightarrow CaO + CO_2$?",
    "opciones": [
      "A) Síntesis o combinación",
      "B) Descomposición",
      "C) Desplazamiento simple",
      "D) Doble desplazamiento"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Es una reacción de descomposición porque un solo reactivo ($CaCO_3$) se fragmenta para dar lugar a dos o más productos ($CaO$ y $CO_2$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "En una ecuación química, ¿qué significa el símbolo (ac) o (aq) colocado junto a la fórmula de una sustancia?",
    "opciones": [
      "A) Que la sustancia es un ácido.",
      "B) Que la sustancia está en estado gaseoso.",
      "C) Que la sustancia está disuelta en agua (solución acuosa).",
      "D) Que la reacción es acelerada."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "El subíndice (ac) o (aq) indica que la sustancia se encuentra en solución acuosa, es decir, disuelta en agua."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "La reacción $N_2(g) + 3H_2(g) \\rightarrow 2NH_3(g)$ es un ejemplo clásico de reacción de:",
    "opciones": [
      "A) Doble sustitución",
      "B) Desplazamiento",
      "C) Combustión",
      "D) Síntesis o combinación"
    ],
    "respuesta_correcta": "D",
    "explicacion_detallada": "Es una reacción de síntesis, ya que dos sustancias simples ($N_2$ y $H_2$) se unen para formar un único compuesto más complejo ($NH_3$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "Al balancear la ecuación $Al + O_2 \\rightarrow Al_2O_3$, los coeficientes correctos en el orden dado son:",
    "opciones": [
      "A) 2, 3, 1",
      "B) 4, 3, 2",
      "C) 1, 1, 1",
      "D) 3, 2, 3"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La ecuación balanceada es $4Al + 3O_2 \\rightarrow 2Al_2O_3$. Hay 4 aluminios y 6 oxígenos a ambos lados de la flecha."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué indica el símbolo $\\Delta$ (delta) ubicado sobre la flecha de reacción en una ecuación química?",
    "opciones": [
      "A) Cambio de estado sólido a líquido.",
      "B) Que se requiere calor para que la reacción ocurra.",
      "C) Que la reacción es reversible.",
      "D) La presencia de un catalizador metálico."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "El triángulo o letra griega delta ($\\Delta$) sobre la flecha indica que es necesario aplicar energía térmica (calor) a los reactivos para iniciar o mantener la reacción."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "La reacción $Zn + 2HCl \\rightarrow ZnCl_2 + H_2$ se clasifica como:",
    "opciones": [
      "A) Síntesis",
      "B) Descomposición",
      "C) Sustitución o desplazamiento simple",
      "D) Doble sustitución"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "El zinc (Zn) desplaza al hidrógeno del ácido clorhídrico ($HCl$) para formar cloruro de zinc ($ZnCl_2$) liberando gas hidrógeno ($H_2$). Es un desplazamiento simple."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "Si en una ecuación química observas una flecha hacia abajo ($\\downarrow$) junto a uno de los productos, ¿qué significa?",
    "opciones": [
      "A) Que el producto es un gas que se desprende.",
      "B) Que la temperatura del sistema disminuye.",
      "C) Que el producto forma un precipitado (sólido insoluble).",
      "D) Que la masa del producto es menor que la del reactivo."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "La flecha hacia abajo ($\\downarrow$) indica la formación de un precipitado, que es un sólido insoluble que se separa de la disolución al ocurrir la reacción."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Cuál de las siguientes ecuaciones representa una reacción de neutralización (doble desplazamiento)?",
    "opciones": [
      "A) $C + O_2 \\rightarrow CO_2$",
      "B) $NaOH + HCl \\rightarrow NaCl + H_2O$",
      "C) $2KClO_3 \\rightarrow 2KCl + 3O_2$",
      "D) $Fe + CuSO_4 \\rightarrow FeSO_4 + Cu$"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La reacción entre una base ($NaOH$) y un ácido ($HCl$) para formar sal ($NaCl$) y agua ($H_2O$) es una neutralización, que a su vez es un tipo de reacción de doble desplazamiento."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "En la ecuación de combustión completa del metano: $CH_4 + 2O_2 \\rightarrow CO_2 + 2H_2O$, ¿cuáles son los reactivos?",
    "opciones": [
      "A) $CO_2$ y $H_2O$",
      "B) Solamente $CH_4$",
      "C) Solamente $O_2$",
      "D) $CH_4$ y $O_2$"
    ],
    "respuesta_correcta": "D",
    "explicacion_detallada": "Los reactivos son las sustancias iniciales que se transforman durante la reacción, es decir, las que se encuentran a la izquierda de la flecha: el metano ($CH_4$) y el oxígeno ($O_2$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Por qué nunca se deben alterar los subíndices de las fórmulas químicas al balancear una ecuación?",
    "opciones": [
      "A) Porque es más fácil cambiar los coeficientes.",
      "B) Porque cambiar un subíndice alteraría la identidad de la sustancia química.",
      "C) Porque la ley de conservación de la masa prohíbe cambiar números pequeños.",
      "D) Porque los subíndices solo representan el estado físico de la materia."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los subíndices definen la composición exacta de una molécula. Cambiarlos significa que estamos hablando de una sustancia química completamente distinta (ej. $H_2O$ vs $H_2O_2$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "La reacción de formación del agua es $2H_2(g) + O_2(g) \\rightarrow 2H_2O(l)$. Si disponemos de 4 moléculas de $O_2$, ¿cuántas moléculas de $H_2$ se requieren para reaccionar completamente?",
    "opciones": [
      "A) 2 moléculas",
      "B) 4 moléculas",
      "C) 8 moléculas",
      "D) 10 moléculas"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "La relación estequiométrica según la ecuación balanceada es 2 moléculas de $H_2$ por cada 1 molécula de $O_2$. Por tanto, para 4 moléculas de $O_2$ se necesitan $4 \\times 2 = 8$ moléculas de $H_2$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué indica una doble flecha ($\\rightleftharpoons$) en una ecuación química?",
    "opciones": [
      "A) Que los reactivos y productos son gases.",
      "B) Que la reacción es reversible y puede alcanzar un equilibrio.",
      "C) Que la reacción ocurre a alta presión.",
      "D) Que es una reacción de doble desplazamiento."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La doble flecha indica que la reacción ocurre en ambos sentidos simultáneamente (hacia la derecha y hacia la izquierda), es decir, es una reacción reversible."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "Identifique la ecuación que se encuentra correctamente balanceada:",
    "opciones": [
      "A) $H_2 + Cl_2 \\rightarrow HCl$",
      "B) $N_2 + H_2 \\rightarrow NH_3$",
      "C) $2Mg + O_2 \\rightarrow 2MgO$",
      "D) $K + H_2O \\rightarrow KOH + H_2$"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "En $2Mg + O_2 \\rightarrow 2MgO$, tenemos 2 átomos de Mg y 2 de O tanto en los reactivos como en los productos. Las demás ecuaciones no cumplen con la conservación de la masa."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "Una reacción exotérmica se caracteriza porque en su ecuación química el calor (energía):",
    "opciones": [
      "A) Aparece como un reactivo (absorbe energía).",
      "B) Aparece como un producto (libera energía).",
      "C) No se representa, porque la temperatura se mantiene constante.",
      "D) Siempre es aportado por un catalizador."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "En una reacción exotérmica se libera energía en forma de calor hacia el entorno, por lo que termoquímicamente el calor se puede escribir del lado de los productos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Qué función cumple un catalizador si aparece escrito sobre la flecha en una ecuación química?",
    "opciones": [
      "A) Es un reactivo que se consume completamente para formar el producto.",
      "B) Es un producto secundario no deseado.",
      "C) Acelera o retarda la velocidad de reacción sin consumirse permanentemente.",
      "D) Detiene la reacción química antes de que termine."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Los catalizadores modifican la velocidad de una reacción química (generalmente acelerándola) pero no se consumen en el proceso global, por ello se escriben sobre o debajo de la flecha de reacción."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "Dada la ecuación incompleta: $C_3H_8 + 5O_2 \\rightarrow 3CO_2 + \\_\\_\\_$. ¿Cuál es el compuesto y su coeficiente que falta para completar y balancear la combustión?",
    "opciones": [
      "A) $2H_2O$",
      "B) $4H_2O$",
      "C) $8H_2$",
      "D) $4H_2O_2$"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Para balancear los hidrógenos del propano ($C_3H_8$), necesitamos 8 hidrógenos en los productos. Colocando el coeficiente 4 delante del agua ($4H_2O$) obtenemos $4 \\times 2 = 8$ átomos de hidrógeno, y completa el balance de oxígenos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.5.1",
    "enunciado": "¿Cuál es la suma de los coeficientes estequiométricos de los reactivos y productos en la ecuación balanceada del amoníaco: $N_2 + 3H_2 \\rightarrow 2NH_3$?",
    "opciones": [
      "A) 4",
      "B) 5",
      "C) 6",
      "D) 7"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Los coeficientes en la ecuación balanceada son 1 para $N_2$, 3 para $H_2$ y 2 para $NH_3$. La suma es $1 + 3 + 2 = 6$."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    // Normalizar la respuesta correcta
    String letra = p['respuesta_correcta'].toString().replaceAll(')', '').trim();
    for (var op in p['opciones']) {
      if (op.startsWith(letra + ')')) {
        p['respuesta_correcta'] = op;
        break;
      }
    }
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.5.1.');
}
