import 'dart:convert';
import 'dart:io';

void main() async {
  List<Map<String, dynamic>> data = [
    {
      "codigo_tema": "3.5.1",
      "materia": "Ciencias Naturales",
      "titulo": "Cinemática: Movimiento Rectilíneo",
      "contenido_markdown": "### Introducción\nLa cinemática es la rama de la física que describe el movimiento de los objetos sólidos sin considerar las causas que lo originan (las fuerzas) y se limita, principalmente, al estudio de la trayectoria en función del tiempo. Para ello utiliza velocidades y aceleraciones, que describen cómo cambia la posición en función del tiempo.\n\n### Conceptos Clave\n1. **Posición y Desplazamiento**: La posición indica el lugar de un objeto. El desplazamiento es el cambio de posición.\n2. **Velocidad y Rapidez**: La velocidad es un vector que indica qué tan rápido cambia la posición. La rapidez es la magnitud de la velocidad.\n3. **Aceleración**: Mide la tasa de cambio de la velocidad en el tiempo.\n\n### Fórmulas y Ejemplos Resueltos\n- **MRU (Movimiento Rectilíneo Uniforme)**: `x = x0 + v*t`\n- **MRUV (Movimiento Rectilíneo Uniformemente Variado)**: `x = x0 + v0*t + (1/2)*a*t^2`, `v = v0 + a*t`\n\n**Ejemplo**: Un automóvil parte del reposo y acelera a 2 m/s² durante 5 segundos. ¿Cuál es su velocidad final y distancia recorrida?\n- `v = 0 + 2*5 = 10 m/s`\n- `x = 0 + 0 + (1/2)*2*(5)^2 = 25 m`\n"
    },
    {
      "codigo_tema": "3.5.2",
      "materia": "Ciencias Naturales",
      "titulo": "Dinámica: Leyes de Newton",
      "contenido_markdown": "### Introducción\nLa dinámica es la parte de la física que estudia la relación entre las fuerzas que actúan sobre un cuerpo y los efectos que se producirán sobre el movimiento de ese cuerpo. Isaac Newton formuló tres leyes fundamentales que describen esta relación.\n\n### Conceptos Clave\n1. **Primera Ley (Inercia)**: Todo cuerpo persevera en su estado de reposo o movimiento uniforme y rectilíneo a no ser que sea obligado a cambiar su estado por fuerzas impresas sobre él.\n2. **Segunda Ley (Fuerza y Aceleración)**: El cambio de movimiento es directamente proporcional a la fuerza motriz impresa y ocurre según la línea recta a lo largo de la cual aquella fuerza se imprime.\n3. **Tercera Ley (Acción y Reacción)**: Con toda acción ocurre siempre una reacción igual y contraria.\n\n### Fórmulas y Ejemplos Resueltos\n- **Ecuación fundamental de la dinámica**: `F = m * a`\n- **Peso**: `P = m * g`\n\n**Ejemplo**: ¿Qué fuerza se debe aplicar a un cuerpo de 10 kg para que alcance una aceleración de 3 m/s²?\n- `F = 10 kg * 3 m/s² = 30 N`\n"
    },
    {
      "codigo_tema": "3.5.3",
      "materia": "Ciencias Naturales",
      "titulo": "Trabajo, Energía y Potencia",
      "contenido_markdown": "### Introducción\nEn física, el trabajo y la energía son conceptos estrechamente relacionados. La energía es la capacidad de realizar un trabajo, y el trabajo es la transferencia de energía a través de la aplicación de una fuerza a lo largo de una distancia.\n\n### Conceptos Clave\n1. **Trabajo (W)**: Se realiza cuando una fuerza desplaza un objeto.\n2. **Energía Cinética (Ec)**: Energía asociada al movimiento de un cuerpo.\n3. **Energía Potencial (Ep)**: Energía asociada a la posición de un cuerpo dentro de un campo de fuerzas conservativo (como la gravedad).\n4. **Potencia (P)**: Es la rapidez con la que se realiza un trabajo o se transfiere energía.\n\n### Fórmulas y Ejemplos Resueltos\n- **Trabajo**: `W = F * d * cos(θ)`\n- **Energía Cinética**: `Ec = (1/2) * m * v^2`\n- **Energía Potencial Gravitatoria**: `Ep = m * g * h`\n- **Potencia**: `P = W / t`\n\n**Ejemplo**: Un bloque de 2 kg se deja caer desde una altura de 5 m. ¿Cuál es su energía potencial inicial?\n- `Ep = 2 kg * 9.8 m/s² * 5 m = 98 J`\n"
    },
    {
      "codigo_tema": "3.6.1",
      "materia": "Ciencias Naturales",
      "titulo": "Estructura Atómica y Modelos Atómicos",
      "contenido_markdown": "### Introducción\nLa materia está compuesta por átomos, que son las unidades fundamentales de los elementos químicos. A lo largo de la historia, la comprensión de la estructura del átomo ha evolucionado a través de varios modelos propuestos por distintos científicos.\n\n### Conceptos Clave\n1. **Partículas Subatómicas**: Protones (carga positiva), neutrones (sin carga) y electrones (carga negativa).\n2. **Núcleo y Corteza**: El núcleo concentra casi toda la masa (protones y neutrones). La corteza contiene a los electrones orbitando.\n3. **Modelos Atómicos**: Desde Dalton (esferas indivisibles), Thomson (budín de pasas), Rutherford (núcleo pequeño y denso), hasta Bohr (órbitas cuantizadas) y el modelo mecano-cuántico actual.\n\n### Fórmulas y Ejemplos Resueltos\n- **Número Atómico (Z)**: Número de protones.\n- **Número Másico (A)**: Suma de protones y neutrones (`A = Z + N`).\n\n**Ejemplo**: Un átomo tiene Z = 11 y A = 23. ¿Cuántos protones, neutrones y electrones tiene (siendo neutro)?\n- Protones = Z = 11\n- Electrones = 11 (por ser neutro)\n- Neutrones = A - Z = 23 - 11 = 12\n"
    },
    {
      "codigo_tema": "3.6.2",
      "materia": "Ciencias Naturales",
      "titulo": "Tabla Periódica de los Elementos",
      "contenido_markdown": "### Introducción\nLa tabla periódica es una disposición de los elementos químicos en forma de tabla, ordenados por su número atómico, por su configuración de electrones y sus propiedades químicas. Muestra tendencias periódicas, como elementos con comportamiento similar en la misma columna.\n\n### Conceptos Clave\n1. **Grupos y Períodos**: Las columnas son grupos (familias) y las filas son períodos.\n2. **Metales, No Metales y Metaloides**: Propiedades distintivas (conductividad, brillo, maleabilidad).\n3. **Propiedades Periódicas**: Electronegatividad (tendencia a atraer electrones), Radio atómico (distancia del núcleo al electrón más externo), Energía de ionización (energía requerida para arrancar un electrón).\n\n### Fórmulas y Ejemplos Resueltos\nLa electronegatividad aumenta hacia arriba y hacia la derecha en la tabla periódica. El flúor (F) es el elemento más electronegativo.\n\n**Ejemplo**: Compare el radio atómico entre el Sodio (Na) y el Cloro (Cl) en el mismo período.\n- El Sodio tiene mayor radio atómico porque, a medida que se avanza hacia la derecha en un período, el aumento de la carga nuclear atrae más fuertemente a los electrones, disminuyendo el tamaño del átomo.\n"
    },
    {
      "codigo_tema": "3.6.3",
      "materia": "Ciencias Naturales",
      "titulo": "Enlaces Químicos e Interacciones",
      "contenido_markdown": "### Introducción\nLos enlaces químicos son las fuerzas que mantienen unidos a los átomos en las moléculas o compuestos. Los átomos se unen para alcanzar una configuración electrónica más estable, generalmente completando ocho electrones en su capa de valencia (regla del octeto).\n\n### Conceptos Clave\n1. **Enlace Iónico**: Transferencia completa de electrones de un átomo (metal) a otro (no metal), formando iones positivos (cationes) y negativos (aniones).\n2. **Enlace Covalente**: Compartición de pares de electrones entre átomos no metálicos. Puede ser polar o apolar.\n3. **Enlace Metálico**: Atracción electrostática entre cationes metálicos y un 'mar' de electrones deslocalizados.\n4. **Fuerzas Intermoleculares**: Puentes de hidrógeno, fuerzas de Van der Waals, etc.\n\n### Fórmulas y Ejemplos Resueltos\nLa diferencia de electronegatividad (ΔEN) permite predecir el tipo de enlace: \n- ΔEN > 1.7 (Iónico)\n- 0.4 < ΔEN < 1.7 (Covalente polar)\n- ΔEN < 0.4 (Covalente apolar)\n\n**Ejemplo**: ¿Qué tipo de enlace se forma entre Na (EN=0.9) y Cl (EN=3.0)?\n- ΔEN = 3.0 - 0.9 = 2.1 (Enlace Iónico).\n"
    },
    {
      "codigo_tema": "3.7.1",
      "materia": "Ciencias Naturales",
      "titulo": "Estequiometría y Reacciones Químicas",
      "contenido_markdown": "### Introducción\nLa estequiometría es el cálculo de las relaciones cuantitativas entre los reactivos y productos en el transcurso de una reacción química. Se basa en el principio de conservación de la masa propuesto por Lavoisier.\n\n### Conceptos Clave\n1. **Mol y Número de Avogadro**: Un mol contiene 6.022 × 10²³ entidades elementales.\n2. **Masa Molar**: Masa de un mol de sustancia (g/mol).\n3. **Balanceo de Ecuaciones**: Asegurar que haya el mismo número de átomos de cada elemento en reactivos y productos.\n4. **Reactivo Limitante**: El reactivo que se consume completamente y determina la cantidad de producto formado.\n\n### Fórmulas y Ejemplos Resueltos\n- `n = m / M` (donde n son los moles, m la masa, M la masa molar).\n\n**Ejemplo**: Dada la reacción balanceada `2H2 + O2 -> 2H2O`. Si reaccionan 4 moles de H2 con exceso de O2, ¿cuántos moles de agua se producen?\n- Según la estequiometría (relación 2:2), se producirán exactamente 4 moles de H2O.\n"
    },
    {
      "codigo_tema": "3.7.2",
      "materia": "Ciencias Naturales",
      "titulo": "Disoluciones Químicas",
      "contenido_markdown": "### Introducción\nUna disolución (o solución) es una mezcla homogénea a nivel molecular o iónico de dos o más sustancias que no reaccionan entre sí. La sustancia presente en mayor proporción es el disolvente y la de menor proporción es el soluto.\n\n### Conceptos Clave\n1. **Concentración**: Relación entre la cantidad de soluto y la cantidad de disolvente o solución.\n2. **Molaridad (M)**: Moles de soluto por litro de solución.\n3. **Molalidad (m)**: Moles de soluto por kilogramo de disolvente.\n4. **Porcentaje en Masa/Volumen**: Masa o volumen del soluto respecto a la masa o volumen total.\n\n### Fórmulas y Ejemplos Resueltos\n- **Molaridad**: `M = n_soluto / V_solución(L)`\n\n**Ejemplo**: Se disuelven 20 g de NaOH (Masa Molar = 40 g/mol) en suficiente agua para obtener 500 mL (0.5 L) de disolución. Calcule la molaridad.\n- `n = 20 g / 40 g/mol = 0.5 moles`\n- `M = 0.5 moles / 0.5 L = 1.0 M` (1 Molar)\n"
    },
    {
      "codigo_tema": "3.7.3",
      "materia": "Ciencias Naturales",
      "titulo": "Ácidos y Bases: pH y pOH",
      "contenido_markdown": "### Introducción\nLos ácidos y bases son compuestos químicos con características opuestas. Diversas teorías (Arrhenius, Brønsted-Lowry, Lewis) explican su comportamiento. La escala de pH es utilizada para medir la acidez o basicidad de una disolución acuosa.\n\n### Conceptos Clave\n1. **Teoría de Brønsted-Lowry**: Ácido es un donador de protones (H+); Base es un aceptor de protones.\n2. **Escala de pH**: Va de 0 a 14 en agua a 25 °C. pH < 7 es ácido, pH = 7 es neutro, pH > 7 es básico.\n3. **Autoionización del agua**: El agua pura se disocia levemente en iones H+ y OH-.\n\n### Fórmulas y Ejemplos Resueltos\n- `pH = -log[H+]`\n- `pOH = -log[OH-]`\n- `pH + pOH = 14` (a 25 °C)\n\n**Ejemplo**: Calcule el pH de una disolución de HCl con una concentración de 0.01 M.\n- Dado que el HCl es un ácido fuerte, se disocia completamente: `[H+] = 0.01 M = 10^-2 M`.\n- `pH = -log(10^-2) = 2`.\n"
    },
    {
      "codigo_tema": "3.7.4",
      "materia": "Ciencias Naturales",
      "titulo": "Biología Celular: Estructura y Función",
      "contenido_markdown": "### Introducción\nLa célula es la unidad morfológica y funcional de todo ser vivo. De hecho, la célula es el elemento de menor tamaño que puede considerarse vivo.\n\n### Conceptos Clave\n1. **Procariotas y Eucariotas**: Las procariotas carecen de núcleo definido (ej. bacterias). Las eucariotas tienen núcleo y organelos membranosos (animales, plantas).\n2. **Membrana Plasmática**: Regula el intercambio de sustancias.\n3. **Citoplasma y Organelos**: Mitocondrias (respiración celular), Ribosomas (síntesis de proteínas), Cloroplastos (fotosíntesis, solo en vegetales).\n4. **Núcleo**: Almacena el material genético (ADN).\n\n### Fórmulas y Ejemplos Resueltos\nNo aplican fórmulas matemáticas directas, pero es vital comprender el proceso de la fotosíntesis como reacción:\n- `6CO2 + 6H2O + luz -> C6H12O6 + 6O2`\n\n**Ejemplo Conceptual**: ¿Por qué las células vegetales tienen pared celular y las animales no?\n- La pared celular provee soporte estructural y rigidez que las plantas necesitan para crecer sin un sistema óseo, además de evitar la lisis celular al absorber agua.\n"
    },
    {
      "codigo_tema": "3.7.5",
      "materia": "Ciencias Naturales",
      "titulo": "Genética y Herencia",
      "contenido_markdown": "### Introducción\nLa genética es la rama de la biología que estudia cómo los caracteres hereditarios se transmiten de generación en generación. Gregor Mendel sentó las bases de la genética clásica.\n\n### Conceptos Clave\n1. **ADN y Genes**: El gen es un segmento de ADN que codifica para una proteína o función específica.\n2. **Alelos**: Diferentes variantes de un gen. Pueden ser dominantes o recesivos.\n3. **Genotipo y Fenotipo**: El genotipo es la constitución genética; el fenotipo es la expresión física observable.\n4. **Leyes de Mendel**: 1) Ley de la uniformidad, 2) Ley de la segregación, 3) Ley de la segregación independiente.\n\n### Fórmulas y Ejemplos Resueltos\nCuadro de Punnett: Herramienta para predecir proporciones genotípicas y fenotípicas.\n\n**Ejemplo**: Cruce entre dos heterocigotos (Aa x Aa) para el color de semilla (A = amarillo, a = verde).\n- Gametos: A, a y A, a.\n- Cuadro de Punnett: AA (25%), Aa (50%), aa (25%).\n- Fenotipo: 75% semillas amarillas, 25% semillas verdes.\n"
    },
    {
      "codigo_tema": "3.7.8",
      "materia": "Ciencias Naturales",
      "titulo": "Evolución y Biodiversidad",
      "contenido_markdown": "### Introducción\nLa evolución es el cambio en las características fenotípicas y genéticas de poblaciones biológicas a través de generaciones. Ha originado la diversidad de formas de vida que existen sobre la Tierra a partir de un antepasado común.\n\n### Conceptos Clave\n1. **Selección Natural**: Mecanismo evolutivo propuesto por Charles Darwin. Los individuos mejor adaptados a su entorno tienen más probabilidades de sobrevivir y reproducirse.\n2. **Mutación**: Cambios aleatorios en el ADN que generan nueva variabilidad genética.\n3. **Deriva Genética**: Cambios en la frecuencia alélica de una población debido al azar.\n4. **Especiación**: Proceso mediante el cual una población de una determinada especie da lugar a otra u otras especies.\n\n### Fórmulas y Ejemplos Resueltos\nEcuación de Hardy-Weinberg (Frecuencias alélicas en equilibrio):\n- `p^2 + 2pq + q^2 = 1` y `p + q = 1` (donde p y q son frecuencias alélicas).\n\n**Ejemplo**: Si en una población el 9% (0.09) muestra un rasgo recesivo (q^2), halle la frecuencia del alelo recesivo q.\n- `q = √0.09 = 0.3` (30%).\n"
    }
  ];

  String jsonData = jsonEncode(data);
  File file = File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/assets/data/gen_t_cn2.json');
  
  if (!await file.parent.exists()) {
    await file.parent.create(recursive: true);
  }
  
  await file.writeAsString(jsonData);
  print('JSON file successfully generated at \${file.path}');
}
