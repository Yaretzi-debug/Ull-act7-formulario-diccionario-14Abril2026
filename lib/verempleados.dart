import 'package:flutter/material.dart';
import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatelessWidget {
  const VerEmpleados({super.key});

  @override
  Widget build(BuildContext context) {
    List<Empleado> listaEmpleados = datosempleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.pinkAccent),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade900], // Fondo oscuro ahumado
          ),
        ),
        child: listaEmpleados.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_outlined, size: 80, color: Colors.pinkAccent.withOpacity(0.5)), // Icono rosa opaco
                    const SizedBox(height: 20),
                    Text(
                      'No hay empleados registrados aún.',
                      style: TextStyle(fontSize: 18, color: Colors.pink.shade100),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: listaEmpleados.length,
                itemBuilder: (context, index) {
                  Empleado empleado = listaEmpleados[index];
                  return Card(
                    color: const Color(0xFF1E1E1E), // Tarjetas en negro más claro (antracita)
                    elevation: 5,
                    shadowColor: Colors.pinkAccent.withOpacity(0.2), // Sombra con tono rosa
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.pinkAccent.withOpacity(0.3), width: 1), // Borde en las tarjetas
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.pinkAccent.withOpacity(0.2), // Avatar negro con rosa
                          child: Text(
                            'ID:${empleado.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent, fontSize: 13),
                          ),
                        ),
                        title: Text(
                          empleado.nombre,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // Texto en blanco para resaltar
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.work_outline, size: 16, color: Colors.pinkAccent), // Ícono rosa
                                  const SizedBox(width: 5),
                                  Text(empleado.puesto, style: const TextStyle(fontSize: 15, color: Colors.white70)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, size: 16, color: Colors.greenAccent), // Para dinero usamos otro contraste
                                  const SizedBox(width: 5),
                                  Text(
                                    empleado.salario.toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.greenAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
