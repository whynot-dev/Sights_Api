import 'package:api/core/injection/injection.dart';
import 'package:api/server/server.dart';
import 'package:api/server/server_api_root.dart';

void main() async {
  // A JSON to configure the API:

  registerDio();

  var apiConfigJson = '''
    {"not_found_msg": "This is 404!"}
  ''';

  ServerAPIRoot apiRoot = ServerAPIRoot(apiConfig: apiConfigJson);

  await startAPIServer(apiRoot);

  //await stopAPIServer();
}
