# Investigación y fuentes

Consultas realizadas el 25 y 26 de septiembre de 2026. Cuando dos fuentes no coinciden, gana la oficial y más reciente.

## Examen de admisión y banco de preguntas

| # | Fuente | URL | Consultada | Qué se tomó de aquí |
|---|---|---|---|---|
| 1 | Universidad de Cuenca — página oficial del Examen de admisión 2026 | https://www.ucuenca.edu.ec/admisiones/examen/ | 2026-09-25 | 5 componentes, 12 preguntas por componente, 60 en total; cuestionario distinto por sesión con igual dificultad; **tabla de ponderación por campo prioritario** y lista de **56 carreras** por campo; puntaje de postulación = 60 % examen + 40 % antecedentes + acción afirmativa; sin puntaje mínimo; recálculo al cambiar de campo en una segunda postulación. |
| 2 | Universidad de Cuenca — *Guía del Examen de Admisión 2026* (PDF) | https://www.ucuenca.edu.ec/wp-content/uploads/2026/07/Guia-del-Examen-de-Admision-2026.pdf | 2026-09-25 | **70 minutos**; calificación **+1 correcta, −1/3 incorrecta, 0 en blanco**; todos rinden el mismo número de reactivos; +50 % de tiempo para personas con discapacidad (5 de agosto); el banco se publica 48 h antes del examen; prohibido calculadora. |
| 3 | Universidad de Cuenca — *Temarios UCuenca 2026* (PDF, 26-may-2026) | https://www.ucuenca.edu.ec/wp-content/uploads/2026/07/Temarios_UCuenca-2026.pdf | 2026-09-25 | Catálogo oficial de **5 componentes, 32 unidades y 62 subtemas** con su numeración (1.1.1 … 5.3.3) → `tools/bank_pipeline/data/syllabus_2026.json`. |
| 4 | Universidad de Cuenca — *Banco de preguntas · Examen de admisión 2026* (PDF, 27-jul-2026) | https://comunicacion.ucuenca.edu.ec/wp-content/uploads/2026/07/Banco_de_preguntas_UCuenca_2026.pdf | 2026-09-25 | **2737 preguntas** con sus opciones e imágenes (SHA-256 `170ae65da89ddb7a1950b7ebfe4c93221a563eb84f65f939a82960139188d8f7`). Es la fuente de enunciados y opciones de la app. |
| 5 | Universidad de Cuenca — noticia *UCuenca garantiza transparencia en su examen de admisión liberando el banco de preguntas* (2-jul-2026) | https://www.ucuenca.edu.ec/noticias/ucuenca-garantiza-transparencia-en-su-examen-de-admision-liberando-el-banco-de-preguntas/ | 2026-09-25 | Postulación 6–12 de julio; examen 29–30 de julio; 53 carreras de grado + 3 tecnológicas; 5 campus; el banco se libera por transparencia. |
| 6 | Banco resuelto del autor (`Banco_UCuenca_2026_RESUELTO.docx`, no versionado) | — | 2026-09-25 | Letra de la respuesta y justificación de las 2737 preguntas. **Se verificó contra el PDF oficial** (ver `docs/reporte-validacion.md`). |
| 7 | Diario El Mercurio — *Universidad de Cuenca: guía completa… examen de admisión 2026* (prensa, fuente secundaria) | https://elmercurio.com.ec/cuenca/2026/07/28/universidad-cuenca-examen-admision-2026-guia-completa/ | 2026-09-25 | 15 664 aspirantes. Solo contexto: otra nota del mismo medio habla de "70 preguntas en una hora", **descartado** porque contradice las fuentes 1 y 2. |
| 8 | Revista Vistazo — proceso de admisión 2026 (prensa, secundaria) | https://www.vistazo.com/actualidad/2026-07-01-universidad-cuenca-proceso-admision-fechas-clave-examen-JI11088724 | 2026-09-25 | Coincide con las fuentes oficiales (60 preguntas, 60/40); asignación de cupos 12–23 de agosto. |

## Datos usados para corregir o anotar respuestas

