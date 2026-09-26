# Política de seguridad

## Reportar una vulnerabilidad
No abras un issue público. Escríbeme por GitHub (perfil [DiegoFranciscoG](https://github.com/DiegoFranciscoG)) con los pasos para reproducir el problema. Respondo en un máximo de 7 días.

## Prácticas aplicadas en este proyecto
- **Sin backend ni cuentas:** la app no recolecta datos personales; el progreso se guarda solo en el dispositivo (SQLite / IndexedDB). Cumple el principio de minimización de la LOPDP de Ecuador.
- **Sin permisos innecesarios:** la versión release de Android no solicita el permiso de Internet; los enlaces a fuentes oficiales se abren en el navegador del sistema.
- **Cero secretos en el código:** la única configuración sensible (firma de Android) llega por variables de entorno o GitHub Secrets y la build falla si falta alguna (ver `.env.example`).
- **SQL parametrizado** y restricciones `CHECK` en la base local; migraciones versionadas.
- **Escaneo de secretos** con gitleaks sobre todo el historial en cada push y pull request.
- **Dependencias** fijadas y revisadas por Dependabot (pub, pip y GitHub Actions); acciones con versión exacta y `permissions` mínimos.
- **Web:** sin CDNs de terceros (CanvasKit, fuentes y SQLite WebAssembly se sirven desde el propio sitio), `Referrer-Policy: no-referrer` y cabeceras de seguridad en la imagen Docker.
