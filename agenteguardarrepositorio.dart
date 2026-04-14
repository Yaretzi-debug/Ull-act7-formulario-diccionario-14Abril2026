import 'dart:io';

void main() async {
  print('========================================================');
  print('🤖 Agente Interactivo para Subir a GitHub 🤖');
  print('========================================================\n');

  // Función de ayuda para leer la consola
  String prompt(String message) {
    stdout.write('\x1B[36m\$ $message: \x1B[0m'); // Color cyan en consola
    return stdin.readLineSync()?.trim() ?? '';
  }

  // Función para ejecutar comandos Git de forma nativa manteniendo la consola interactiva (por si pide contraseña GitHub)
  Future<bool> runGitCommand(List<String> args) async {
    print('\x1B[33mEjecutando: git ${args.join(' ')}\x1B[0m');
    var process = await Process.start(
      'git',
      args,
      runInShell: true,
      mode: ProcessStartMode.inheritStdio, // Hereda la terminal para logins interactivos
    );
    var exitCode = await process.exitCode;
    if (exitCode != 0) {
      print('\x1B[31m❌ Error al ejecutar el comando git ${args[0]}\x1B[0m');
      return false;
    }
    return true;
  }

  // 1. Inicializar git
  await runGitCommand(['init']);

  // 2. Agregar archivos
  print('\n[1/5] Preparando archivos para guardarse...');
  await runGitCommand(['add', '.']);

  // 3. Crear Commit
  print('\n[2/5] Creando el Commit');
  String commitMsg = prompt('Ingresa un mensaje para tu commit (o presiona Enter para usar "Commit inicial")');
  if (commitMsg.isEmpty) {
    commitMsg = 'Commit inicial';
  }
  await runGitCommand(['commit', '-m', commitMsg]);

  // 4. Configurar Repositorio Remoto
  print('\n[3/5] Configurando la conexión a GitHub');
  // Revisamos si ya existe el origen leyendo el out directo (runSync)
  var remoteResult = Process.runSync('git', ['remote', 'get-url', 'origin'], runInShell: true);
  if (remoteResult.exitCode == 0) {
    String currentUrl = remoteResult.stdout.toString().trim();
    print('ℹ️ Este proyecto ya está conectado a: $currentUrl');
    String changeRemote = prompt('¿Deseas CAMBIAR el link del repositorio? (s/N)');
    if (changeRemote.toLowerCase() == 's') {
      String repoUrl = prompt('Pega aquí el NUEVO link de tu repositorio');
      if (repoUrl.isNotEmpty) {
        await runGitCommand(['remote', 'set-url', 'origin', repoUrl]);
      }
    }
  } else {
    String repoUrl = '';
    while (repoUrl.isEmpty) {
      repoUrl = prompt('Pega aquí el link de tu repositorio de GitHub (ej. https://github.com/tuUsuario/tuRepo.git)');
    }
    await runGitCommand(['remote', 'add', 'origin', repoUrl]);
  }

  // 5. Configurar la Rama (Branch)
  print('\n[4/5] Seleccionando la Rama (Branch)');
  String branch = prompt('¿A qué rama de GitHub deseas enviarlo? (Presiona Enter para usar la rama default: "main")');
  if (branch.isEmpty) {
    branch = 'main';
  }
  await runGitCommand(['branch', '-M', branch]);

  // 6. Push a GitHub
  print('\n[5/5] Subiendo los datos a GitHub...');
  bool pushSuccess = await runGitCommand(['push', '-u', 'origin', branch]);

  print('\n========================================================');
  if (pushSuccess) {
    print('✅ ¡ÉXITO! Tu proyecto ha sido respaldado en GitHub correctamente.');
    print('💡 TIP: Este agente funciona para cualquier proyecto. ¡Solo copia "agenteguardarrepositorio.dart" a tu otra carpeta y ejecútalo!');
  } else {
    print('❌ Hubo un error al subir el proyecto. Por favor verifica que tu link sea correcto y tengas permisos suficientes.');
  }
  print('========================================================');
}
