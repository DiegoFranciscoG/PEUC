import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> questions = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Considere una esfera sólida de radio R con una magnetización uniforme \(\mathbf{M} = M_0 \hat{z}\). ¿Cuál es la densidad de corriente ligada superficial \(\mathbf{K}_b\) y el campo magnético \(\mathbf{B}\) en el interior de la esfera?",
      "opciones": [
        r"\(\mathbf{K}_b = M_0 \sin\theta \hat{\phi}\), \(\mathbf{B} = \frac{2}{3}\mu_0 M_0 \hat{z}\)",
        r"\(\mathbf{K}_b = M_0 \cos\theta \hat{\phi}\), \(\mathbf{B} = \frac{1}{3}\mu_0 M_0 \hat{z}\)",
        r"\(\mathbf{K}_b = M_0 \sin\theta \hat{\phi}\), \(\mathbf{B} = \mu_0 M_0 \hat{z}\)",
        r"\(\mathbf{K}_b = M_0 \hat{\phi}\), \(\mathbf{B} = \frac{4}{3}\mu_0 M_0 \hat{z}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{K}_b = M_0 \sin\theta \hat{\phi}\), \(\mathbf{B} = \frac{2}{3}\mu_0 M_0 \hat{z}\)",
      "explicacion_detallada": r"La corriente ligada volumétrica es \(\mathbf{J}_b = \nabla \times \mathbf{M} = 0\). La superficial es \(\mathbf{K}_b = \mathbf{M} \times \hat{n} = M_0 \hat{z} \times \hat{r} = M_0 \sin\theta \hat{\phi}\). Integrando la ley de Biot-Savart, el campo magnético interno es uniforme y vale \(\mathbf{B} = \frac{2}{3}\mu_0 \mathbf{M}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Un cilindro infinito de radio R tiene una densidad de corriente volumétrica no uniforme \(\mathbf{J} = J_0 (1 - \frac{r^2}{R^2}) \hat{z}\). ¿Cuál es la magnitud del campo magnético \(B(r)\) para \(r < R\)?",
      "opciones": [
        r"\(B(r) = \frac{\mu_0 J_0 r}{2} (1 - \frac{r^2}{2R^2})\)",
        r"\(B(r) = \frac{\mu_0 J_0 r}{2} (1 - \frac{r^2}{R^2})\)",
        r"\(B(r) = \frac{\mu_0 J_0 R^2}{2r}\)",
        r"\(B(r) = \frac{\mu_0 J_0 r}{3} (1 - \frac{r^3}{R^3})\)"
      ],
      "respuesta_correcta": r"\(B(r) = \frac{\mu_0 J_0 r}{2} (1 - \frac{r^2}{2R^2})\)",
      "explicacion_detallada": r"Usando la Ley de Ampère: \(\oint \mathbf{B} \cdot d\mathbf{l} = \mu_0 I_{enc}\). Para una espira de radio \(r\), \(I_{enc} = \int_0^r J_0 (1 - \frac{r'^2}{R^2}) 2\pi r' dr' = 2\pi J_0 (\frac{r^2}{2} - \frac{r^4}{4R^2})\). Entonces, \(B(2\pi r) = \mu_0 \pi J_0 r^2 (1 - \frac{r^2}{2R^2})\), lo que da \(B(r) = \frac{\mu_0 J_0 r}{2} (1 - \frac{r^2}{2R^2})\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál es el potencial vector magnético \(\mathbf{A}(\mathbf{r})\) generado por un dipolo magnético ideal con momento dipolar \(\mathbf{m}\) ubicado en el origen?",
      "opciones": [
        r"\(\mathbf{A}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m} \times \hat{r}}{r^2}\)",
        r"\(\mathbf{A}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m} \cdot \hat{r}}{r^2} \hat{r}\)",
        r"\(\mathbf{A}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m} \times \mathbf{r}}{r^3}\)",
        r"Ambas A y C son correctas"
      ],
      "respuesta_correcta": r"Ambas A y C son correctas",
      "explicacion_detallada": r"El potencial vector magnético dipolar está dado por \(\mathbf{A}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m} \times \hat{r}}{r^2}\). Puesto que \(\hat{r} = \frac{\mathbf{r}}{r}\), esto es algebraicamente equivalente a \(\frac{\mu_0}{4\pi} \frac{\mathbf{m} \times \mathbf{r}}{r^3}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"El invariante adiabático fundamental para una partícula cargada confinada en un campo magnético lentamente variable en el espacio (espejo magnético) es el momento magnético orbital. ¿Cuál es su expresión y condición de constancia?",
      "opciones": [
        r"\(\mu = \frac{m v_{\perp}^2}{2B}\) es constante si \(\frac{1}{B} |\nabla B| r_L \ll 1\)",
        r"\(\mu = \frac{m v_{\parallel}^2}{B}\) es constante si \(\frac{1}{B} |\nabla B| r_L \gg 1\)",
        r"\(\mu = \frac{q v_{\perp} B}{m}\) es constante si el campo es uniforme",
        r"\(\mu = \frac{m v^2}{2B^2}\) es invariante bajo cualquier gradiente"
      ],
      "respuesta_correcta": r"\(\mu = \frac{m v_{\perp}^2}{2B}\) es constante si \(\frac{1}{B} |\nabla B| r_L \ll 1\)",
      "explicacion_detallada": r"El momento magnético asociado a la órbita de Larmor es \(\mu = I A = \frac{q \omega_c}{2\pi} (\pi r_L^2)\). Sustituyendo \(\omega_c = \frac{qB}{m}\) y \(r_L = \frac{v_{\perp}}{\omega_c}\), obtenemos \(\mu = \frac{m v_{\perp}^2}{2B} = \frac{W_{\perp}}{B}\). Se conserva si la variación temporal relativa del campo vista por la partícula en un periodo de Larmor es pequeña, equivalente a la condición espacial \(\frac{1}{B} |\nabla B| r_L \ll 1\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál es el valor del campo magnético \(\mathbf{B}\) a lo largo del eje \(z\) de una espira circular de radio \(R\) ubicada en el plano \(xy\), centrada en el origen, y que transporta una corriente \(I\)?",
      "opciones": [
        r"\(\mathbf{B}(z) = \frac{\mu_0 I R^2}{2(R^2 + z^2)^{3/2}} \hat{z}\)",
        r"\(\mathbf{B}(z) = \frac{\mu_0 I R}{2(R^2 + z^2)} \hat{z}\)",
        r"\(\mathbf{B}(z) = \frac{\mu_0 I}{2R} \cos(\theta) \hat{z}\)",
        r"\(\mathbf{B}(z) = \frac{\mu_0 I z^2}{2(R^2 + z^2)^{3/2}} \hat{z}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{B}(z) = \frac{\mu_0 I R^2}{2(R^2 + z^2)^{3/2}} \hat{z}\)",
      "explicacion_detallada": r"Utilizando la Ley de Biot-Savart, \(d\mathbf{B} = \frac{\mu_0 I}{4\pi} \frac{d\mathbf{l} \times \mathbf{\hat{r}'}}{r'^2}\). Por simetría, las componentes perpendiculares al eje z se cancelan. La componente z se obtiene integrando \(dB_z = dB \cos\theta = \frac{\mu_0 I}{4\pi (R^2+z^2)} dl \frac{R}{\sqrt{R^2+z^2}}\). La integral de \(dl\) es \(2\pi R\), produciendo \(\mathbf{B}(z) = \frac{\mu_0 I R^2}{2(R^2 + z^2)^{3/2}} \hat{z}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Bajo las transformaciones de Lorentz de los campos electromagnéticos, si en el marco inercial S existe únicamente un campo magnético \(\mathbf{B}\), y un marco S' se mueve con velocidad \(\mathbf{v}\) respecto a S, ¿cuáles son los campos \(\mathbf{E}'\) y \(\mathbf{B}'\) medidos en S'?",
      "opciones": [
        r"\(\mathbf{E}' = \gamma (\mathbf{v} \times \mathbf{B})\), \(\mathbf{B}' = \gamma \mathbf{B}_{\perp} + \mathbf{B}_{\parallel}\)",
        r"\(\mathbf{E}' = \gamma (\mathbf{v} \cdot \mathbf{B})\), \(\mathbf{B}' = \frac{1}{\gamma} \mathbf{B}\)",
        r"\(\mathbf{E}' = -\mathbf{v} \times \mathbf{B}\), \(\mathbf{B}' = \mathbf{B}\)",
        r"\(\mathbf{E}' = \gamma (\mathbf{v} \times \mathbf{B})\), \(\mathbf{B}' = \mathbf{B}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{E}' = \gamma (\mathbf{v} \times \mathbf{B})\), \(\mathbf{B}' = \gamma \mathbf{B}_{\perp} + \mathbf{B}_{\parallel}\)",
      "explicacion_detallada": r"Las transformaciones generales de campo son \(\mathbf{E}'_{\parallel} = \mathbf{E}_{\parallel}\), \(\mathbf{E}'_{\perp} = \gamma (\mathbf{E}_{\perp} + \mathbf{v} \times \mathbf{B})\), \(\mathbf{B}'_{\parallel} = \mathbf{B}_{\parallel}\), \(\mathbf{B}'_{\perp} = \gamma (\mathbf{B}_{\perp} - \frac{1}{c^2} \mathbf{v} \times \mathbf{E})\). Si \(\mathbf{E}=0\), entonces \(\mathbf{E}' = \gamma (\mathbf{v} \times \mathbf{B})\). Además, \(\mathbf{B}'_{\parallel} = \mathbf{B}_{\parallel}\) y \(\mathbf{B}'_{\perp} = \gamma \mathbf{B}_{\perp}\). Por tanto, \(\mathbf{B}' = \mathbf{B}_{\parallel} + \gamma \mathbf{B}_{\perp}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál es la forma general de las condiciones de frontera para el campo magnético \(\mathbf{B}\) y el campo magnetizante \(\mathbf{H}\) en la interfaz entre dos medios magnéticos (en ausencia de corrientes libres superficiales)?",
      "opciones": [
        r"\(\mathbf{B}_{1n} = \mathbf{B}_{2n}\) y \(\mathbf{H}_{1t} = \mathbf{H}_{2t}\)",
        r"\(\mathbf{H}_{1n} = \mathbf{H}_{2n}\) y \(\mathbf{B}_{1t} = \mathbf{B}_{2t}\)",
        r"\(\mathbf{B}_{1n} - \mathbf{B}_{2n} = \mu_0 K_f\) y \(\mathbf{H}_{1t} = \mathbf{H}_{2t}\)",
        r"\(\mathbf{B}_{1} = \mathbf{B}_{2}\) y \(\mathbf{H}_{1} = \mathbf{H}_{2}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{B}_{1n} = \mathbf{B}_{2n}\) y \(\mathbf{H}_{1t} = \mathbf{H}_{2t}\)",
      "explicacion_detallada": r"A partir de \(\nabla \cdot \mathbf{B} = 0\), la aplicación del teorema de la divergencia a un volumen tipo caja de píldoras en la interfaz da \(B_{1n} = B_{2n}\). A partir de \(\nabla \times \mathbf{H} = \mathbf{J}_f\), y asumiendo \(K_f = 0\), la integral de línea en un bucle amperiano da \(\mathbf{H}_{1t} = \mathbf{H}_{2t}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En el tensor de esfuerzos de Maxwell \(T_{ij}\), ¿cuál es la expresión para la componente de presión pura generada por un campo magnético \(\mathbf{B}\) (es decir, el término isotrópico de la diagonal)?",
      "opciones": [
        r"\(-\frac{B^2}{2\mu_0} \delta_{ij}\)",
        r"\(\frac{B_i B_j}{\mu_0}\)",
        r"\(\frac{B^2}{2\mu_0} \delta_{ij}\)",
        r"\(-\frac{B_i B_j}{2\mu_0}\)"
      ],
      "respuesta_correcta": r"\(-\frac{B^2}{2\mu_0} \delta_{ij}\)",
      "explicacion_detallada": r"El tensor de esfuerzos de Maxwell magnético está dado por \(T_{ij} = \frac{1}{\mu_0} (B_i B_j - \frac{1}{2}B^2 \delta_{ij})\). El término isotrópico diagonal (presión magnética) es \(-\frac{B^2}{2\mu_0}\), lo cual ejerce una presión expansiva perpendicular a las líneas de campo y una tensión a lo largo de ellas."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En un plasma, un electrón se mueve a velocidades ultra-relativistas con un factor de Lorentz \(\gamma \gg 1\) perpendicular a un campo magnético uniforme \(B\). ¿Cuál es la frecuencia del ciclotrón \(\omega_c\) relativista de este electrón?",
      "opciones": [
        r"\(\omega_c = \frac{e B}{\gamma m_e}\)",
        r"\(\omega_c = \frac{e B}{m_e}\)",
        r"\(\omega_c = \frac{\gamma e B}{m_e}\)",
        r"\(\omega_c = \frac{e B}{\gamma^2 m_e}\)"
      ],
      "respuesta_correcta": r"\(\omega_c = \frac{e B}{\gamma m_e}\)",
      "explicacion_detallada": r"Para una partícula relativista, la ecuación de movimiento es \(\frac{d\mathbf{p}}{dt} = e(\mathbf{v} \times \mathbf{B})\). Dado que \(\mathbf{p} = \gamma m_e \mathbf{v}\) y el campo es ortogonal, \(\gamma\) es constante. Esto da \(\gamma m_e \frac{d\mathbf{v}}{dt} = e(\mathbf{v} \times \mathbf{B})\). Al resolver para un movimiento circular uniforme se obtiene la frecuencia \(\omega_c = \frac{e B}{\gamma m_e}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Un disco de radio \(R\), con carga uniformemente distribuida en su superficie total \(Q\), gira con velocidad angular constante \(\omega\) alrededor de su eje central perpendicular. ¿Cuál es su momento dipolar magnético \(\mathbf{m}\)?",
      "opciones": [
        r"\(\mathbf{m} = \frac{1}{4} Q R^2 \mathbf{\omega}\)",
        r"\(\mathbf{m} = \frac{1}{2} Q R^2 \mathbf{\omega}\)",
        r"\(\mathbf{m} = Q R^2 \mathbf{\omega}\)",
        r"\(\mathbf{m} = \frac{1}{3} Q R^2 \mathbf{\omega}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{m} = \frac{1}{4} Q R^2 \mathbf{\omega}\)",
      "explicacion_detallada": r"La densidad superficial de carga es \(\sigma = \frac{Q}{\pi R^2}\). Un anillo diferencial de radio \(r\) transporta una corriente \(dI = \frac{dq}{T} = \sigma (2\pi r dr) \frac{\omega}{2\pi} = \sigma \omega r dr\). Su momento magnético es \(d\mathbf{m} = \pi r^2 dI \hat{n} = \pi \sigma \omega r^3 dr \hat{n}\). Integrando desde 0 a R: \(\mathbf{m} = \pi \frac{Q}{\pi R^2} \omega \frac{R^4}{4} = \frac{1}{4} Q R^2 \mathbf{\omega}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál de las siguientes afirmaciones describe mejor el efecto Aharonov-Bohm para electrones que interfieren después de rodear un solenoide ideal infinitamente largo (con campo B interior y B=0 en el exterior)?",
      "opciones": [
        r"La diferencia de fase se debe a que el potencial vector \(\mathbf{A}\) es no nulo fuera del solenoide, induciendo un desfase \(\Delta\phi = \frac{e}{\hbar} \Phi_B\).",
        r"La diferencia de fase es cero porque el campo magnético \(\mathbf{B}\) es estrictamente nulo fuera del solenoide.",
        r"La diferencia de fase está dominada únicamente por la fuerza de Lorentz residual debido al escape (fuga) de campo magnético.",
        r"La diferencia de fase ocurre debido al efecto Zeeman anómalo en el vacío."
      ],
      "respuesta_correcta": r"La diferencia de fase se debe a que el potencial vector \(\mathbf{A}\) es no nulo fuera del solenoide, induciendo un desfase \(\Delta\phi = \frac{e}{\hbar} \Phi_B\).",
      "explicacion_detallada": r"El efecto Aharonov-Bohm demuestra la significancia física del potencial vector \(\mathbf{A}\) en mecánica cuántica. Aunque \(\mathbf{B}=0\) exterior al solenoide, \(\mathbf{A} \neq 0\). La diferencia de fase cuántica entre las dos trayectorias está dada por \(\Delta\phi = \frac{e}{\hbar} \oint \mathbf{A} \cdot d\mathbf{l} = \frac{e}{\hbar} \int \mathbf{B} \cdot d\mathbf{S} = \frac{e}{\hbar} \Phi_B\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"¿Cuál es la elección usual del potencial vector \(\mathbf{A}(\mathbf{r})\) en el calibrador de Coulomb (\(\nabla \cdot \mathbf{A} = 0\)) para representar un campo magnético estático y uniforme \(\mathbf{B}\) en todo el espacio?",
      "opciones": [
        r"\(\mathbf{A} = \frac{1}{2} \mathbf{B} \times \mathbf{r}\)",
        r"\(\mathbf{A} = \mathbf{B} \times \mathbf{r}\)",
        r"\(\mathbf{A} = -\nabla (\mathbf{B} \cdot \mathbf{r})\)",
        r"\(\mathbf{A} = \frac{1}{2} \mathbf{r} \times \mathbf{B}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{A} = \frac{1}{2} \mathbf{B} \times \mathbf{r}\)",
      "explicacion_detallada": r"Tomando \(\mathbf{A} = \frac{1}{2} \mathbf{B} \times \mathbf{r}\), verificamos el campo \(\nabla \times \mathbf{A}\). Usando identidades vectoriales: \(\nabla \times (\mathbf{B} \times \mathbf{r}) = \mathbf{B}(\nabla \cdot \mathbf{r}) - (\mathbf{B} \cdot \nabla)\mathbf{r}\). Ya que \(\nabla \cdot \mathbf{r} = 3\) y \((\mathbf{B} \cdot \nabla)\mathbf{r} = \mathbf{B}\), tenemos \(\nabla \times \mathbf{A} = \frac{1}{2}(3\mathbf{B} - \mathbf{B}) = \mathbf{B}\). Además, satisface la norma de Coulomb \(\nabla \cdot (\mathbf{B} \times \mathbf{r}) = \mathbf{r} \cdot (\nabla \times \mathbf{B}) - \mathbf{B} \cdot (\nabla \times \mathbf{r}) = 0\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Considere el tensor de campo electromagnético relativista \(F^{\mu\nu}\). ¿Cuáles de los siguientes escalares de Lorentz son invariantes relativistas puramente relacionados con el campo magnético y eléctrico?",
      "opciones": [
        r"\(B^2 - E^2/c^2\) y \(\mathbf{E} \cdot \mathbf{B}\)",
        r"\(B^2 + E^2/c^2\) y \(\mathbf{E} \times \mathbf{B}\)",
        r"\(F^{\mu\nu} F_{\mu\nu}\) (que es \(\propto E^2 - B^2\)) solamente",
        r"La magnitud de \(\mathbf{B}\) es el único invariante estricto"
      ],
      "respuesta_correcta": r"\(B^2 - E^2/c^2\) y \(\mathbf{E} \cdot \mathbf{B}\)",
      "explicacion_detallada": r"El escalar \(F^{\mu\nu} F_{\mu\nu} = 2(B^2 - E^2/c^2)\) es un invariante de Lorentz. El seudoescalar formado por la contracción con el tensor dual \(F^{\mu\nu} \tilde{F}_{\mu\nu} \propto \mathbf{E} \cdot \mathbf{B}\) es otro invariante. Esto implica que, por ejemplo, campos E y B perpendiculares en un marco inercial lo serán en todos los marcos."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Un campo magnético no uniforme produce una deriva del centro guía de la órbita de Larmor. Para un gradiente de campo \(\nabla B\) perpendicular a \(\mathbf{B}\), ¿cuál es la velocidad de deriva por gradiente \(\mathbf{v}_{\nabla B}\)?",
      "opciones": [
        r"\(\mathbf{v}_{\nabla B} = \frac{m v_{\perp}^2}{2 q B} \frac{\mathbf{B} \times \nabla B}{B^2}\)",
        r"\(\mathbf{v}_{\nabla B} = \frac{m v_{\parallel}^2}{q B} \frac{\mathbf{B} \times \nabla B}{B^2}\)",
        r"\(\mathbf{v}_{\nabla B} = \frac{q B}{m} (\mathbf{v} \times \nabla B)\)",
        r"\(\mathbf{v}_{\nabla B} = \frac{1}{2} v_{\perp} \frac{\nabla B \times \mathbf{B}}{B}\)"
      ],
      "respuesta_correcta": r"\(\mathbf{v}_{\nabla B} = \frac{m v_{\perp}^2}{2 q B} \frac{\mathbf{B} \times \nabla B}{B^2}\)",
      "explicacion_detallada": r"La fuerza promediada sobre una órbita de Larmor en presencia de un gradiente transversal de campo magnético es \(\langle \mathbf{F} \rangle = -\mu \nabla B\). Esta fuerza constante induce una deriva general dada por \(\mathbf{v}_D = \frac{\mathbf{F} \times \mathbf{B}}{q B^2}\). Sustituyendo el momento magnético \(\mu = \frac{m v_{\perp}^2}{2B}\), obtenemos \(\mathbf{v}_{\nabla B} = \frac{m v_{\perp}^2}{2 q B} \frac{\mathbf{B} \times \nabla B}{B^2}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Se tiene un conductor de resistividad \(\rho\) sometido a un campo magnético uniforme variable sinusoidalmente \(B(t) = B_0 \cos(\omega t)\). ¿A qué profundidad de la superficie (skin depth \(\delta\)) la amplitud del campo se reduce a \(B_0/e\)?",
      "opciones": [
        r"\(\delta = \sqrt{\frac{2\rho}{\omega \mu_0}}\)",
        r"\(\delta = \sqrt{\frac{\rho}{\omega \mu_0}}\)",
        r"\(\delta = \frac{2\rho}{\omega \mu_0}\)",
        r"\(\delta = \sqrt{\frac{2 \mu_0}{\omega \rho}}\)"
      ],
      "respuesta_correcta": r"\(\delta = \sqrt{\frac{2\rho}{\omega \mu_0}}\)",
      "explicacion_detallada": r"La ecuación de difusión magnética en un buen conductor es \(\nabla^2 \mathbf{B} = \mu_0 \sigma \frac{\partial \mathbf{B}}{\partial t}\), donde \(\sigma = 1/\rho\). Resolviendo para ondas armónicas, la constante de atenuación es \(\kappa = \sqrt{\frac{\omega \mu_0 \sigma}{2}}\). La profundidad de penetración (skin depth) es \(\delta = 1/\kappa = \sqrt{\frac{2}{\omega \mu_0 \sigma}} = \sqrt{\frac{2\rho}{\omega \mu_0}}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Para un cable coaxial infinito con corriente \(I\) distribuida uniformemente por el conductor interior (radio a) y retornando por un cascarón cilíndrico (radio b), ignorando el grosor del cascarón, ¿cuál es la energía magnética almacenada por unidad de longitud en el vacío entre a y b?",
      "opciones": [
        r"\(U/l = \frac{\mu_0 I^2}{4\pi} \ln(b/a)\)",
        r"\(U/l = \frac{\mu_0 I^2}{2\pi} \ln(b/a)\)",
        r"\(U/l = \frac{\mu_0 I^2}{8\pi} \ln(b/a)\)",
        r"\(U/l = \frac{\mu_0 I^2}{\pi} (b^2 - a^2)\)"
      ],
      "respuesta_correcta": r"\(U/l = \frac{\mu_0 I^2}{4\pi} \ln(b/a)\)",
      "explicacion_detallada": r"El campo magnético en el entrehierro (\(a < r < b\)) es \(B(r) = \frac{\mu_0 I}{2\pi r}\). La densidad de energía magnética es \(u = \frac{B^2}{2\mu_0} = \frac{\mu_0 I^2}{8\pi^2 r^2}\). Integrando en un elemento de volumen \(dV = 2\pi r dr dl\): \(U/l = \int_a^b \frac{\mu_0 I^2}{8\pi^2 r^2} 2\pi r dr = \frac{\mu_0 I^2}{4\pi} \int_a^b \frac{dr}{r} = \frac{\mu_0 I^2}{4\pi} \ln(b/a)\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Una barra conductora de longitud L se mueve con velocidad \(\mathbf{v}\) en presencia de un campo magnético \(\mathbf{B}\). ¿Cuál es la fuerza electromotriz (FEM) de movimiento generada entre los extremos de la barra, y bajo qué formalismo se explica?",
      "opciones": [
        r"\(\mathcal{E} = \int (\mathbf{v} \times \mathbf{B}) \cdot d\mathbf{l}\), derivada de la fuerza de Lorentz sobre los portadores de carga.",
        r"\(\mathcal{E} = - \int \mathbf{B} \cdot d\mathbf{l}\), debida a la inducción magnética estática.",
        r"\(\mathcal{E} = v B L \cos\theta\), válida sólo en la relatividad especial.",
        r"\(\mathcal{E} = \int (\mathbf{E} \times \mathbf{B}) \cdot d\mathbf{l}\), efecto Hall cuántico."
      ],
      "respuesta_correcta": r"\(\mathcal{E} = \int (\mathbf{v} \times \mathbf{B}) \cdot d\mathbf{l}\), derivada de la fuerza de Lorentz sobre los portadores de carga.",
      "explicacion_detallada": r"Un portador de carga \(q\) en la barra se mueve a velocidad \(\mathbf{v}\) en un campo \(\mathbf{B}\), experimentando una fuerza magnética \(\mathbf{F}_m = q(\mathbf{v} \times \mathbf{B})\). Esto es equivalente a un campo eléctrico efectivo \(\mathbf{E}_{ef} = \mathbf{v} \times \mathbf{B}\). La diferencia de potencial inducida, o FEM de movimiento, se obtiene integrando a lo largo del conductor: \(\mathcal{E} = \int \mathbf{E}_{ef} \cdot d\mathbf{l} = \int (\mathbf{v} \times \mathbf{B}) \cdot d\mathbf{l}\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Según la formulación multipolar, si un sistema de corrientes localizadas obedece \(\nabla \cdot \mathbf{J} = 0\) estático, ¿qué se puede deducir del término de monopolo magnético en la expansión a gran distancia del potencial vector?",
      "opciones": [
        r"Es idénticamente nulo porque la divergencia nula impide líneas de campo no cerradas.",
        r"Es directamente proporcional a la carga total del sistema.",
        r"Es igual a la contribución monopolar eléctrica multiplicada por \(\mu_0 / \epsilon_0\).",
        r"Disminuye como \(1/r^2\) pero nunca es estrictamente nulo."
      ],
      "respuesta_correcta": r"Es idénticamente nulo porque la divergencia nula impide líneas de campo no cerradas.",
      "explicacion_detallada": r"El término monopolar del potencial vector es proporcional a \(\int \mathbf{J} d^3r\). Usando la identidad \(\nabla \cdot (x_i \mathbf{J}) = (\nabla x_i)\cdot \mathbf{J} + x_i (\nabla \cdot \mathbf{J}) = J_i\), la integral de volumen de \(J_i\) se transforma en una integral de superficie en el infinito de \(x_i \mathbf{J} \cdot \mathbf{n}\), que es cero para corrientes localizadas. En consecuencia, el momento monopolar magnético se anula exactamente, reflejando \(\nabla \cdot \mathbf{B} = 0\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"En el fenómeno del paramagnetismo modelado clásicamente (teoría de Langevin), ¿cuál es la magnetización \(M\) como función del campo externo \(B\) y la temperatura \(T\) para un sistema de dipolos magnéticos \(\mu_0\)?",
      "opciones": [
        r"\(M = n \mu_0 \left[ \coth(\frac{\mu_0 B}{k_B T}) - \frac{k_B T}{\mu_0 B} \right]\)",
        r"\(M = n \mu_0 \tanh(\frac{\mu_0 B}{k_B T})\)",
        r"\(M = n \mu_0 \frac{\mu_0 B}{k_B T}\)",
        r"\(M = n \mu_0 \exp(-\frac{\mu_0 B}{k_B T})\)"
      ],
      "respuesta_correcta": r"\(M = n \mu_0 \left[ \coth(\frac{\mu_0 B}{k_B T}) - \frac{k_B T}{\mu_0 B} \right]\)",
      "explicacion_detallada": r"En un ensamble clásico de momentos magnéticos \(\mu_0\) no interactuantes, la probabilidad térmica angular sigue la estadística de Boltzmann. Integrando sobre todos los ángulos sólidos, la magnetización promedio de \(n\) espines por unidad de volumen da \(M = n \mu_0 L(a)\), donde \(a = \frac{\mu_0 B}{k_B T}\) y la función de Langevin es \(L(a) = \coth(a) - 1/a\)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.8",
      "enunciado": r"Para una espira de área A con resistencia R y autoinductancia L, en la que se extingue abruptamente (mediante interruptor) una corriente estacionaria \(I_0\), ¿por qué físicamente es imposible que la corriente se reduzca a cero instantáneamente?",
      "opciones": [
        r"Porque una extinción instantánea implicaría \(dI/dt = -\infty\), induciendo un voltaje infinito y violando la conservación de la energía magnética almacenada \(\frac{1}{2}LI^2\).",
        r"Porque la resistividad del material decrece con corrientes decrecientes.",
        r"Porque el campo eléctrico inducido tendría rotacional nulo.",
        r"Porque el flujo magnético siempre está cuantizado en espiras macroscópicas."
      ],
      "respuesta_correcta": r"Porque una extinción instantánea implicaría \(dI/dt = -\infty\), induciendo un voltaje infinito y violando la conservación de la energía magnética almacenada \(\frac{1}{2}LI^2\).",
      "explicacion_detallada": r"La autoinductancia genera un voltaje opuesto al cambio de corriente, \(\mathcal{E} = -L \frac{dI}{dt}\). Una extinción instantánea significa un salto discontinuo, lo que daría una tasa infinita \(dI/dt \to -\infty\), y por tanto un voltaje infinito que ionizaría el medio (arco eléctrico). Físicamente, la energía en el campo \(\frac{1}{2}LI^2\) no puede disiparse en un tiempo nulo, requiriendo un decaimiento con constante de tiempo \(\tau = L/R\)."
    }
  ];

  File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/generate_json.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync(jsonEncode(questions));
}