| # | Fuente | URL | Consultada | Uso |
|---|---|---|---|---|
| 9 | IUPAC — *Nomenclature of Inorganic Chemistry, Recommendations 2005* (Red Book) | https://iupac.qmul.ac.uk/bibliog/RedBook2005.pdf | 2026-09-26 | Nota de la pregunta 80: el número de Stock puede omitirse cuando no hay ambigüedad (Ba solo actúa con +2). |
| 10 | USGS — *Geologic time: Age of the Earth* | https://pubs.usgs.gov/gip/geotime/age.html | 2026-09-26 | Nota de la pregunta 2617: edad de la Tierra ≈ 4 540 ± 50 millones de años. |
| 11 | Leyes de los gases (Boyle y Charles), cálculo propio verificado | — | 2026-09-26 | Corrección de las preguntas 1550 (V₂ = 760·615/752 ≈ 621,5 mL) y 2535 (V₂ = 500·310,15/283,15 ≈ 547,7 mL). |
| 12 | Propiedades de logaritmos y dominio (cálculo propio verificado) | — | 2026-09-26 | Pregunta 2354: la única solución real es x = 9 (no figura entre las opciones oficiales). |

## Tecnología, despliegue y cumplimiento

| # | Fuente | URL | Consultada | Uso |
|---|---|---|---|---|
| 13 | Asamblea Nacional del Ecuador — Ley Orgánica de Protección de Datos Personales (R.O. Suplemento 459, 26-may-2021) | https://www.asambleanacional.gob.ec/es/multimedios-legislativos/63464-ley-organica-de-proteccion-de-datos | 2026-09-26 | Principio de **minimización**: la app no recolecta datos personales, no tiene cuentas y guarda el progreso solo en el dispositivo. |
| 14 | GitHub Docs — *GitHub Pages limits* | https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits | 2026-09-26 | Sitio publicado ≤ 1 GB y ancho de banda blando de 100 GB/mes (la web pesa ≈ 55 MB). |
| 15 | Apple Developer — *Membership Details* | https://developer.apple.com/programs/whats-included/ | 2026-09-26 | Publicar en la App Store cuesta 99 USD/año → la vía gratuita para iPhone es la PWA desde Safari. |
| 16 | pub.dev — versiones estables de las dependencias (flutter_riverpod 3.4.3, sqflite 2.4.4, sqflite_common_ffi_web 1.2.0, url_launcher 6.3.2, path 1.9.1, flutter_lints 6.0.0) | https://pub.dev | 2026-09-26 | Versiones fijadas en `pubspec.yaml`. |
| 17 | PyPI — pymupdf 1.28.2, python-docx 1.2.0, pillow 12.3.0, pytest 9.1.1 | https://pypi.org | 2026-09-26 | Versiones fijadas en `tools/bank_pipeline/requirements*.txt`. |
| 18 | GitHub — últimas versiones de las acciones (checkout v7.0.1, setup-java v6.0.1, setup-python v7.0.0, flutter-action v2.23.0, upload/deploy-pages v5, gh-release v3.0.3) y gitleaks v8.30.1 | https://github.com | 2026-09-26 | Versiones exactas en `.github/workflows/`. |

## Supuestos (no publicados por la universidad)

- **SUPUESTO — escala de la nota.** La UCuenca no publica la escala numérica de la nota del examen. La app la muestra como porcentaje del máximo ponderado (0–100 %, puede ser negativa por la penalización).
- **SUPUESTO — distribución por subtema dentro de cada componente.** No se publica. El simulacro reparte las 12 preguntas de cada componente en proporción al número de preguntas que cada subtema tiene en el banco oficial (método del resto mayor).
- **SUPUESTO — subtema de cada pregunta.** El banco oficial no trae etiquetas. Cada una de las 2737 preguntas se asignó a mano a un subtema del temario oficial (`tools/bank_pipeline/data/review_overrides.json`); es una clasificación del autor, no de la universidad.
- **Licencia de las preguntas.** El banco no declara licencia. Se redistribuye sin fines de lucro, con atribución y con el objetivo con que la universidad lo publicó (preparación de aspirantes). Si la universidad lo solicita, se retirará.
- La guía (fuente 2) pone de ejemplo que en una carrera de Ciencias Sociales la Matemática pesa 10 %, pero la tabla de la página oficial (fuente 1) indica 20 %. Se usa la tabla, que es la regla normativa.
