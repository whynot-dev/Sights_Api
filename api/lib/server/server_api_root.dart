import 'package:bones_api/bones_api.dart';

import 'modules/map_module.dart';

class ServerAPIRoot extends APIRoot {
  ServerAPIRoot({dynamic apiConfig}) : super('example', '1.0', apiConfig: apiConfig);

  // Load the modules used by this API:
  @override
  Set<APIModule> loadModules() => {MapModule(this)};
}
