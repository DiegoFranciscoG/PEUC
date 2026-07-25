import 'dart:convert';
import 'dart:io';

void main() {
  var p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  var q = p.firstWhere((x) => x['id'] == 'q_3_7_8_178495665726402773');
  
  String out = '### Captura de Prueba: Renderizado Interno Limpio\\n\\n';
  out += '**Enunciado:** ' + q['enunciado'] + '\\n\\n';
  out += '**Opciones:**\\n';
  for (var op in q['opciones']) {
    out += '- ' + op + '\\n';
  }
  out += '\\n**Explicación:** ' + q['explicacion_detallada'] + '\\n';
  
  File('C:/Users/diego/.gemini/antigravity/brain/4d14910a-6867-4119-a8da-ef00412cfb33/captura_mojibake_reparado.md').writeAsStringSync(out);
}
