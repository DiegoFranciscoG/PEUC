# P.E.U.C. — Preparación para el Examen Universidad de Cuenca

Una aplicación móvil 100% offline para la preparación integral del Examen de Admisión de la Universidad de Cuenca, con contenido oficial, simulacros y progreso adaptativo.

![Version](https://img.shields.io/badge/Versión-v1.0.0-blue)
![Platform](https://img.shields.io/badge/Plataforma-Android-green)
![License](https://img.shields.io/badge/Licencia-MIT-purple)
![Size](https://img.shields.io/badge/Tamaño-~55MB-orange)

## 📥 Descarga Directa

Puedes descargar la última versión compilada (APK) directamente desde la sección de Releases, sin necesidad de compilar el proyecto:

[![Descargar APK](https://img.shields.io/badge/Descargar_APK-Última_Versión-brightgreen?style=for-the-badge&logo=android)](https://github.com/DiegoFranciscoG/PEUC/releases/latest/download/app-release.apk)

*(Nota: Deberás habilitar "Instalar aplicaciones de fuentes desconocidas" en tu dispositivo Android).*



---

## ✨ Características Principales

*   **Cobertura Oficial:** 51 subtemas correspondientes al temario oficial de la UCuenca (Matemáticas, Ciencias Sociales, Ciencias Naturales, Lengua y Literatura, Razonamiento Abstracto).
*   **Banco de Preguntas Exhaustivo:** Más de 1000 preguntas de calidad verificada, categorizadas y validadas contra duplicados.
*   **Modos de Práctica:**
    *   *Feedback inmediato*: Responde preguntas por subtema y conoce al instante si acertaste, con explicaciones detalladas.
    *   *Simulacro Adaptativo*: Sesiones de entrenamiento que refuerzan tus debilidades basándose en tu historial de errores.
    *   *Examen Oficial*: Simulador cronometrado con evaluación integral.
*   **Contenido Enriquecido:** Renderizado nativo de fórmulas matemáticas en formato LaTeX y recomendaciones de videos de YouTube integradas por subtema.
*   **100% Offline-First:** Toda la base de datos se descarga al instalar. Sincronización en la nube mediante Backblaze B2 de manera transparente para obtener actualizaciones sin requerir versiones nuevas de la app.
*   **Dashboard y Estadísticas:** Análisis detallado de aciertos/errores por materia para enfocar tu estudio.

---

## 🛠️ Stack Técnico

*   **Framework:** [Flutter](https://flutter.dev/) (Dart)
*   **Base de Datos:** SQLite (`sqflite`) para almacenamiento local y consultas rápidas de miles de registros.
*   **Renderizado:** `flutter_math_fork` / `flutter_markdown_latex` para soporte matemático de alta calidad.
*   **Sincronización:** API REST hacia [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

---

## 💻 Instalación (Desarrolladores)

Si deseas clonar el proyecto y compilarlo tú mismo:

1.  Asegúrate de tener instalado el [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  Clona el repositorio:
    ```bash
    git clone https://github.com/DiegoFranciscoG/PEUC.git
    cd PEUC
    ```
3.  Obtén las dependencias:
    ```bash
    flutter pub get
    ```
4.  Compila la aplicación en modo Release para Android:
    ```bash
    flutter build apk --release
    ```
    El APK resultante estará en `build/app/outputs/flutter-apk/app-release.apk`.

---

## 📁 Estructura Principal

\`\`\`text
lib/
 ├── database/     # DB helper y migraciones SQLite (incluye lógica de v18)
 ├── models/       # Clases de datos (Pregunta, Teoria, ExamenState)
 ├── providers/    # Lógica de estado con Riverpod (Simulacros, Adaptativo)
 ├── screens/      # Vistas UI (Dashboard, Simulador, Teoría)
 ├── services/     # Llamadas al API (Sincronización con Backblaze)
 ├── utils/        # Renderizadores (LaTeX, videos) y validadores
 └── main.dart     # Punto de entrada de la aplicación
\`\`\`

---

## 📄 Licencia

Este proyecto está bajo la Licencia **MIT**. Consulta el archivo [LICENSE](LICENSE) para más detalles.
