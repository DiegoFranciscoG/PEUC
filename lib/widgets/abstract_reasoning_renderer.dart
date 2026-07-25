import 'package:flutter/material.dart';
import '../models/pregunta.dart';
import 'figura_geometrica.dart';

class AbstractReasoningRenderer extends StatelessWidget {
  final Pregunta pregunta;

  const AbstractReasoningRenderer({super.key, required this.pregunta});

  @override
  Widget build(BuildContext context) {
    if (pregunta.elementosAbstractos == null) return const SizedBox();

    final elementos = pregunta.elementosAbstractos!;
    final tipo = pregunta.tipoEjercicioAbstracto ?? 'secuencia3';

    if (tipo == 'matriz3x3') {
      // 3x3 Grid
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            if (index < elementos.length) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Center(
                  child: FiguraGeometrica(
                    iconName: elementos[index].icono,
                    rotacion: elementos[index].rotacion,
                    relleno: elementos[index].relleno,
                    tamano: elementos[index].tamano,
                  ),
                ),
              );
            } else if (index == 8 && elementos.length == 8) {
              // The missing piece
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text('?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black54)),
                ),
              );
            }
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12)));
          },
        ),
      );
    } else if (tipo == 'analogia' || tipo == 'plegado3d') {
      // Analogía o Plegado: A -> B :: C -> ?
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (elementos.isNotEmpty)
              FiguraGeometrica(
                iconName: elementos[0].icono,
                rotacion: elementos[0].rotacion,
                relleno: elementos[0].relleno,
                tamano: elementos[0].tamano,
              ),
            const Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (elementos.length > 1)
              FiguraGeometrica(
                iconName: elementos[1].icono,
                rotacion: elementos[1].rotacion,
                relleno: elementos[1].relleno,
                tamano: elementos[1].tamano,
              ),
            const Text('::', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (elementos.length > 2)
              FiguraGeometrica(
                iconName: elementos[2].icono,
                rotacion: elementos[2].rotacion,
                relleno: elementos[2].relleno,
                tamano: elementos[2].tamano,
              ),
            const Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54)),
              ),
            ),
          ],
        ),
      );
    } else {
      // Secuencia (3, 4, or 5)
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...elementos.map((e) => FiguraGeometrica(
                  iconName: e.icono,
                  rotacion: e.rotacion,
                  relleno: e.relleno,
                  tamano: e.tamano,
                )),
            // The missing element in the sequence
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54)),
              ),
            ),
          ],
        ),
      );
    }
  }
}
