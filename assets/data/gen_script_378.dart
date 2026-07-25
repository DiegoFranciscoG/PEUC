import 'dart:convert';
import 'dart:io';

void main() {
  final List<Map<String, dynamic>> data = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Considere una espira circular de radio $R$ que transporta una corriente $I$. Si se superpone un campo magnético uniforme $\vec{B} = B_0 \hat{k}$ y la espira yace en el plano $xy$, ¿cuál es la tensión mecánica $T$ en el alambre de la espira asumiendo que tiende a expandirse? Considere el campo autogenerado despreciable.",
      "opciones": [
        r"A) $T = I R B_0$",
        r"B) $T = 2 I R B_0$",
        r"C) $T = \frac{I R B_0}{2}$",
        r"D) $T = \pi I R B_0$"
      ],
      "respuesta_correcta": r"A) $T = I R B_0$",
      "explicacion_detallada": r"La fuerza de Lorentz por unidad de longitud diferencial en la espira es $d\vec{F} = I(d\vec{l} \times \vec{B})$. Esta fuerza apunta radialmente hacia afuera con magnitud $dF = I R d\theta B_0$. Equilibrando las fuerzas en un diferencial de ángulo, la tensión $T$ satisface $2T \sin(d\theta/2) = dF$. Para ángulos pequeños, $2T(d\theta/2) = I R B_0 d\theta$, resultando en $T = I R B_0$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Una carga puntual $q$ se mueve con velocidad relativista $\vec{v} = v\hat{i}$. ¿Cuál es la expresión exacta para el campo magnético $\vec{B}$ generado por esta carga en un punto del espacio dado por el vector de posición $\vec{r}$ desde la carga, teniendo en cuenta la transformación de Lorentz de los campos?",
      "opciones": [
        r"A) $\vec{B} = \frac{\mu_0}{4\pi} \frac{q\vec{v} \times \vec{r}}{r^3}$",
        r"B) $\vec{B} = \frac{1}{c^2} \vec{v} \times \vec{E}$",
        r"C) $\vec{B} = \frac{\mu_0}{4\pi} \frac{q\vec{v} \times \hat{r}}{r^2 \gamma^2 (1 - \beta^2 \sin^2\theta)^{3/2}}$",
        r"D) $\vec{B} = \gamma \frac{\mu_0}{4\pi} \frac{q\vec{v} \times \vec{r}}{r^3}$"
      ],
      "respuesta_correcta": r"B) $\vec{B} = \frac{1}{c^2} \vec{v} \times \vec{E}$",
      "explicacion_detallada": r"Para una carga en movimiento uniforme con cualquier velocidad, el campo magnético y eléctrico están relacionados de forma exacta por $\vec{B} = \frac{1}{c^2} \vec{v} \times \vec{E}$. El campo eléctrico $\vec{E}$ incluye las correcciones relativistas del factor de Liénard-Wiechert para velocidad constante."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Se tiene un cilindro infinito de radio $a$ con una magnetización uniforme $\vec{M} = M_0 \hat{k}$ paralela a su eje. ¿Cuál es el campo magnético $\vec{B}$ en el interior del cilindro?",
      "opciones": [
        r"A) $\vec{B} = \mu_0 M_0 \hat{k}$",
        r"B) $\vec{B} = 0$",
        r"C) $\vec{B} = \frac{\mu_0 M_0}{2} \hat{k}$",
        r"D) $\vec{B} = - \mu_0 M_0 \hat{k}$"
      ],
      "respuesta_correcta": r"A) $\vec{B} = \mu_0 M_0 \hat{k}$",
      "explicacion_detallada": r"Una magnetización uniforme $\vec{M} = M_0 \hat{k}$ equivale a una corriente superficial ligada $\vec{K}_b = \vec{M} \times \hat{n} = M_0 \hat{\phi}$. Esto forma un solenoide ideal infinito con corriente superficial $M_0$. El campo interior es $\vec{B} = \mu_0 K_b \hat{k} = \mu_0 M_0 \hat{k}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cómo se modifica la fuerza electromotriz (FEM) inducida en un disco de Faraday (radio $a$, velocidad angular $\omega$) si se invierte simultáneamente el sentido de rotación y la dirección del campo magnético uniforme $B$ aplicado perpendicular al disco?",
      "opciones": [
        r"A) La FEM invierte su polaridad.",
        r"B) La FEM se hace cero.",
        r"C) La FEM permanece inalterada en magnitud y polaridad.",
        r"D) La magnitud de la FEM se reduce a la mitad."
      ],
      "respuesta_correcta": r"C) La FEM permanece inalterada en magnitud y polaridad.",
      "explicacion_detallada": r"La FEM inducida es $\mathcal{E} = \frac{1}{2} B \omega a^2$. Si se invierte tanto $\omega$ ($\omega \rightarrow -\omega$) como $B$ ($B \rightarrow -B$), el producto $(-\omega)(-B)$ es igual a $\omega B$. Por tanto, la polaridad de la FEM no cambia."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Para un monopolo magnético de carga magnética $g$, el potencial vector $\vec{A}$ exhibe necesariamente una singularidad (cadena de Dirac). Según la condición de cuantización de Dirac, ¿qué relación deben cumplir la carga eléctrica $e$ y la carga magnética $g$?",
      "opciones": [
        r"A) $e g = \frac{n h}{4\pi}$",
        r"B) $e g = n \hbar c$",
        r"C) $e g = \frac{n \mu_0 h}{2}$",
        r"D) $e g = \frac{n \hbar}{2}$"
      ],
      "respuesta_correcta": r"D) $e g = \frac{n \hbar}{2}$",
      "explicacion_detallada": r"La condición de cuantización de Dirac establece que el producto de la carga eléctrica $e$ y la carga magnética (monopolo) $g$ debe satisfacer $e g = \frac{n \hbar}{2}$. Esto proviene de imponer que el efecto de la cuerda de Dirac sea cuánticamente inobservable (fase de Aharonov-Bohm en múltiplos de $2\pi$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Un plasma en equilibrio en un campo magnético obedece la ecuación magnetohidrodinámica estática $\nabla p = \vec{J} \times \vec{B}$. Utilizando la ley de Ampère, esta ecuación puede escribirse para mostrar que la suma de dos presiones es constante a lo largo de ciertas direcciones. ¿Cuáles son estas presiones?",
      "opciones": [
        r"A) La presión térmica $p$ y la tensión magnética $\frac{B^2}{\mu_0}$",
        r"B) La presión térmica $p$ y la presión magnética $\frac{B^2}{2\mu_0}$",
        r"C) La presión magnética $\frac{B^2}{2\mu_0}$ y la presión cinética $\frac{1}{2}\rho v^2$",
        r"D) La presión dinámica estelar y la presión magnética"
      ],
      "respuesta_correcta": r"B) La presión térmica $p$ y la presión magnética $\frac{B^2}{2\mu_0}$",
      "explicacion_detallada": r"Sustituyendo $\vec{J} = \frac{1}{\mu_0}(\nabla \times \vec{B})$, se obtiene $\nabla (p + \frac{B^2}{2\mu_0}) = \frac{1}{\mu_0}(\vec{B} \cdot \nabla)\vec{B}$. Para líneas de campo rectas, el término de tensión (derecha) se anula, indicando que la suma de la presión térmica de las partículas y la presión magnética del campo es constante."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Considere el tensor de esfuerzos de Maxwell para un campo magnético estático en el vacío. ¿Cuál es el significado físico de los signos en los valores propios de dicho tensor?",
      "opciones": [
        r"A) Implica una presión magnética isótropa que empuja hacia afuera en todas direcciones.",
        r"B) El campo magnético ejerce una tracción (tensión) a lo largo de las líneas de campo y una repulsión (presión) perpendicular a ellas.",
        r"C) El tensor no puede tener valores propios negativos.",
        r"D) Indica que la densidad de energía magnética es siempre negativa."
      ],
      "respuesta_correcta": r"B) El campo magnético ejerce una tracción (tensión) a lo largo de las líneas de campo y una repulsión (presión) perpendicular a ellas.",
      "explicacion_detallada": r"El tensor de esfuerzos de Maxwell en magnetostática presenta una tracción positiva $B^2/(2\mu_0)$ paralela a $\vec{B}$, que tiende a contraer las líneas de fuerza, y una presión lateral (perpendicular) negativa $-B^2/(2\mu_0)$ que tiende a separar o repeler las líneas de campo adyacentes."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En la teoría de London del efecto Meissner para un superconductor de tipo I, ¿cuál es la ecuación diferencial que describe la decadencia exponencial del campo magnético superficial, donde $\lambda$ es la longitud de penetración?",
      "opciones": [
        r"A) $\nabla^2 \vec{B} = \lambda^2 \vec{B}$",
        r"B) $\nabla^2 \vec{B} = \frac{1}{\lambda^2} \vec{B}$",
        r"C) $\nabla \times \vec{B} = \frac{1}{\lambda} \vec{B}$",
        r"D) $\nabla \cdot \vec{B} = -\lambda^2 B^2$"
      ],
      "respuesta_correcta": r"B) $\nabla^2 \vec{B} = \frac{1}{\lambda^2} \vec{B}$",
      "explicacion_detallada": r"A partir de la ecuación de London $\nabla \times \vec{J}_s = -\frac{n_s e^2}{m} \vec{B}$ y la ley de Ampère $\nabla \times \vec{B} = \mu_0 \vec{J}_s$, al aplicar el rotacional se llega a $\nabla^2 \vec{B} = \mu_0 \frac{n_s e^2}{m} \vec{B} = \frac{1}{\lambda^2} \vec{B}$. Esta ecuación admite soluciones de tipo $B = B_0 e^{-x/\lambda}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál es el momento dipolar magnético $\vec{m}$ de una esfera maciza de radio $R$ con carga total $Q$ distribuida uniformemente, que rota con velocidad angular $\vec{\omega}$ constante, dada su masa $M$?",
      "opciones": [
        r"A) $\vec{m} = \frac{1}{3} Q R^2 \vec{\omega}$",
        r"B) $\vec{m} = \frac{1}{4} Q R^2 \vec{\omega}$",
        r"C) $\vec{m} = \frac{1}{5} Q R^2 \vec{\omega}$",
        r"D) $\vec{m} = \frac{2}{5} Q R^2 \vec{\omega}$"
      ],
      "respuesta_correcta": r"C) $\vec{m} = \frac{1}{5} Q R^2 \vec{\omega}$",
      "explicacion_detallada": r"Para una distribución de carga esférica uniforme, la relación giromagnética clásica es constante, $\vec{m} = \frac{Q}{2M}\vec{L}$. Dado el momento angular clásico de una esfera sólida $\vec{L} = \frac{2}{5} M R^2 \vec{\omega}$, se obtiene $\vec{m} = \frac{Q}{2M} \left(\frac{2}{5} M R^2 \vec{\omega}\right) = \frac{1}{5} Q R^2 \vec{\omega}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En el efecto Hall cuántico entero, los electrones bidimensionales en un campo magnético intenso llenan niveles de Landau. ¿Cuál es el valor del cuanto elemental de flujo magnético asociado al área efectiva de cada estado cuántico degenerado por nivel de Landau?",
      "opciones": [
        r"A) $\Phi_0 = \frac{h}{e}$",
        r"B) $\Phi_0 = \frac{h c}{e}$",
        r"C) $\Phi_0 = \frac{\hbar}{2e}$",
        r"D) $\Phi_0 = \frac{e}{\mu_0 h}$"
      ],
      "respuesta_correcta": r"A) $\Phi_0 = \frac{h}{e}$",
      "explicacion_detallada": r"La degeneración de un nivel de Landau es $N = \Phi / (h/e)$, lo que implica que cada estado (para un solo fermión o electrón sin aparear) ocupa un flujo de área cuántica de magnitud $\Phi_0 = h/e$. A diferencia de superconductividad, donde el par de Cooper da $\Phi_0 = h/(2e)$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Se tiene un campo magnético espacialmente dependiente $\vec{B} = \alpha z \hat{i} + \beta x \hat{j} + \gamma y \hat{k}$ (con $\alpha, \beta, \gamma \neq 0$). ¿Es éste un campo magnético físicamente admisible según las leyes fundamentales del electromagnetismo clásico estático?",
      "opciones": [
        r"A) Sólo si $\alpha + \beta + \gamma = 0$.",
        r"B) Sí, pues satisface incondicionalmente $\nabla \cdot \vec{B} = 0$.",
        r"C) No, es imposible un campo con dependencias cruzadas puras sin divergencia.",
        r"D) Únicamente en la superficie de un toroide conductor."
      ],
      "respuesta_correcta": r"B) Sí, pues satisface incondicionalmente $\nabla \cdot \vec{B} = 0$.",
      "explicacion_detallada": r"La única restricción fundamental para la existencia de un campo magnético estático es la Ley de Gauss para el magnetismo: la divergencia debe ser cero (ausencia de monopolos). Calculando, $\nabla \cdot \vec{B} = \frac{\partial(\alpha z)}{\partial x} + \frac{\partial(\beta x)}{\partial y} + \frac{\partial(\gamma y)}{\partial z} = 0$. Luego, es admisible."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En una región del espacio donde la densidad de corriente de conducción $\vec{J} = 0$, se define el potencial escalar magnético $\Phi_m$ tal que $\vec{H} = -\nabla \Phi_m$. En un medio lineal con permeabilidad $\mu$, ¿qué ecuación diferencial gobierna $\Phi_m$?",
      "opciones": [
        r"A) Ecuación de Poisson, $\nabla^2 \Phi_m = -\rho_{magnética}$",
        r"B) Ecuación de Laplace, $\nabla^2 \Phi_m = 0$",
        r"C) Ecuación de Helmholtz, $(\nabla^2 + k^2)\Phi_m = 0$",
        r"D) Ecuación de onda electromagnética estática"
      ],
      "respuesta_correcta": r"B) Ecuación de Laplace, $\nabla^2 \Phi_m = 0$",
      "explicacion_detallada": r"Si el medio no contiene corrientes libres ($\vec{J}=0$) y es lineal de modo que $\vec{B} = \mu \vec{H}$ con $\mu$ constante, la condición de divergencia nula $\nabla \cdot \vec{B} = 0$ implica $\nabla \cdot (-\mu \nabla \Phi_m) = 0$, lo que conduce directamente a la ecuación de Laplace estática $\nabla^2 \Phi_m = 0$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"La helicidad magnética $H_M = \int \vec{A} \cdot \vec{B} \, d^3x$ es una magnitud de suma importancia en la física de plasmas. ¿Qué característica del campo magnético cuantifica estrictamente esta integral?",
      "opciones": [
        r"A) La energía magnética libre para reconexión resistiva.",
        r"B) La presión de radiación confinada.",
        r"C) La topología o grado de anudamiento y retorcimiento de los tubos de flujo magnético.",
        r"D) La asimetría quiral del momento magnético anómalo del plasma."
      ],
      "respuesta_correcta": r"C) La topología o grado de anudamiento y retorcimiento de los tubos de flujo magnético.",
      "explicacion_detallada": r"La helicidad magnética es un invariante topológico en la magnetohidrodinámica ideal. Describe cuántas veces las diferentes líneas o tubos de flujo magnético se envuelven o anudan unos alrededor de otros y sobre sí mismos (writhe and twist)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"El factor-g de Landé para un estado atómico acoplado en LS determina el momento magnético efectivo que desdobla los niveles en el efecto Zeeman anómalo. ¿Cuál es su expresión teórica estándar?",
      "opciones": [
        r"A) $g_J = 1 + \frac{J(J+1) - S(S+1) + L(L+1)}{2J(J+1)}$",
        r"B) $g_J = 1 + \frac{J(J+1) + S(S+1) - L(L+1)}{2J(J+1)}$",
        r"C) $g_J = 2 + \frac{L(L+1) - S(S+1)}{J(J+1)}$",
        r"D) $g_J = \frac{3}{2} + \frac{S(S+1) - L(L+1)}{2J(J+1)}$"
      ],
      "respuesta_correcta": r"B) $g_J = 1 + \frac{J(J+1) + S(S+1) - L(L+1)}{2J(J+1)}$",
      "explicacion_detallada": r"Evaluando los momentos magnéticos orbital y de espín con factores $g_L \approx 1$ y $g_S \approx 2$ y proyectándolos sobre la dirección del momento angular total $\vec{J}$, se obtiene este factor espectroscópico de Landé exacto para el efecto Zeeman débil."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En el efecto Aharonov-Bohm, electrones exhiben un corrimiento en su patrón de interferencia al pasar alrededor de un solenoide ideal, a pesar de que la intensidad $\vec{B}$ exterior es nula. Este experimento es evidencia empírica clave para...",
      "opciones": [
        r"A) ...el rompimiento de la simetría CPT en electromagnetismo.",
        r"B) ...la naturaleza fundamental y físicamente observable del potencial vector magnético $\vec{A}$ en la mecánica cuántica.",
        r"C) ...el desdoblamiento espín-órbita de la energía del vacío.",
        r"D) ...la creación de monopolos magnéticos virtuales por polarización del vacío."
      ],
      "respuesta_correcta": r"B) ...la naturaleza fundamental y físicamente observable del potencial vector magnético $\vec{A}$ en la mecánica cuántica.",
      "explicacion_detallada": r"Clásicamente, las fuerzas dependen solo de $\vec{B}$ y $\vec{E}$. Sin embargo, el hamiltoniano de la mecánica cuántica se acopla a $\vec{A}$ explícitamente en el momentum $(\vec{p} - q\vec{A})$. La fase del electrón depende integralmente de $\vec{A}$, lo que permite observar efectos físicos (desfase) aun en regiones donde $\vec{B}=0$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Desde la mecánica estadística puramente clásica, el teorema de Bohr-van Leeuwen hace una predicción rigurosa respecto al momento magnético de cualquier sistema en equilibrio térmico. ¿Cuál es esa predicción?",
      "opciones": [
        r"A) La susceptibilidad magnética clásica debe ser estrictamente paramagnética o ferromagnética, pero nunca diamagnética.",
        r"B) La magnetización total (paramagnética o diamagnética) de un gas clásico en equilibrio termodinámico es idénticamente cero.",
        r"C) El momento magnético medio crece logarítmicamente con el campo aplicado a bajas temperaturas.",
        r"D) Todo material presenta invariablemente una respuesta ferromagnética bajo rotación."
      ],
      "respuesta_correcta": r"B) La magnetización total (paramagnética o diamagnética) de un gas clásico en equilibrio termodinámico es idénticamente cero.",
      "explicacion_detallada": r"El teorema de Bohr-van Leeuwen demuestra que, al integrar la función de partición clásica sobre todos los momentos continuos, la dependencia en el potencial vector magnético $\vec{A}$ desaparece por un cambio de variable exacto (traslación en el espacio de momentos), dejando el sistema ajeno al campo magnético en equilibrio térmico."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuáles son los componentes asociados al campo magnético dentro del tensor electromagnético contravariante $F^{\mu\nu}$ (bajo métrica $+---$ o análoga) en la relatividad especial?",
      "opciones": [
        r"A) Ocupan la submatriz diagonal temporal-espacial simétrica.",
        r"B) Ocupan la parte netamente espacial antisimétrica $F^{ij}$ con $i,j \in \{1,2,3\}$.",
        r"C) Constituyen el trazo escalar relativista $F^\mu_\mu$.",
        r"D) Se encuentran en la columna del tiempo-coordenada acoplados con $\vec{E}$."
      ],
      "respuesta_correcta": r"B) Ocupan la parte netamente espacial antisimétrica $F^{ij}$ con $i,j \in \{1,2,3\}$.",
      "explicacion_detallada": r"El tensor $F^{\mu\nu}$ almacena el campo eléctrico en las componentes temporal-espaciales $F^{0i} = -E_i$ y el campo magnético reside en la matriz puramente espacial de orden 3x3 de forma antisimétrica $F^{ij} = -\epsilon^{ijk}B_k$ (como $-B_z, B_y$, etc.)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Un ión de carga $q$, acelerado por un potencial $V$ desde el reposo, ingresa a una región de selección de velocidades con campo eléctrico $\vec{E}$ y campo magnético $\vec{B}$ mutuamente perpendiculares y ortogonales al movimiento. ¿Cuál es el módulo de $\vec{B}$ requerido para no desviar al ión de masa $m$?",
      "opciones": [
        r"A) $B = \frac{E}{\sqrt{2qV/m}}$",
        r"B) $B = E \sqrt{\frac{m}{2qV}}$",
        r"C) $B = \frac{E}{qV}$",
        r"D) Ambas opciones A y B son matemáticamente idénticas y correctas."
      ],
      "respuesta_correcta": r"D) Ambas opciones A y B son matemáticamente idénticas y correctas.",
      "explicacion_detallada": r"Conservación de la energía dicta $qV = \frac{1}{2}mv^2$, luego $v = \sqrt{2qV/m}$. La fuerza de Lorentz es cero cuando $\vec{F} = q(\vec{E} + \vec{v} \times \vec{B}) = 0$, o bien magnitudes $E = vB$. Por ende $B = E/v = E/\sqrt{2qV/m} = E\sqrt{m/2qV}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En la aproximación cuasiestática ($r \ll \lambda=c/\omega$), ¿cuál es el campo magnético $B(r,t)$ inducido a distancia $r$ por un largo hilo recto portador de corriente de frecuencia baja $I(t) = I_0 \cos(\omega t)$?",
      "opciones": [
        r"A) $B(r,t) = \frac{\mu_0 I_0}{2\pi r} \cos(\omega t - \omega r/c)$",
        r"B) $B(r,t) = \frac{\mu_0 I_0}{2\pi r} \cos(\omega t)$",
        r"C) $B(r,t) = \frac{\mu_0 I_0}{4\pi r^2} \sin(\omega t)$",
        r"D) Se anula por cancelación retardada de fase electromagnética."
      ],
      "respuesta_correcta": r"B) $B(r,t) = \frac{\mu_0 I_0}{2\pi r} \cos(\omega t)$",
      "explicacion_detallada": r"La aproximación cuasiestática descarta los efectos del tiempo de retardo temporal que toma la propagación de la luz ($\omega r/c \approx 0$). De esta manera el campo varía instantáneamente dictado por la ley de Biot-Savart magnetostática pura pero dependiente de $t$ paramétricamente: $\frac{\mu_0 I_0}{2\pi r} \cos(\omega t)$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Para los metales, la susceptibilidad magnética dominante del gas de conducción es el paramagnetismo de Pauli. En comparación con el paramagnetismo clásico o semiclásico (Langevin/Curie), ¿cuál es la dependencia térmica típica de la susceptibilidad de Pauli a temperaturas ordinarias ($T \ll T_{Fermi}$)?",
      "opciones": [
        r"A) Es proporcional a $1/T$ como un aislante de espín localizado.",
        r"B) Es extremadamente dependiente de fluctuaciones, proporcional a $T^2$.",
        r"C) Es positiva e inversamente proporcional a $1/T^{3/2}$.",
        r"D) Es esencialmente independiente de la temperatura, de valor casi constante."
      ],
      "respuesta_correcta": r"D) Es esencialmente independiente de la temperatura, de valor casi constante.",
      "explicacion_detallada": r"Debido al principio de exclusión de Pauli y la degeneración del gas de Fermi metálico, solo los electrones próximos a la superficie de Fermi pueden voltear su espín. La fracción de dichos electrones escala linealmente con $T$, compensando el efecto térmico disruptivo $1/T$ de un espín libre ordinario. Esto lleva a una susceptibilidad $\chi_{Pauli}$ casi independiente de $T$."
    }
  ];

  String jsonStr = jsonEncode(data);
  jsonStr = jsonStr.replaceAll(r'\frac', r'\\frac');

  File file = File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/assets/data/gen_q_378.json');
  file.createSync(recursive: true);
  file.writeAsStringSync(jsonStr);
  print('Escritura exitosa en ' + file.path);
}
