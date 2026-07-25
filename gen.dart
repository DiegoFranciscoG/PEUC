import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> questions = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Un proyectil se lanza en un medio con resistencia del aire proporcional a la velocidad ($\vec{F}_d = -b\vec{v}$). Si la velocidad límite vertical es $v_t = \frac{mg}{b}$, ¿cuál es la ecuación paramétrica para la posición horizontal $x(t)$ asumiendo una velocidad inicial $v_0$ y ángulo de lanzamiento $\theta$?",
      "opciones": [
        r"$\frac{v_0 \cos\theta \cdot v_t}{g} \left(1 - e^{-\frac{gt}{v_t}}\right)$",
        r"$v_0 \cos\theta \cdot t e^{-\frac{gt}{v_t}}$",
        r"$\frac{v_0 \cos\theta \cdot v_t}{g} \ln\left(1 + \frac{gt}{v_t}\right)$",
        r"$v_0 \cos\theta \left(t - \frac{g}{v_t}t^2\right)$"
      ],
      "respuesta_correcta": r"$\frac{v_0 \cos\theta \cdot v_t}{g} \left(1 - e^{-\frac{gt}{v_t}}\right)$",
      "explicacion_detallada": r"La ecuación en $x$ es $m\ddot{x} = -b\dot{x}$. La velocidad es $v_x(t) = v_{0x} e^{-\frac{b}{m}t}$. Integrando obtenemos $x(t) = \frac{mv_{0x}}{b}(1 - e^{-\frac{b}{m}t})$. Sustituyendo $b/m = g/v_t$ y $v_{0x} = v_0 \cos\theta$, se obtiene $$x(t) = \frac{v_0 \cos\theta \cdot v_t}{g} \left(1 - e^{-\frac{gt}{v_t}}\right)$$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Se dispara un proyectil con velocidad inicial $v_0$ hacia un blanco ubicado en las coordenadas $(X, Y)$. ¿Cuál es la rapidez mínima inicial $(v_0)_{\text{min}}$ requerida para alcanzar el blanco en el vacío?",
      "opciones": [
        r"$\sqrt{g(Y + \sqrt{X^2 + Y^2})}$",
        r"$\sqrt{g\sqrt{X^2 + Y^2}}$",
        r"$\sqrt{2g(Y + \sqrt{X^2 + Y^2})}$",
        r"$\sqrt{g(Y + X)}$"
      ],
      "respuesta_correcta": r"$\sqrt{g(Y + \sqrt{X^2 + Y^2})}$",
      "explicacion_detallada": r"La ecuación de la parábola de seguridad (la envolvente de todas las trayectorias posibles para un $v_0$ dado) es $Y = \frac{v_0^2}{2g} - \frac{gX^2}{2v_0^2}$. Despejando $v_0^2$ como una ecuación cuadrática y buscando que la raíz sea real (discriminante nulo para la rapidez mínima), obtenemos $v_0^2 = g(Y + \sqrt{X^2 + Y^2})$. Así, $(v_0)_{\text{min}} = \sqrt{g(Y + \sqrt{X^2 + Y^2})}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Un proyectil es lanzado sobre un plano inclinado que forma un ángulo $\phi$ con la horizontal. Si se lanza con un ángulo $\alpha$ respecto a la horizontal ($\alpha > \phi$), ¿cuál es el ángulo de lanzamiento $\alpha$ que maximiza el alcance a lo largo del plano inclinado?",
      "opciones": [
        r"$\frac{\pi}{4} + \frac{\phi}{2}$",
        r"$\frac{\pi}{4} - \frac{\phi}{2}$",
        r"$\frac{\pi}{2} - \phi$",
        r"$\frac{\pi}{4}$"
      ],
      "respuesta_correcta": r"$\frac{\pi}{4} + \frac{\phi}{2}$",
      "explicacion_detallada": r"El alcance sobre el plano es $R = \frac{2v_0^2}{g \cos^2\phi} \sin(\alpha - \phi)\cos\alpha$. Usando identidades trigonométricas, $\sin(\alpha - \phi)\cos\alpha = \frac{1}{2}[\sin(2\alpha - \phi) - \sin\phi]$. Para maximizar $R$, maximizamos $\sin(2\alpha - \phi)$, lo que ocurre cuando $2\alpha - \phi = \frac{\pi}{2}$. Despejando $\alpha$, obtenemos $\alpha = \frac{\pi}{4} + \frac{\phi}{2}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Considere el efecto Coriolis en la Tierra (velocidad angular $\omega$, latitud $\lambda$ en el hemisferio norte). Si se dispara un cañón horizontalmente hacia el norte, ¿hacia dónde y con qué aceleración se desvía el proyectil transversalmente debido a la fuerza de Coriolis?",
      "opciones": [
        r"Hacia el este con aceleración $2\omega v \sin\lambda$",
        r"Hacia el oeste con aceleración $2\omega v \sin\lambda$",
        r"Hacia el este con aceleración $2\omega v \cos\lambda$",
        r"Hacia el oeste con aceleración $2\omega v \cos\lambda$"
      ],
      "respuesta_correcta": r"Hacia el este con aceleración $2\omega v \sin\lambda$",
      "explicacion_detallada": r"La fuerza de Coriolis es $\vec{F}_C = -2m(\vec{\omega} \times \vec{v})$. En el hemisferio norte, un proyectil moviéndose hacia el norte tiene $\vec{v} = v\hat{j}$. $\vec{\omega} = \omega(\cos\lambda\hat{j} + \sin\lambda\hat{k})$. El producto cruz $\vec{\omega} \times \vec{v} = \omega\sin\lambda(\hat{k} \times \hat{j}) = -\omega\sin\lambda\hat{i}$. Entonces $\vec{F}_C/m = 2\omega v \sin\lambda\hat{i}$. Como $\hat{i}$ apunta al este, se desvía hacia el este con aceleración $2\omega v \sin\lambda$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"¿Cuál es el radio de curvatura $\rho$ de la trayectoria de un proyectil en el vacío en el punto más alto de su vuelo, asumiendo una velocidad inicial $v_0$ y ángulo $\theta$?",
      "opciones": [
        r"$\frac{v_0^2 \cos^2\theta}{g}$",
        r"$\frac{v_0^2 \sin^2\theta}{g}$",
        r"$\frac{v_0^2}{g}$",
        r"$\frac{v_0^2 \cos\theta}{g}$"
      ],
      "respuesta_correcta": r"$\frac{v_0^2 \cos^2\theta}{g}$",
      "explicacion_detallada": r"La aceleración centrípeta es $a_c = \frac{v^2}{\rho}$. En el punto más alto, la velocidad es puramente horizontal, $v = v_x = v_0 \cos\theta$. La aceleración normal a la trayectoria es simplemente la gravedad $g$. Por lo tanto, $g = \frac{(v_0 \cos\theta)^2}{\rho}$. Despejando el radio de curvatura se obtiene $\rho = \frac{v_0^2 \cos^2\theta}{g}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Un proyectil de masa $m$ y carga $q$ se lanza en un campo gravitatorio $\vec{g} = -g\hat{j}$ y un campo eléctrico uniforme $\vec{E} = E\hat{i}$. ¿Cuál es la forma matemática de su trayectoria en el plano $xy$?",
      "opciones": [
        r"Una parábola cuyo eje de simetría está inclinado respecto a la vertical",
        r"Una elipse",
        r"Una hipérbola",
        r"Una parábola con eje de simetría vertical pero desplazada"
      ],
      "respuesta_correcta": r"Una parábola cuyo eje de simetría está inclinado respecto a la vertical",
      "explicacion_detallada": r"La aceleración neta es constante: $\vec{a} = \frac{qE}{m}\hat{i} - g\hat{j}$. Esta aceleración define una gravedad 'efectiva' $\vec{g}_{\text{eff}}$ que está rotada un ángulo $\beta = \arctan(qE/mg)$ respecto a la vertical. El movimiento bajo aceleración uniforme sigue siempre una parábola, pero como la 'vertical' efectiva está inclinada, el eje de simetría de la parábola también se inclina ese mismo ángulo $\beta$ respecto al eje $y$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Dos proyectiles son lanzados simultáneamente desde el mismo punto con la misma rapidez inicial $v_0$ pero con diferentes ángulos $\alpha$ y $\beta$ ($\alpha > \beta$). Si ambos colisionan en el aire en un instante $t > 0$, ¿qué condición deben cumplir $\alpha$ y $\beta$?",
      "opciones": [
        r"No pueden colisionar si son lanzados desde el mismo punto simultáneamente",
        r"$\alpha + \beta = 90^\circ$",
        r"$\alpha - \beta = 45^\circ$",
        r"$\alpha \cdot \beta = \pi/4$"
      ],
      "respuesta_correcta": r"No pueden colisionar si son lanzados desde el mismo punto simultáneamente",
      "explicacion_detallada": r"Para que colisionen, deben tener las mismas coordenadas $x(t)$ e $y(t)$ en el mismo instante $t$. Como $x(t) = v_0 \cos\theta t$, tendríamos $\cos\alpha = \cos\beta$, lo que implica $\alpha = \beta$ (ya que $\alpha, \beta \in [0, \pi/2]$). Por lo tanto, dos proyectiles con distintos ángulos lanzados simultáneamente desde el mismo origen jamás compartirán la misma posición en $t > 0$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Calcule la magnitud del momento angular $\vec{L}$ de un proyectil de masa $m$ respecto al origen (punto de lanzamiento) cuando alcanza su altura máxima $H$.",
      "opciones": [
        r"$\frac{mv_0^3 \sin^2\theta \cos\theta}{2g}$",
        r"$\frac{mv_0^2 \sin^2\theta}{2g}$",
        r"$\frac{mv_0^3 \sin\theta \cos^2\theta}{g}$",
        r"$0$"
      ],
      "respuesta_correcta": r"$\frac{mv_0^3 \sin^2\theta \cos\theta}{2g}$",
      "explicacion_detallada": r"El momento angular es $\vec{L} = \vec{r} \times \vec{p}$. En el vértice, la posición es $\vec{r} = (\frac{R}{2})\hat{i} + H\hat{j} = (\frac{v_0^2\sin(2\theta)}{2g})\hat{i} + (\frac{v_0^2\sin^2\theta}{2g})\hat{j}$. El momento lineal es $\vec{p} = m(v_0\cos\theta)\hat{i}$. Al hacer el producto cruz, $\vec{L} = -m v_0 \cos\theta H \hat{k}$. Sustituyendo $H = \frac{v_0^2\sin^2\theta}{2g}$, la magnitud es $L = \frac{mv_0^3 \sin^2\theta \cos\theta}{2g}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"¿Cuál es el valor del lagrangiano $L$ de un proyectil de masa $m$ en un plano bidimensional, usando coordenadas cartesianas $(x, y)$ donde $y$ es vertical hacia arriba?",
      "opciones": [
        r"$\frac{1}{2}m(\dot{x}^2 + \dot{y}^2) - mgy$",
        r"$\frac{1}{2}m(\dot{x}^2 + \dot{y}^2) + mgy$",
        r"$m(\dot{x}^2 + \dot{y}^2) - \frac{1}{2}mgy$",
        r"$\frac{1}{2}m\dot{x}^2 - mgy^2$"
      ],
      "respuesta_correcta": r"$\frac{1}{2}m(\dot{x}^2 + \dot{y}^2) - mgy$",
      "explicacion_detallada": r"El lagrangiano se define como $L = T - V$, donde $T$ es la energía cinética y $V$ es la energía potencial. Para un proyectil de masa $m$, $T = \frac{1}{2}m(\dot{x}^2 + \dot{y}^2)$ y $V = mgy$. Por lo tanto, $L = \frac{1}{2}m(\dot{x}^2 + \dot{y}^2) - mgy$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Una partícula realiza un movimiento de proyectil. ¿Cómo varía con el tiempo la magnitud del momento generalizado conjugado a la coordenada horizontal $x$?",
      "opciones": [
        r"Es constante en el tiempo.",
        r"Aumenta linealmente con el tiempo.",
        r"Disminuye exponencialmente.",
        r"Varía sinusoidalmente."
      ],
      "respuesta_correcta": r"Es constante en el tiempo.",
      "explicacion_detallada": r"El momento generalizado conjugado a $x$ es $p_x = \frac{\partial L}{\partial \dot{x}} = m\dot{x}$. La ecuación de Euler-Lagrange para $x$ es $\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{x}}\right) - \frac{\partial L}{\partial x} = 0$. Dado que el Lagrangiano $L$ no depende explícitamente de $x$ (es decir, $x$ es una coordenada cíclica), $\frac{\partial L}{\partial x} = 0$, lo que implica $\frac{dp_x}{dt} = 0$. Por lo tanto, $p_x$ se conserva constante en el tiempo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"¿Cuál es el área abarcada bajo la curva de la trayectoria de un proyectil, desde el lanzamiento hasta el impacto sobre suelo horizontal (ideal sin aire)?",
      "opciones": [
        r"$\frac{2 v_0^4 \sin^3\theta \cos\theta}{3g^2}$",
        r"$\frac{v_0^4 \sin^2\theta \cos^2\theta}{g^2}$",
        r"$\frac{4 v_0^4 \sin^3\theta \cos\theta}{3g^2}$",
        r"$\frac{v_0^3 \sin^2\theta \cos\theta}{2g}$"
      ],
      "respuesta_correcta": r"$\frac{2 v_0^4 \sin^3\theta \cos\theta}{3g^2}$",
      "explicacion_detallada": r"El área bajo la parábola es $A = \int_0^R y \, dx$. Sabiendo que para una parábola de base $b$ y altura $h$, el área es $\frac{2}{3}bh$. Aquí $b = R = \frac{v_0^2 \sin(2\theta)}{g} = \frac{2v_0^2\sin\theta\cos\theta}{g}$, y $h = H = \frac{v_0^2\sin^2\theta}{2g}$. Multiplicando: $A = \frac{2}{3} \times \left(\frac{2v_0^2\sin\theta\cos\theta}{g}\right) \times \left(\frac{v_0^2\sin^2\theta}{2g}\right) = \frac{2 v_0^4 \sin^3\theta \cos\theta}{3g^2}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Si un proyectil rebota elásticamente sobre un plano horizontal, ¿cuál es la distancia total horizontal cubierta después de un tiempo infinito?",
      "opciones": [
        r"Infinito, asumiendo un plano horizontal ilimitado",
        r"El doble del primer alcance",
        r"$\frac{v_0^2 \sin(2\theta)}{g (1 - e)}$ donde e es el coeficiente de restitución",
        r"Cero, el proyectil eventualmente se detiene horizontalmente"
      ],
      "respuesta_correcta": r"Infinito, asumiendo un plano horizontal ilimitado",
      "explicacion_detallada": r"Un rebote *elástico* ideal significa que el coeficiente de restitución es $e = 1$. Por lo tanto, no se pierde energía cinética vertical ni horizontal. El proyectil continuará rebotando indefinidamente, cubriendo el mismo alcance en cada salto. Por tanto, la distancia horizontal cubierta tras un tiempo infinito diverge hacia el infinito."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Considere un proyectil lanzado verticalmente hacia arriba con velocidad inicial $v_0$ desde el ecuador terrestre. Si se toma en cuenta la aceleración de Coriolis, ¿cuál es el sentido y dependencia de la desviación horizontal observada al caer de vuelta?",
      "opciones": [
        r"Desviación hacia el oeste, proporcional a $v_0^3$",
        r"Desviación hacia el este, proporcional a $v_0^2$",
        r"Desviación hacia el oeste, proporcional a $v_0^2$",
        r"No hay desviación en el ecuador"
      ],
      "respuesta_correcta": r"Desviación hacia el oeste, proporcional a $v_0^3$",
      "explicacion_detallada": r"Al ascender, el proyectil experimenta una fuerza de Coriolis hacia el oeste; al descender, experimenta una fuerza hacia el este. Sin embargo, debido al tiempo de vuelo cuadrático y la integración doble, la desviación neta al regresar a tierra resulta ser hacia el oeste, con una magnitud $\Delta x = \frac{4\omega v_0^3}{3g^2}$, que es proporcional a $v_0^3$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"En el estudio del proyectil con resistencia del aire cuadrática $\vec{F}_d = -c v^2 \hat{v}$, las ecuaciones diferenciales están acopladas. Sin embargo, para trayectorias muy planas ($\theta \approx 0$), ¿qué aproximación permite desacoplar parcialmente el sistema?",
      "opciones": [
        r"Aproximar $v \approx v_x$, asumiendo $v_y \ll v_x$",
        r"Asumir que la gravedad se equilibra con el arrastre cuadrático",
        r"Despreciar el arrastre en el eje $y$ completamente",
        r"Aproximar el movimiento mediante perturbaciones seculares"
      ],
      "respuesta_correcta": r"Aproximar $v \approx v_x$, asumiendo $v_y \ll v_x$",
      "explicacion_detallada": r"La magnitud de la velocidad es $v = \sqrt{v_x^2 + v_y^2}$. Para trayectorias rasantes donde $v_y \ll v_x$, se aproxima $v \approx v_x$. La fuerza de arrastre es proporcional a $v \vec{v}$, de modo que $F_{dx} = -c v v_x \approx -c v_x^2$ y $F_{dy} = -c v v_y \approx -c v_x v_y$. Esto simplifica la ecuación en $x$ a $\ddot{x} \propto -\dot{x}^2$, permitiendo una solución analítica para $v_x(t)$, que luego se usa para resolver $y(t)$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Un cañón dispara un proyectil que forma una trayectoria elíptica en un modelo Kepleriano (gravedad no constante, asumiendo Tierra esférica no rotante). Si $R_E$ es el radio de la Tierra, ¿cuál es la ecuación para el semieje mayor $a$ de esta elipse en función de la velocidad inicial $v_0$ y la constante gravitacional estándar $\mu = GM$?",
      "opciones": [
        r"$a = \left( \frac{2}{R_E} - \frac{v_0^2}{\mu} \right)^{-1}$",
        r"$a = \frac{\mu}{v_0^2}$",
        r"$a = R_E \left( 1 - \frac{v_0^2 R_E}{2\mu} \right)$",
        r"$a = \left( \frac{1}{R_E} - \frac{v_0^2}{2\mu} \right)^{-1}$"
      ],
      "respuesta_correcta": r"$a = \left( \frac{2}{R_E} - \frac{v_0^2}{\mu} \right)^{-1}$",
      "explicacion_detallada": r"Por conservación de la energía orbital (ecuación vis-viva), la energía específica en la superficie (distancia $r = R_E$) es $\mathcal{E} = \frac{v_0^2}{2} - \frac{\mu}{R_E}$. Sabemos que la energía para una elipse es $\mathcal{E} = -\frac{\mu}{2a}$. Igualando y despejando $a$: $-\frac{\mu}{2a} = \frac{v_0^2}{2} - \frac{\mu}{R_E} \implies \frac{1}{a} = \frac{2}{R_E} - \frac{v_0^2}{\mu}$, de donde $a = \left( \frac{2}{R_E} - \frac{v_0^2}{\mu} \right)^{-1}$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Demuestre qué tipo de curva describe el lugar geométrico de los focos de todas las trayectorias parabólicas que resultan de lanzar proyectiles desde el origen con una misma velocidad inicial $v_0$, variando únicamente el ángulo de lanzamiento $\theta$.",
      "opciones": [
        r"Una circunferencia con centro en el origen y radio $v_0^2/(2g)$",
        r"Una parábola que coincide con la envolvente de seguridad",
        r"Una línea recta horizontal a una altura $v_0^2/(2g)$",
        r"Una elipse con focos en el origen"
      ],
      "respuesta_correcta": r"Una circunferencia con centro en el origen y radio $v_0^2/(2g)$",
      "explicacion_detallada": r"Para una trayectoria dada, el foco de la parábola se encuentra a una distancia constante de la directriz. La directriz de todas estas parábolas para un $v_0$ fijo es la misma línea horizontal en $y = v_0^2/(2g)$. Como el origen pertenece a la parábola, la distancia del origen al foco es igual a la distancia del origen a la directriz, que es $v_0^2/(2g)$. Por tanto, todos los focos equidistan del origen, formando una circunferencia de radio $v_0^2/(2g)$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"Considere el Hamiltoniano de un proyectil de masa $m$: $H = \frac{p_x^2 + p_y^2}{2m} + mgy$. Usando las ecuaciones de Hamilton, ¿cuál es la ecuación diferencial para el momento vertical $p_y$?",
      "opciones": [
        r"$\dot{p}_y = -mg$",
        r"$\dot{p}_y = p_y / m$",
        r"$\dot{p}_y = -mgy$",
        r"$\dot{p}_y = mg$"
      ],
      "respuesta_correcta": r"$\dot{p}_y = -mg$",
      "explicacion_detallada": r"Las ecuaciones de Hamilton establecen que la derivada temporal del momento conjugado es $\dot{p}_i = -\frac{\partial H}{\partial q_i}$. Para la coordenada vertical $y$, el momento conjugado es $p_y$. Derivando el Hamiltoniano parcialmente respecto a $y$: $\frac{\partial H}{\partial y} = mg$. Por lo tanto, la ecuación de movimiento es $\dot{p}_y = -mg$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"En un movimiento de proyectiles, defina la magnitud del vector excentricidad de Runge-Lenz $\vec{e}$ en el límite de Tierra plana (campo gravitatorio uniforme infinito no central).",
      "opciones": [
        r"El vector de Runge-Lenz no está definido o carece de análogo conservado trivial para campos puramente uniformes, excepto en la formalidad asintótica.",
        r"$e = 1$ para toda trayectoria parabólica estricta",
        r"$e = 0$ indicando órbitas cerradas",
        r"$e \to \infty$ divergiendo siempre"
      ],
      "respuesta_correcta": r"$e = 1$ para toda trayectoria parabólica estricta",
      "explicacion_detallada": r"El movimiento en un campo gravitatorio constante es estrictamente parabólico. En el marco de secciones cónicas, una parábola está definida rigurosamente por poseer una excentricidad exacta de $e = 1$. Aunque el vector de Laplace-Runge-Lenz tradicionalmente se aplica a potenciales de fuerza central $1/r$, la excentricidad geométrica de la órbita (parábola) en un campo $g$ uniforme es $1$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"¿Cuál es el ángulo de elevación $\theta$ requerido para maximizar la longitud de arco $s$ (longitud de la trayectoria) descrita por un proyectil lanzado a nivel de tierra firme en el vacío con velocidad $v_0$ constante?",
      "opciones": [
        r"Aproximadamente $56.46^\circ$ (raíz de una ecuación trascendente)",
        r"$45^\circ$ exacto",
        r"$90^\circ$ exacto",
        r"$60^\circ$ exacto"
      ],
      "respuesta_correcta": r"Aproximadamente $56.46^\circ$ (raíz de una ecuación trascendente)",
      "explicacion_detallada": r"La longitud de arco es $s = \int dx \sqrt{1 + (y')^2}$. Resolviendo la integral para una parábola da una función dependiente de $\theta$. Para maximizar esta longitud con respecto a $\theta$, se deriva $ds/d\theta = 0$, lo que conduce a una ecuación trascendente $\sinh^{-1}(\tan\theta) = \tan\theta(2 - \tan^2\theta) / (\tan^2\theta - 1)$. La solución numérica arroja un ángulo óptimo que no es analítico simple, sino aproximadamente $56.465^\circ$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.5",
      "enunciado": r"La variación temporal del producto punto entre los vectores de velocidad y aceleración ($\vec{v} \cdot \vec{a}$) de un proyectil estándar indica la tasa de cambio de su rapidez. ¿Cuál es el valor máximo absoluto de esta cantidad durante el vuelo, asumiendo un lanzamiento horizontal o ascendente?",
      "opciones": [
        r"$v_0 g \sin\theta$",
        r"$g^2$",
        r"$v_0 g \cos\theta$",
        r"$v_0^2 / g$"
      ],
      "respuesta_correcta": r"$v_0 g \sin\theta$",
      "explicacion_detallada": r"Tenemos $\vec{v} = v_0\cos\theta \hat{i} + (v_0\sin\theta - gt)\hat{j}$ y $\vec{a} = -g\hat{j}$. El producto punto es $\vec{v} \cdot \vec{a} = -g(v_0\sin\theta - gt)$. El valor máximo en magnitud ocurre en $t = 0$ o en el momento del impacto a nivel de suelo $t = 2v_0\sin\theta/g$. En $t=0$, $\vec{v} \cdot \vec{a} = -v_0 g \sin\theta$. Su magnitud máxima es $v_0 g \sin\theta$."
    }
  ];

  final file = File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/assets/data/gen_q_375.json');
  file.createSync(recursive: true);
  file.writeAsStringSync(jsonEncode(questions));
  print('Done');
}
