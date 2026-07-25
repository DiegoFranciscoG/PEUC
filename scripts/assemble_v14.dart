import 'dart:convert';
import 'dart:io';

void main() {
  print('Iniciando ENSAMBLADO MAESTRO V14 (UTF-8 NATIVO)');

  // 1. ENSAMBLAR PREGUNTAS
  try {
    List<dynamic> preguntasBase = jsonDecode(File('assets/data/preguntas_clean.json').readAsStringSync());
    print('Preguntas base cargadas: ' + preguntasBase.length.toString());
    
    // Eliminar cualquier pregunta previa de Física que se haya colado en clean (por si acaso)
    preguntasBase.removeWhere((p) => ['3.7.5', '3.7.6', '3.7.7', '3.7.8'].contains(p['codigo_tema']));

    int physCount = 0;
    for (String cod in ['375', '376', '377', '378']) {
      File f = File('assets/data/gen_q_' + cod + '.json');
      if (f.existsSync()) {
        List<dynamic> qList = jsonDecode(f.readAsStringSync());
        for (var q in qList) {
          Map<String, dynamic> pq = Map<String, dynamic>.from(q);
          pq['materia'] = 'Ciencias Naturales';
          String codigo = '3.7.' + cod.substring(2);
          pq['codigo_tema'] = codigo;
          pq['id'] = 'q_' + codigo.replaceAll('.', '_') + '_' + DateTime.now().microsecondsSinceEpoch.toString() + physCount.toString();
          preguntasBase.add(pq);
          physCount++;
        }
      } else {
        print('FALTA ARCHIVO: ' + cod);
      }
    }
    
    File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntasBase));
    print('✅ preguntas.json ensamblado con éxito (Total: ' + preguntasBase.length.toString() + ', Agregadas Fís: ' + physCount.toString() + ')');

  } catch (e) {
    print('❌ Error en preguntas: ' + e.toString());
  }

  // 2. ENSAMBLAR TEORÍA
  try {
    List<Map<String, dynamic>> teoriaCompleta = [];
    int tCount = 1;
    
    List<String> files = ['mat', 'len', 'cn1', 'cn2', 'soc', 'abs'];
    for (String prefix in files) {
      File f = File('assets/data/gen_t_' + prefix + '.json');
      if (f.existsSync()) {
        List<dynamic> tList = jsonDecode(f.readAsStringSync());
        for (var t in tList) {
          Map<String, dynamic> pt = Map<String, dynamic>.from(t);
          String cod = pt['codigo_tema']?.toString() ?? '0.0.0';
          pt['id'] = 't_' + cod.replaceAll('.', '_') + '_' + tCount.toString();
          teoriaCompleta.add(pt);
          tCount++;
        }
      } else {
        print('FALTA ARCHIVO TEORIA: ' + prefix);
      }
    }
    
    File('assets/data/teoria.json').writeAsStringSync(jsonEncode(teoriaCompleta));
    print('✅ teoria.json ensamblado con éxito (Total: ' + teoriaCompleta.length.toString() + ')');

  } catch (e) {
    print('❌ Error en teoría: ' + e.toString());
  }
}
