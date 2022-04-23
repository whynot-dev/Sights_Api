
import 'package:bones_api/bones_api_server.dart';

import 'server_api_root.dart';

late final APIServer apiServer;

/// Starts the [APIServer] (HTTP Server) and returns the port.
/// - With Hot Reload if `--enable-vm-service` is passed to the Dart VM.
Future<int?> startAPIServer(ServerAPIRoot apiRoot) async {
  var serverPort = 8080;

  print('Starting APIServer...\n');

  apiServer = APIServer(apiRoot, 'localhost', serverPort, hotReload: true);
  await apiServer.start();

  print('\n$apiServer');
  print('URL: ${apiServer.url}\n');

  return serverPort;
}

/// Stops the [APIServer].
Future<bool> stopAPIServer() async {
  await apiServer.stop();
  return true;
}
