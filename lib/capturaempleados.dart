import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleados extends StatefulWidget {
  const CapturaEmpleados({super.key});

  @override
  State<CapturaEmpleados> createState() => _CapturaEmpleadosState();
}

class _CapturaEmpleadosState extends State<CapturaEmpleados> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  void _guardarEmpleado() {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text;
      String puesto = _puestoController.text;
      double salario = double.tryParse(_salarioController.text) ?? 0.0;

      GuardarDatosDiccionario.guardar(nombre, puesto, salario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.black),
              SizedBox(width: 10),
              Text('Empleado guardado con éxito', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          backgroundColor: Colors.pinkAccent, // Notificación rosa
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  // Método reutilizable para dibujar bonitos inputs negros con rosa
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String errorMessage,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.pinkAccent), // Iconos rosas
        filled: true,
        fillColor: Colors.black54, // Fondo del input negro transparente
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.pinkAccent, width: 2), // Borde brilla al hacer clic
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'Por favor ingrese un número válido';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.pinkAccent),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade900], // Fondo negro degradado
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Card(
              color: const Color(0xFF1E1E1E), // Tarjeta color carbón
              elevation: 8,
              shadowColor: Colors.pinkAccent.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.pinkAccent.withOpacity(0.3), width: 1), // Borde sutíl rosa
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Datos del Empleado',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                      controller: _nombreController,
                      label: 'Nombre Completo',
                      icon: Icons.person_outline,
                      errorMessage: 'Por favor ingrese el nombre del empleado',
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _puestoController,
                      label: 'Puesto Laboral',
                      icon: Icons.work_outline,
                      errorMessage: 'Por favor ingrese el puesto',
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _salarioController,
                      label: 'Salario Mensual',
                      icon: Icons.monetization_on_outlined,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      errorMessage: 'Por favor ingrese el salario',
                      isNumber: true,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _guardarEmpleado,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, // Botón rosa
                        foregroundColor: Colors.black, // Letra oscura
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: Colors.pinkAccent.withOpacity(0.5),
                      ),
                      child: const Text('Guardar Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
