import 'dart:convert';
import 'dart:io';

void main() async {
  List<Map<String, dynamic>> temas = [
    {
      "codigo_tema": "3.1.1",
      "materia": "Ciencias Naturales",
      "titulo": "El Método Científico en Ciencias Naturales",
      "contenido_markdown": """### Introducción al Método Científico
El método científico es un proceso riguroso y sistemático utilizado en las ciencias naturales para adquirir nuevos conocimientos, investigar fenómenos y corregir o integrar conocimientos previos. Se basa en la evidencia empírica y la medición, sujeto a principios específicos de razonamiento.

### Pasos del Método Científico
1. **Observación**: Es el primer paso, donde se identifica un fenómeno o problema en la naturaleza. Requiere curiosidad y atención al detalle.
2. **Planteamiento del Problema**: Formulación de una pregunta clara y específica sobre lo observado.
3. **Hipótesis**: Es una posible explicación o respuesta al problema, que debe ser comprobable y falsable. Es una predicción educada.
4. **Experimentación**: Diseño y ejecución de experimentos para poner a prueba la hipótesis. Se deben controlar las variables (independiente, dependiente y de control) para asegurar que los resultados sean válidos.
5. **Análisis de Datos**: Recopilación e interpretación de los datos obtenidos en la experimentación. A menudo se utilizan herramientas estadísticas.
6. **Conclusión**: Determinación de si los datos apoyan o refutan la hipótesis original. Si es refutada, se debe formular una nueva.
7. **Comunicación**: Publicación de los resultados para que la comunidad científica pueda revisar, replicar y validar el estudio.

### Importancia en Biología y Química
En biología, el método científico permite comprender los procesos vitales, desde la genética hasta la ecología, basándose en evidencias tangibles. En química, facilita el descubrimiento de nuevas sustancias, la comprensión de reacciones químicas y el desarrollo de nuevos materiales y medicamentos. 

### Teorías y Leyes Científicas
Cuando una hipótesis ha sido probada repetidamente y sustentada por una gran cantidad de evidencias, puede convertirse en una **teoría científica** (como la teoría de la evolución). Si describe un fenómeno invariable bajo ciertas condiciones, se formula como una **ley científica** (como la ley de la conservación de la masa). Ambas son fundamentales para la estructura del conocimiento en ciencias naturales."""
    },
    {
      "codigo_tema": "3.1.2",
      "materia": "Ciencias Naturales",
      "titulo": "Niveles de Organización de la Materia",
      "contenido_markdown": """### La Estructura de la Materia Viva
La biología y la química estudian la vida y la materia a través de una jerarquía de niveles de organización. Cada nivel es más complejo que el anterior e incluye propiedades emergentes que no están presentes en los niveles inferiores.

### Niveles Abióticos (Sin Vida)
1. **Nivel Subatómico**: Incluye partículas fundamentales como protones, neutrones y electrones. Son la base de toda la materia.
2. **Nivel Atómico**: El átomo es la unidad básica de un elemento químico (ej., Carbono, Oxígeno). Conserva las propiedades químicas del elemento.
3. **Nivel Molecular**: Combinación de dos o más átomos mediante enlaces químicos (ej., $H_2O$, $CO_2$). Incluye macromoléculas vitales como proteínas, ácidos nucleicos, carbohidratos y lípidos.
4. **Nivel Supramolecular u Organular**: Complejos de macromoléculas que forman organelos celulares (ej., mitocondrias, ribosomas, cloroplastos).

### Niveles Bióticos (Con Vida)
5. **Nivel Celular**: La célula es la unidad estructural y funcional básica de la vida. Puede ser procariota o eucariota. Es el primer nivel que exhibe todas las características de la vida.
6. **Nivel Tisular (Tejidos)**: Conjunto de células similares que realizan una función específica (ej., tejido muscular, tejido epitelial).
7. **Nivel Orgánico (Órganos)**: Estructuras compuestas por varios tipos de tejidos que trabajan juntos para realizar funciones complejas (ej., corazón, hojas, raíces).
8. **Nivel Sistémico (Sistemas y Aparatos)**: Grupos de órganos que cooperan para funciones mayores (ej., sistema digestivo, sistema nervioso).
9. **Nivel de Organismo**: El ser vivo individual y completo, ya sea unicelular (bacterias) o multicelular (humanos, plantas).

### Niveles Ecológicos
10. **Población**: Grupo de organismos de la misma especie que viven en un área determinada y se reproducen entre sí.
11. **Comunidad (Biocenosis)**: Interacción de diferentes poblaciones de especies que cohabitan en un entorno.
12. **Ecosistema**: Sistema que incluye a la comunidad biológica y su entorno físico (factores abióticos), y las interacciones entre ellos.
13. **Bioma**: Grandes regiones ecológicas caracterizadas por clima, flora y fauna específicos.
14. **Biosfera**: La suma de todos los ecosistemas de la Tierra, abarcando todas las zonas donde existe vida."""
    },
    {
      "codigo_tema": "3.1.3",
      "materia": "Ciencias Naturales",
      "titulo": "Biomoléculas Inorgánicas: El Agua",
      "contenido_markdown": """### El Agua: La Molécula de la Vida
El agua ($H_2O$) es la biomolécula inorgánica más abundante en los seres vivos, constituyendo entre el 60% y el 90% de la masa celular. Su estructura única le confiere propiedades físicas y químicas esenciales para la vida.

### Estructura Molecular
La molécula de agua está formada por un átomo de oxígeno unido covalentemente a dos átomos de hidrógeno. La alta electronegatividad del oxígeno atrae los electrones compartidos, creando un dipolo eléctrico: una carga parcial negativa en el oxígeno y cargas parciales positivas en los hidrógenos. Esta polaridad permite la formación de **puentes de hidrógeno** entre moléculas de agua.

### Propiedades y Funciones Biológicas
1. **Acción Disolvente Universal**: Gracias a su polaridad, el agua puede disolver una gran variedad de sustancias polares e iónicas. Esto permite que sea el medio donde ocurren casi todas las reacciones metabólicas celulares y el vehículo de transporte de nutrientes y desechos (ej., en la sangre o savia).
2. **Elevado Calor Específico**: El agua puede absorber mucho calor sin aumentar drásticamente su temperatura, actuando como un amortiguador térmico que protege a los organismos de cambios bruscos de temperatura ambiental.
3. **Alto Calor de Vaporización**: La evaporación del agua requiere mucha energía (ruptura de puentes de hidrógeno). Este es el mecanismo principal de refrigeración en muchos animales (sudoración) y plantas (transpiración).
4. **Cohesión y Adhesión**: Los puentes de hidrógeno mantienen unidas las moléculas de agua (cohesión) y permiten que se adhieran a otras superficies (adhesión). Esto es crucial para la capilaridad, que permite el ascenso del agua desde las raíces hasta las hojas en las plantas.
5. **Densidad Anómala**: El agua alcanza su máxima densidad a los 4 °C. El hielo (estado sólido) es menos denso que el agua líquida, por lo que flota. Esto permite que los océanos y lagos no se congelen por completo, protegiendo la vida acuática bajo la capa de hielo en invierno.
6. **Reactividad Química**: El agua participa directamente en reacciones químicas esenciales, como la hidrólisis (ruptura de moléculas con adición de agua) y es un sustrato fundamental en la fotosíntesis."""
    },
    {
      "codigo_tema": "3.2.1",
      "materia": "Ciencias Naturales",
      "titulo": "Biomoléculas Orgánicas: Carbohidratos",
      "contenido_markdown": """### Definición y Composición
Los carbohidratos, también conocidos como glúcidos o hidratos de carbono, son biomoléculas orgánicas compuestas principalmente por carbono (C), hidrógeno (H) y oxígeno (O), generalmente en una proporción de $1:2:1$ ($CH_2O)_n$. Son la fuente primaria y más rápida de energía para los seres vivos.

### Clasificación
1. **Monosacáridos**: Son los azúcares más simples y no se pueden hidrolizar en compuestos más pequeños. 
   - *Ejemplos*: **Glucosa** (combustible principal de las células), **Fructosa** (azúcar de las frutas), **Galactosa**, **Ribosa** y **Desoxirribosa** (componentes de los ácidos nucleicos).
   - Poseen de 3 a 7 átomos de carbono.

2. **Oligosacáridos (Disacáridos)**: Formados por la unión de 2 a 10 monosacáridos mediante enlaces glucosídicos. Los más importantes son los disacáridos (2 monosacáridos).
   - *Ejemplos*: **Sacarosa** (glucosa + fructosa, azúcar de mesa), **Lactosa** (glucosa + galactosa, azúcar de la leche), **Maltosa** (glucosa + glucosa).

3. **Polisacáridos**: Polímeros formados por cientos o miles de monosacáridos unidos. No son dulces ni solubles en agua. Cumplen funciones de reserva energética y estructural.
   - *De reserva*: **Almidón** (reserva en plantas, encontrado en papas y cereales) y **Glucógeno** (reserva en animales, almacenado en hígado y músculos).
   - *Estructurales*: **Celulosa** (forma la pared celular vegetal, indispensable como fibra dietética aunque indigerible para humanos) y **Quitina** (forma el exoesqueleto de artrópodos y la pared celular de los hongos).

### Funciones Biológicas
- **Energética**: La oxidación de la glucosa durante la respiración celular produce ATP (energía).
- **Estructural**: Como la celulosa en las plantas y la quitina en los insectos, proporcionan soporte y protección.
- **Informativa/Reconocimiento**: Los oligosacáridos unidos a proteínas (glucoproteínas) o lípidos (glucolípidos) en la membrana celular actúan como señales de reconocimiento celular, cruciales para el sistema inmunológico.
- **Precursores**: Son la base para la síntesis de otras biomoléculas, como lípidos y aminoácidos."""
    },
    {
      "codigo_tema": "3.2.2",
      "materia": "Ciencias Naturales",
      "titulo": "Biomoléculas Orgánicas: Lípidos",
      "contenido_markdown": """### Definición y Características
Los lípidos son un grupo muy diverso de biomoléculas orgánicas compuestas por C, H y O, y a menudo contienen fósforo (P), nitrógeno (N) y azufre (S). Su característica principal y definitoria es que son altamente **hidrofóbicos** (insolubles en agua) pero solubles en disolventes orgánicos no polares como el éter, cloroformo y benceno.

### Clasificación Principal
1. **Lípidos Saponificables**: Contienen ácidos grasos en su estructura y pueden formar jabones mediante saponificación.
   - **Ácidos Grasos**: Cadenas hidrocarbonadas largas con un grupo carboxilo. Pueden ser **saturados** (enlaces simples, sólidos a temperatura ambiente, ej. grasas animales) o **insaturados** (con dobles enlaces, líquidos a temperatura ambiente, ej. aceites vegetales).
   - **Triglicéridos (Grasas y Aceites)**: Formados por una molécula de glicerol unida a tres ácidos grasos. Su función principal es el almacenamiento de energía a largo plazo y el aislamiento térmico.
   - **Fosfolípidos**: Similares a los triglicéridos pero con un grupo fosfato. Son **anfipáticos** (tienen una cabeza hidrofílica polar y dos colas hidrofóbicas no polares). Son los componentes fundamentales de todas las membranas celulares (bicapa lipídica).
   - **Ceras**: Ésteres de ácidos grasos largos con alcoholes largos. Son altamente impermeables. Protegen la piel y el pelo de los animales, y cubren las hojas y frutos de las plantas.

2. **Lípidos Insaponificables**: No contienen ácidos grasos.
   - **Terpenos**: Como el caroteno (pigmento fotosintético precursor de la vitamina A) y aceites esenciales vegetales (mentol, alcanfor).
   - **Esteroides**: Derivados del esterano. Incluyen el **colesterol** (componente vital de las membranas celulares animales y precursor de otras moléculas), hormonas sexuales (testosterona, estrógenos) y vitaminas (Vitamina D).
   - **Prostaglandinas**: Lípidos derivados de ácidos grasos esenciales que actúan como mediadores celulares (respuesta inflamatoria, coagulación).

### Funciones Biológicas
- **Reserva de Energía**: Aportan más del doble de energía por gramo que los carbohidratos.
- **Estructural**: Los fosfolípidos y el colesterol estructuran las membranas celulares.
- **Biocatalizadora**: En forma de vitaminas lipídicas (A, D, E, K) y hormonas esteroideas, regulan el metabolismo.
- **Protectora/Térmica**: Las grasas subcutáneas aíslan del frío y los lípidos protegen mecánicamente a órganos vitales (ej. riñones)."""
    },
    {
      "codigo_tema": "3.2.3",
      "materia": "Ciencias Naturales",
      "titulo": "Biomoléculas Orgánicas: Proteínas",
      "contenido_markdown": """### Naturaleza de las Proteínas
Las proteínas son las macromoléculas orgánicas más abundantes en las células, compuestas por Carbono, Hidrógeno, Oxígeno y Nitrógeno (C, H, O, N), y a menudo Azufre (S). Son los "caballos de batalla" de la célula, responsables de ejecutar prácticamente todas las funciones dictadas por el ADN.

### Estructura: Aminoácidos y Enlaces
Las proteínas son polímeros formados por la unión de monómeros llamados **aminoácidos**. Existen 20 aminoácidos estándar. Cada uno tiene un grupo amino ($NH_2$), un grupo carboxilo ($COOH$) y un grupo radical o cadena lateral ($R$) que le confiere sus propiedades químicas específicas. Los aminoácidos se unen mediante enlaces covalentes fuertes llamados **enlaces peptídicos**.

### Niveles de Estructura Proteica
La función de una proteína depende de su forma tridimensional, que se organiza en cuatro niveles:
1. **Estructura Primaria**: Es la secuencia lineal de aminoácidos en la cadena polipeptídica. Está determinada genéticamente y dicta los siguientes niveles de estructura.
2. **Estructura Secundaria**: Plegamiento local de la cadena debido a puentes de hidrógeno entre los grupos del enlace peptídico. Las formas más comunes son la alfa-hélice y la lámina beta-plegada.
3. **Estructura Terciaria**: Plegamiento tridimensional global de la proteína, estabilizado por interacciones entre los grupos radicales (R) (puentes disulfuro, interacciones hidrofóbicas, enlaces iónicos). Determina la función biológica específica.
4. **Estructura Cuaternaria**: Presente solo en proteínas formadas por más de una cadena polipeptídica (subunidades), como la hemoglobina.

### Desnaturalización
La exposición a cambios extremos de pH, alta temperatura o sustancias químicas puede romper los enlaces de las estructuras secundaria, terciaria o cuaternaria, haciendo que la proteína pierda su forma y, por consiguiente, su función. A esto se le llama desnaturalización.

### Funciones Principales
1. **Estructural**: El colágeno forma tendones y huesos; la queratina, cabello y uñas.
2. **Catálisis (Enzimas)**: Aceleran enormemente las reacciones químicas celulares (ej., amilasa, pepsina).
3. **Transporte**: La hemoglobina transporta oxígeno en la sangre.
4. **Defensa**: Los anticuerpos (inmunoglobulinas) protegen al cuerpo contra patógenos.
5. **Reguladora/Hormonal**: Hormonas como la insulina y la hormona del crecimiento regulan el metabolismo.
6. **Movimiento**: La actina y miosina son responsables de la contracción muscular."""
    },
    {
      "codigo_tema": "3.3.1",
      "materia": "Ciencias Naturales",
      "titulo": "Ácidos Nucleicos: ADN y ARN",
      "contenido_markdown": """### La Base Molecular de la Herencia
Los ácidos nucleicos son macromoléculas complejas que almacenan y transmiten la información genética de las células. Están compuestos por C, H, O, N y P. Existen dos tipos principales: el Ácido Desoxirribonucleico (ADN) y el Ácido Ribonucleico (ARN).

### Nucleótidos: Los Ladrillos de la Construcción
Los ácidos nucleicos son polímeros de subunidades llamadas **nucleótidos**. Cada nucleótido consta de tres partes:
1. **Un grupo fosfato**: Aporta carga negativa a la molécula.
2. **Un azúcar pentosa**: Desoxirribosa en el ADN y Ribosa en el ARN.
3. **Una base nitrogenada**: Moléculas anulares con nitrógeno. Pueden ser purinas (Adenina y Guanina, de doble anillo) o pirimidinas (Citosina, Timina y Uracilo, de anillo simple).

Los nucleótidos se unen entre sí mediante enlaces **fosfodiéster**, formando largas cadenas o hebras.

### Ácido Desoxirribonucleico (ADN)
- **Función**: Almacena a largo plazo la información genética, es decir, las instrucciones para construir todas las proteínas de un organismo.
- **Estructura**: Modelo de la **doble hélice** (descubierto por Watson y Crick en 1953). Consiste en dos cadenas antiparalelas entrelazadas. Las "barandas" de la escalera son el esqueleto azúcar-fosfato, y los "peldaños" son las bases nitrogenadas enfrentadas unidas por débiles puentes de hidrógeno.
- **Apareamiento de bases**: La Adenina (A) siempre se aparea con la Timina (T) (con 2 puentes H), y la Guanina (G) siempre se aparea con la Citosina (C) (con 3 puentes H). Esta complementariedad es esencial para la replicación exacta del ADN.

### Ácido Ribonucleico (ARN)
- **Función**: Expresa la información genética; traduce el código del ADN en la síntesis de proteínas.
- **Estructura**: Generalmente es de cadena simple (una sola hebra).
- **Bases**: Utiliza Adenina (A), Citosina (C), Guanina (G) y **Uracilo (U)** en lugar de Timina.
- **Tipos principales**:
  - **ARN mensajero (ARNm)**: Copia la información del ADN en el núcleo y la lleva a los ribosomas.
  - **ARN de transferencia (ARNt)**: Transporta los aminoácidos específicos al ribosoma durante la síntesis de proteínas.
  - **ARN ribosómico (ARNr)**: Forma la estructura de los ribosomas junto con proteínas y cataliza la formación del enlace peptídico.

### El Dogma Central de la Biología Molecular
Describe el flujo de la información genética: el ADN se **replica** a sí mismo; el ADN se **transcribe** a ARN; el ARN se **traduce** en proteínas."""
    },
    {
      "codigo_tema": "3.3.2",
      "materia": "Ciencias Naturales",
      "titulo": "Teoría Celular y Organización Procariota",
      "contenido_markdown": """### La Teoría Celular
La invención del microscopio permitió a científicos como Schleiden, Schwann y Virchow establecer la Teoría Celular, uno de los pilares fundamentales de la biología moderna. Sus postulados son:
1. **Unidad Anatómica**: Todos los seres vivos están formados por una o más células.
2. **Unidad Funcional**: La célula es la unidad fisiológica básica de la vida; todas las funciones vitales ocurren dentro de las células.
3. **Unidad de Origen**: Toda célula proviene de la división de una célula preexistente (*omnis cellula e cellula*).
4. **Unidad Genética**: Las células contienen el material hereditario que se transmite a las células hijas.

### Tipos de Organización Celular
Todas las células comparten características básicas: membrana plasmática, citoplasma, ribosomas y material genético (ADN). Sin embargo, se dividen en dos grandes grupos según su complejidad estructural: Procariotas y Eucariotas.

### Estructura de la Célula Procariota
Las células procariotas (del griego *pro*, antes de; *karyon*, núcleo) son más pequeñas, primitivas y menos estructuradas que las eucariotas. Comprenden a las bacterias y arqueas. Son organismos unicelulares.

**Características y Componentes Principales:**
- **Ausencia de Núcleo Verdadero**: El material genético (un solo cromosoma circular de ADN) está concentrado en una región del citoplasma llamada **nucleoide**, sin estar rodeado por una membrana nuclear.
- **Ausencia de Organelos Membranosos**: No poseen mitocondrias, retículo endoplasmático, ni aparato de Golgi.
- **Ribosomas 70S**: Más pequeños que los eucariotas, encargados de la síntesis de proteínas.
- **Plásmidos**: Pequeños anillos de ADN extracromosómico que pueden conferir ventajas, como resistencia a antibióticos.
- **Membrana Plasmática**: Regula el intercambio de sustancias y en bacterias suele contener pliegues llamados mesosomas, involucrados en la respiración y división celular.
- **Pared Celular**: Situada por fuera de la membrana. En bacterias está formada por peptidoglicano (mureína). Da forma y protege contra cambios osmóticos.
- **Cápsula**: Una capa externa viscosa presente en algunas bacterias que proporciona protección adicional (ej., contra fagocitosis).
- **Flagelos y Pili/Fimbrias**: Los flagelos permiten el movimiento (locomoción). Las fimbrias sirven para adherencia a superficies, y los pili sexuales permiten la transferencia de ADN (conjugación)."""
    },
    {
      "codigo_tema": "3.3.3",
      "materia": "Ciencias Naturales",
      "titulo": "Estructura de la Célula Eucariota Animal",
      "contenido_markdown": """### Características Generales Eucariotas
Las células eucariotas (del griego *eu*, verdadero; *karyon*, núcleo) son evolutivamente más avanzadas, grandes y complejas que las procariotas. Conforman a los animales, plantas, hongos y protistas. Su característica distintiva es la **compartimentación**: poseen un núcleo verdadero rodeado por membrana y una variedad de organelos membranosos especializados que dividen el trabajo celular.

### Componentes de la Célula Animal
Las células animales carecen de pared celular y cloroplastos (típicos de plantas). Sus estructuras principales son:

1. **Membrana Plasmática**: Estructura dinámica formada por una bicapa de fosfolípidos con proteínas incrustadas y colesterol (modelo del mosaico fluido). Es selectivamente permeable, regulando la entrada y salida de sustancias y facilitando la comunicación celular.
2. **Citoplasma**: Espacio entre la membrana y el núcleo. Contiene el citosol (líquido acuoso) donde se encuentran suspendidos los organelos.
3. **Citoesqueleto**: Red compleja de filamentos proteicos (microtúbulos, microfilamentos de actina y filamentos intermedios). Proporciona soporte estructural, forma a la célula y dirige el transporte intracelular y el movimiento.
4. **Núcleo**: El centro de control celular. Contiene la cromatina (ADN más proteínas histonas). Está envuelto por la envoltura nuclear (con poros nucleares). En su interior está el **nucléolo**, donde se sintetizan los ribosomas.
5. **Retículo Endoplasmático (RE)**:
   - **RE Rugoso (RER)**: Tiene ribosomas adheridos. Su función es sintetizar y modificar proteínas destinadas a secreción o a la membrana.
   - **RE Liso (REL)**: Sin ribosomas. Sintetiza lípidos (como hormonas esteroides) y desintoxica fármacos y venenos (muy abundante en el hígado).
6. **Aparato de Golgi**: Sistema de sacos membranosos aplanados (cisternas). Recibe proteínas y lípidos del RE, los modifica (ej. glucosilación), empaqueta en vesículas y los distribuye a sus destinos finales.
7. **Mitocondrias**: Son las "centrales energéticas" de la célula. Poseen doble membrana y su propio ADN. En ellas ocurre la **respiración celular aerobica**, produciendo la mayor parte del ATP celular.
8. **Lisosomas**: Vesículas formadas por el aparato de Golgi que contienen potentes enzimas digestivas. Realizan la digestión intracelular, degradando nutrientes, bacterias ingeridas y organelos viejos (autofagia).
9. **Centrosomas y Centríolos**: Estructuras tubulares exclusivas de las células animales (ausentes en plantas superiores) que organizan los microtúbulos y son cruciales para la formación del huso acromático durante la división celular."""
    },
    {
      "codigo_tema": "3.4.1",
      "materia": "Ciencias Naturales",
      "titulo": "Estructura de la Célula Eucariota Vegetal",
      "contenido_markdown": """### Célula Vegetal vs. Célula Animal
Las células vegetales también son eucariotas y comparten la mayoría de los organelos con las células animales (núcleo, mitocondrias, retículo endoplasmático, aparato de Golgi -llamado dictiosoma en plantas-). Sin embargo, han desarrollado estructuras exclusivas que les permiten llevar un estilo de vida autrótofo (producir su propio alimento) e inmóvil.

### Estructuras Exclusivas de la Célula Vegetal

1. **Pared Celular**:
   - Estructura rígida localizada por fuera de la membrana plasmática.
   - Está compuesta principalmente por **celulosa**, un polisacárido estructural complejo.
   - **Función**: Proporciona soporte mecánico, mantiene la forma de la célula, evita que la célula estalle en medios hipotónicos (turgencia) y protege contra patógenos. Las células se comunican entre sí a través de canales que atraviesan las paredes celulares, llamados plasmodesmos.

2. **Plastos o Plastidios**:
   - Organelos limitados por doble membrana, con ADN propio, característicos de plantas y algas.
   - **Cloroplastos**: Los plastos más importantes. Contienen el pigmento verde **clorofila**. Son el sitio donde ocurre la **fotosíntesis**, transformando la energía solar en energía química (glucosa). Poseen estructuras internas como los tilacoides (donde está la clorofila) apilados en granas, y un líquido llamado estroma.
   - **Cromoplastos**: Almacenan otros pigmentos (rojos, naranjas, amarillos) que dan color a flores y frutos para atraer polinizadores y dispersores de semillas.
   - **Leucoplastos/Amiloplastos**: Plastos incoloros especializados en almacenar reservas alimenticias, especialmente almidón, en raíces y tubérculos (como la papa).

3. **Gran Vacuola Central**:
   - En una célula vegetal madura, suele haber una sola vacuola enorme que puede ocupar hasta el 90% del volumen celular. Está rodeada por una membrana llamada tonoplasto.
   - **Funciones**: 
     - **Almacenamiento**: Guarda agua, nutrientes, sales, pigmentos e incluso sustancias tóxicas de desecho.
     - **Turgencia**: Al llenarse de agua, ejerce presión hidrostática contra la pared celular, proporcionando rigidez a las partes blandas de la planta (hojas y tallos jóvenes). Si la vacuola pierde agua, la planta se marchita.
     - Funciona de manera similar a los lisosomas animales, conteniendo enzimas hidrolíticas para degradar componentes."""
    },
    {
      "codigo_tema": "3.4.2",
      "materia": "Ciencias Naturales",
      "titulo": "Metabolismo Celular: Anabolismo y Catabolismo",
      "contenido_markdown": """### El Dinamismo de la Vida: Metabolismo
El metabolismo celular es el conjunto de todas las reacciones químicas catalizadas por enzimas que ocurren dentro de una célula. Estas reacciones están altamente organizadas en rutas metabólicas secuenciales. Su propósito principal es mantener la vida, permitiendo a la célula crecer, reproducirse, responder a estímulos y mantener sus estructuras. El metabolismo gestiona tanto la materia como la energía celular.

El metabolismo se divide en dos fases o procesos complementarios y opuestos: el anabolismo y el catabolismo.

### Catabolismo: Fase Destructiva
- **Definición**: Son las rutas metabólicas de **degradación**. Las moléculas orgánicas complejas y ricas en energía (carbohidratos, lípidos, proteínas) se rompen en moléculas más simples y pobres en energía (como $CO_2$, $H_2O$, amoníaco).
- **Flujo de Energía**: Son reacciones **exergónicas**, lo que significa que liberan la energía química almacenada en los enlaces de las macromoléculas.
- **Función Principal**: Proveer la energía necesaria para las actividades celulares. La energía liberada se captura y almacena temporalmente en los enlaces de alta energía de la molécula de **ATP** (Adenosín Trifosfato), la "moneda energética" de la célula.
- **Naturaleza Química**: Son procesos esencialmente oxidativos (pérdida de electrones).
- **Ejemplos**: La **Respiración Celular** (oxidación de glucosa), la digestión, la fermentación y la glucogenólisis (ruptura del glucógeno).

### Anabolismo: Fase Constructiva
- **Definición**: Son las rutas metabólicas de **síntesis** o construcción. Las moléculas precursoras simples (monómeros como aminoácidos, monosacáridos, nucleótidos) se ensamblan para construir macromoléculas celulares complejas (proteínas, polisacáridos, ácidos nucleicos, lípidos).
- **Flujo de Energía**: Son reacciones **endergónicas**, es decir, consumen energía. Requieren un aporte constante de energía, la cual es proporcionada por la hidrólisis del ATP generado durante el catabolismo.
- **Función Principal**: Crecimiento celular, renovación de estructuras y tejidos celulares dañados, y almacenamiento de reservas energéticas.
- **Naturaleza Química**: Son procesos esencialmente reductivos (ganancia de electrones e hidrógeno).
- **Ejemplos**: La **Fotosíntesis** (síntesis de glucosa a partir de $CO_2$ y agua), la síntesis de proteínas (traducción), la replicación del ADN y la síntesis de glucógeno.

### Acoplamiento Energético
Anabolismo y catabolismo están estrechamente interconectados. La energía liberada por las reacciones catabólicas es indispensable para impulsar las reacciones anabólicas. El intermediario clave en este flujo de energía constante es el sistema ATP/ADP."""
    },
    {
      "codigo_tema": "3.4.3",
      "materia": "Ciencias Naturales",
      "titulo": "Respiración Celular y Fotosíntesis (Fundamentos)",
      "contenido_markdown": """### Obtención de Energía en los Seres Vivos
La vida en la Tierra depende del flujo de energía, que fluye desde el sol, pasa por los organismos autótrofos y luego a los heterótrofos. Los dos procesos metabólicos más fundamentales para la vida son la fotosíntesis y la respiración celular.

### Fotosíntesis: Capturando la Energía Solar
Es el proceso anabólico por el cual los organismos fotoautótrofos (plantas, algas y cianobacterias) convierten la energía luminosa del sol en energía química almacenada en los enlaces de la glucosa. Ocurre en los **cloroplastos**.
**Ecuación General**: $6CO_2 + 6H_2O + Energía Luminosa \rightarrow C_6H_{12}O_6 (Glucosa) + 6O_2$

Se divide en dos fases:
1. **Fase Luminosa (Dependiente de la luz)**: Ocurre en la membrana de los tilacoides. La luz excita a la clorofila, lo que provoca la **fotólisis del agua** (ruptura del agua liberando $O_2$ como desecho). La energía se usa para generar **ATP** y moléculas reductoras **NADPH**.
2. **Fase Oscura (Ciclo de Calvin)**: Ocurre en el estroma del cloroplasto. No requiere luz directamente. Utiliza el ATP y el NADPH producidos en la fase luminosa para "fijar" el $CO_2$ atmosférico y construir azúcares simples como la glucosa.

### Respiración Celular Aeróbica: Liberando la Energía
Es el proceso catabólico por el cual casi todos los seres vivos eucariotas (y muchos procariotas) descomponen la glucosa en presencia de oxígeno para extraer su energía y producir ATP. Ocurre principalmente en las **mitocondrias**.
**Ecuación General**: $C_6H_{12}O_6 + 6O_2 \rightarrow 6CO_2 + 6H_2O + ATP (\approx 36-38 moléculas)$

Comprende tres etapas principales:
1. **Glucólisis**: Ocurre en el citoplasma. Una molécula de glucosa (6 carbonos) se rompe en dos moléculas de piruvato (3 carbonos). Produce una ganancia neta de 2 ATP y 2 NADH. No requiere oxígeno.
2. **Ciclo de Krebs (Ciclo del Ácido Cítrico)**: Ocurre en la matriz mitocondrial. El piruvato se descompone completamente hasta $CO_2$. Su objetivo principal es arrancar electrones de alta energía para cargar portadores (NADH y FADH2). Produce 2 ATP.
3. **Cadena de Transporte de Electrones y Fosforilación Oxidativa**: Ocurre en la membrana mitocondrial interna (crestas). Los electrones transportados por NADH y FADH2 caen a través de proteínas de membrana, liberando gran cantidad de energía que se usa para bombear protones. Este gradiente impulsa a la enzima ATP sintasa para generar la mayor parte del ATP (aprox. 32-34). El **oxígeno es el aceptor final de los electrones**, uniéndose a hidrógenos para formar el agua resultante."""
    }
  ];

  String jsonString = jsonEncode(temas);

  final file = File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/assets/data/gen_t_cn1.json');
  // Asegurarnos que el directorio exista
  if (!await file.parent.exists()) {
    await file.parent.create(recursive: true);
  }
  
  await file.writeAsString(jsonString);
  print('JSON escrito exitosamente.');
}
