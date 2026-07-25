import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  List<dynamic> data = jsonDecode(content);
  
  final bioContent = File('assets/data/bulk_cn_bio.json').readAsStringSync(encoding: utf8);
  List<dynamic> bioData = jsonDecode(bioContent);
  
  final fisContent = File('assets/data/bulk_cn_fis.json').readAsStringSync(encoding: utf8);
  List<dynamic> fisData = jsonDecode(fisContent);
  
  data.addAll(bioData);
  data.addAll(fisData);
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(data));
  print('Merged ' + bioData.length.toString() + ' bio questions and ' + fisData.length.toString() + ' fis questions.');
}
