import 'dart:convert';
import 'dart:io';
void main() {
  print(jsonDecode(File('assets/data/gen_t_4_5_1.json').readAsStringSync()).length);
  print(jsonDecode(File('assets/data/gen_t_4_8_1.json').readAsStringSync()).length);
  print(jsonDecode(File('assets/data/gen_t_4_10_1.json').readAsStringSync()).length);
}
