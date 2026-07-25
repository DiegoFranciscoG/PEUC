$ErrorActionPreference = 'Stop'

Write-Host "Ejecutando Pipeline de Compilación P.E.U.C."
Write-Host "-------------------------------------------"
Write-Host "Paso 1: Validando estricto encoding de JSONs..."

# Ejecutamos el validador de Dart. Si falla (exit 1), el script también fallará.
dart scripts/validar_encoding.dart

if ($LASTEXITCODE -ne 0) {
    Write-Error "El validador de encoding falló. Compilación abortada para prevenir base de datos corrupta."
    exit 1
}

Write-Host "Paso 2: Encoding verificado. Compilando APK Release..."
flutter build apk --release

Write-Host "Compilación completada exitosamente."
