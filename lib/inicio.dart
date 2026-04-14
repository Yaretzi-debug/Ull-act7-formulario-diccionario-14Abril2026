import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - Empleados', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.grey.shade900], // Fondo gradiente negro
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.pinkAccent, width: 3), // Borde rosa
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.3), // Brillo rosa alrededor del icono
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: const Icon(Icons.corporate_fare, size: 100, color: Colors.pinkAccent),
                ),
                const SizedBox(height: 60),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/captura');
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Capturar Empleados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Botón rosa
                    foregroundColor: Colors.black, // Texto e icono negros
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 10,
                    shadowColor: Colors.pinkAccent.withOpacity(0.5), // Sombra rosa del botón
                  ),
                ),
                const SizedBox(height: 25),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ver');
                  },
                  icon: const Icon(Icons.people_alt, color: Colors.pinkAccent),
                  label: const Text('Ver Empleados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    minimumSize: const Size(double.infinity, 60),
                    side: const BorderSide(color: Colors.pinkAccent, width: 2), // Borde rosa en botón transparente
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
