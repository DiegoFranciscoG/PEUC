import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Cuál es la molaridad de una disolución que contiene 0,5 moles de soluto en 250 mL de disolución?",
    "opciones": [
      "A) 0,5 M",
      "B) 1,0 M",
      "C) 2,0 M",
      "D) 4,0 M"
    ],
    "respuesta_correcta": "C) 2,0 M",
    "explicacion_detallada": "La molaridad ($M$) se define como los moles de soluto divididos por el volumen de disolución en litros. $M = 0,5 \\text{ mol} / 0,250 \\text{ L} = 2,0 \\text{ M}$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Si se diluyen 50 mL de una disolución de $HCl$ 2 M hasta un volumen final de 200 mL, ¿cuál será la nueva molaridad?",
    "opciones": [
      "A) 0,2 M",
      "B) 0,5 M",
      "C) 1,0 M",
      "D) 1,5 M"
    ],
    "respuesta_correcta": "B) 0,5 M",
    "explicacion_detallada": "Usando la ecuación de dilución $C_1V_1 = C_2V_2$: $(2 \\text{ M})(50 \\text{ mL}) = C_2(200 \\text{ mL})$. Por lo tanto, $C_2 = 100 / 200 = 0,5 \\text{ M}$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué propiedad de una disolución depende del número de partículas de soluto disueltas y no de su naturaleza química?",
    "opciones": [
      "A) Propiedad intensiva",
      "B) Propiedad extensiva",
      "C) Propiedad constitutiva",
      "D) Propiedad coligativa"
    ],
    "respuesta_correcta": "D) Propiedad coligativa",
    "explicacion_detallada": "Las propiedades coligativas (como el descenso crioscópico, aumento ebulloscópico y presión osmótica) dependen únicamente de la concentración de partículas de soluto, no de la identidad del mismo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Cuál es la fracción molar del agua en una mezcla que contiene 1 mol de $NaCl$ y 9 moles de agua?",
    "opciones": [
      "A) 0,1",
      "B) 0,5",
      "C) 0,9",
      "D) 1,0"
    ],
    "respuesta_correcta": "C) 0,9",
    "explicacion_detallada": "La fracción molar es la relación de moles de un componente frente a los moles totales. Fracción molar del agua = $9 / (9 + 1) = 9 / 10 = 0,9$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Cómo se denomina a una disolución que contiene la máxima cantidad de soluto que puede disolverse a una temperatura dada?",
    "opciones": [
      "A) Insaturada",
      "B) Saturada",
      "C) Sobresaturada",
      "D) Diluida"
    ],
    "respuesta_correcta": "B) Saturada",
    "explicacion_detallada": "Una disolución saturada es aquella en la cual se ha disuelto la cantidad máxima posible de soluto en el solvente a una presión y temperatura determinadas, existiendo equilibrio entre el soluto disuelto y el no disuelto."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "La constante ebulloscópica del agua es de $0,512 \\, ^\\circ C/m$. ¿Cuál es el aumento del punto de ebullición para una solución acuosa 1 molal de glucosa (un no electrolito)?",
    "opciones": [
      "A) $0,256 \\, ^\\circ C$",
      "B) $0,512 \\, ^\\circ C$",
      "C) $1,024 \\, ^\\circ C$",
      "D) $100,512 \\, ^\\circ C$"
    ],
    "respuesta_correcta": "B) $0,512 \\, ^\\circ C$",
    "explicacion_detallada": "El aumento del punto de ebullición se calcula mediante $\\Delta T_b = K_b \\cdot m \\cdot i$. Para la glucosa $i=1$ y $m=1$. Así, $\\Delta T_b = 0,512 \\cdot 1 \\cdot 1 = 0,512 \\, ^\\circ C$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Cuál es la normalidad (N) de una solución de ácido sulfúrico ($H_2SO_4$) 0,5 M si actúa como un ácido diprótico?",
    "opciones": [
      "A) 0,25 N",
      "B) 0,5 N",
      "C) 1,0 N",
      "D) 2,0 N"
    ],
    "respuesta_correcta": "C) 1,0 N",
    "explicacion_detallada": "La normalidad es igual a la molaridad multiplicada por el número de equivalentes (hidrógenos en un ácido). Para $H_2SO_4$, hay 2 equivalentes por mol. $N = 0,5 \\text{ M} \\cdot 2 = 1,0 \\text{ N}$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué es la molalidad de una disolución?",
    "opciones": [
      "A) Moles de soluto por litro de solución",
      "B) Gramos de soluto por litro de solución",
      "C) Moles de soluto por kilogramo de solvente",
      "D) Moles de soluto por litro de solvente"
    ],
    "respuesta_correcta": "C) Moles de soluto por kilogramo de solvente",
    "explicacion_detallada": "Por definición, la molalidad ($m$) es la cantidad de soluto (en moles) disuelto por kilogramo ($1000 \\text{ g}$) de solvente puro. Es útil porque, a diferencia de la molaridad, no cambia con la temperatura."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "La solubilidad de un gas en un líquido generalmente aumenta si:",
    "opciones": [
      "A) Disminuye la presión y aumenta la temperatura",
      "B) Aumenta la presión y aumenta la temperatura",
      "C) Disminuye la presión y disminuye la temperatura",
      "D) Aumenta la presión y disminuye la temperatura"
    ],
    "respuesta_correcta": "D) Aumenta la presión y disminuye la temperatura",
    "explicacion_detallada": "Según la Ley de Henry, la solubilidad de un gas aumenta al incrementar la presión sobre el líquido. Además, la disolución de gases suele ser exotérmica, por lo que temperaturas más bajas favorecen su solubilidad."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué ocurre con la presión de vapor de un disolvente cuando se le añade un soluto no volátil?",
    "opciones": [
      "A) Aumenta",
      "B) Disminuye",
      "C) Permanece igual",
      "D) Depende del volumen"
    ],
    "respuesta_correcta": "B) Disminuye",
    "explicacion_detallada": "De acuerdo con la Ley de Raoult, la adición de un soluto no volátil a un disolvente disminuye su presión de vapor, debido a que disminuye la fracción molar del disolvente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Si el factor de van't Hoff ($i$) para una solución acuosa de $NaCl$ asume una disociación completa, ¿cuál es su valor teórico?",
    "opciones": [
      "A) 1",
      "B) 2",
      "C) 3",
      "D) 4"
    ],
    "respuesta_correcta": "B) 2",
    "explicacion_detallada": "El $NaCl$ es un electrolito fuerte que se disocia en dos iones: $Na^+$ y $Cl^-$. Por tanto, asumiendo disociación completa, el factor de van't Hoff teórico es $i = 2$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Cuál de las siguientes disoluciones acuosas 0,1 M tendrá el menor punto de congelación?",
    "opciones": [
      "A) Sacarosa (no electrolito)",
      "B) $NaCl$",
      "C) $CaCl_2$",
      "D) $AlCl_3$"
    ],
    "respuesta_correcta": "D) $AlCl_3$",
    "explicacion_detallada": "El descenso del punto de congelación depende del número de partículas (factor $i$). Sacarosa ($i=1$), $NaCl$ ($i=2$), $CaCl_2$ ($i=3$), $AlCl_3$ ($i=4$). Al tener mayor $i$, el $AlCl_3$ produce el mayor descenso y por tanto el menor punto de congelación."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Una solución se forma al disolver $20 \\text{ g}$ de $NaOH$ (masa molar $= 40 \\text{ g/mol}$) en agua hasta formar $500 \\text{ mL}$ de solución. ¿Cuál es su molaridad?",
    "opciones": [
      "A) 0,5 M",
      "B) 1,0 M",
      "C) 2,0 M",
      "D) 4,0 M"
    ],
    "respuesta_correcta": "B) 1,0 M",
    "explicacion_detallada": "Primero calculamos los moles de $NaOH$: $20 \\text{ g} / 40 \\text{ g/mol} = 0,5 \\text{ moles}$. El volumen es $0,5 \\text{ L}$. Molaridad $= 0,5 \\text{ mol} / 0,5 \\text{ L} = 1,0 \\text{ M}$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué expresa el porcentaje en masa (% m/m) de una disolución?",
    "opciones": [
      "A) Gramos de soluto por cada 100 mililitros de disolución",
      "B) Gramos de soluto por cada 100 gramos de disolvente",
      "C) Gramos de soluto por cada 100 gramos de disolución",
      "D) Mililitros de soluto por cada 100 mililitros de disolución"
    ],
    "respuesta_correcta": "C) Gramos de soluto por cada 100 gramos de disolución",
    "explicacion_detallada": "El porcentaje en masa se define como la masa del soluto dividida por la masa total de la disolución, todo multiplicado por 100. Equivale a gramos de soluto por cada 100 gramos de disolución total."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "La ósmosis es el paso del disolvente puro a través de una membrana semipermeable desde un área de:",
    "opciones": [
      "A) Mayor concentración de soluto a menor concentración de soluto",
      "B) Menor concentración de soluto a mayor concentración de soluto",
      "C) Igual concentración de soluto",
      "D) Soluto sólido a solución líquida"
    ],
    "respuesta_correcta": "B) Menor concentración de soluto a mayor concentración de soluto",
    "explicacion_detallada": "En la ósmosis, el solvente fluye desde el área más diluida (con mayor potencial químico del disolvente y menor de soluto) hacia el área más concentrada para intentar igualar las concentraciones."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Se preparan dos soluciones, una de $KCl$ y otra de glucosa. Ambas tienen la misma molaridad (0,2 M). A la misma temperatura, ¿cómo será la presión osmótica de la solución de $KCl$ en comparación con la de glucosa?",
    "opciones": [
      "A) Aproximadamente la mitad",
      "B) Igual",
      "C) Aproximadamente el doble",
      "D) Aproximadamente el cuádruple"
    ],
    "respuesta_correcta": "C) Aproximadamente el doble",
    "explicacion_detallada": "La presión osmótica es una propiedad coligativa: $\\pi = iMRT$. Para la glucosa $i=1$, para el $KCl$ $i \\approx 2$. Por lo tanto, la presión osmótica del $KCl$ será aproximadamente el doble."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué fórmula matemática describe la ley de Raoult para el componente A en una disolución ideal?",
    "opciones": [
      "A) $P_A = X_A / P_A^o$",
      "B) $P_A = P_A^o \\cdot X_A$",
      "C) $P_A = X_A \\cdot K_b$",
      "D) $P_A = M \\cdot R \\cdot T$"
    ],
    "respuesta_correcta": "B) $P_A = P_A^o \\cdot X_A$",
    "explicacion_detallada": "La ley de Raoult establece que la presión parcial de vapor de un componente en una mezcla ideal ($P_A$) es igual a la presión de vapor del componente puro ($P_A^o$) multiplicada por su fracción molar en la disolución ($X_A$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Calcular los equivalentes químicos (Eq) contenidos en 49 g de ácido sulfúrico ($H_2SO_4$, masa molar $= 98 \\text{ g/mol}$).",
    "opciones": [
      "A) 0,5 Eq",
      "B) 1,0 Eq",
      "C) 2,0 Eq",
      "D) 4,0 Eq"
    ],
    "respuesta_correcta": "B) 1,0 Eq",
    "explicacion_detallada": "Para un ácido diprótico como el $H_2SO_4$, la masa equivalente es masa molar / 2 = 98 / 2 = 49 g/Eq. Entonces, en 49 g hay exactamente 1 equivalente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "¿Qué masa de soluto hay en 200 g de una disolución al 5% en masa?",
    "opciones": [
      "A) 5 g",
      "B) 10 g",
      "C) 20 g",
      "D) 40 g"
    ],
    "respuesta_correcta": "B) 10 g",
    "explicacion_detallada": "Una disolución al 5% en masa significa que hay 5 g de soluto por cada 100 g de disolución. En 200 g de disolución habrá el doble: $5 \\text{ g} \\cdot 2 = 10 \\text{ g}$ de soluto."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.6.1",
    "enunciado": "Si a una solución en equilibrio con soluto no disuelto se le incrementa la temperatura y se observa que más soluto se disuelve, el proceso de disolución es:",
    "opciones": [
      "A) Exotérmico",
      "B) Endotérmico",
      "C) Isotérmico",
      "D) Adiabático"
    ],
    "respuesta_correcta": "B) Endotérmico",
    "explicacion_detallada": "Según el principio de Le Chatelier, si un incremento de temperatura favorece la disolución (el sistema absorbe calor para contrarrestar el aumento), significa que el proceso de disolución absorbe energía, es decir, es endotérmico."
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
  print('20 preguntas inyectadas para el código 3.6.1.');
}
