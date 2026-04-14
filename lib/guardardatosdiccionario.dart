import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Inicializamos un contador para asignar un ID auto numérico
  static int _siguienteId = 1;

  // Método para guardar un empleado en el diccionario
  static void guardar(String nombre, String puesto, double salario) {
    Empleado nuevoEmpleado = Empleado(
      id: _siguienteId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );
    
    // Almacena en el diccionario
    datosempleado[_siguienteId] = nuevoEmpleado;
    
    // Incrementa el ID para el siguiente registro
    _siguienteId++;
  }
}
