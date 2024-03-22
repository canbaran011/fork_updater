import 'package:get_storage/get_storage.dart';
import 'package:vexana/vexana.dart';

import '../../../core/network/network_helper.dart';
import '../model/home_model.dart';

abstract class IHomeService {
  INetworkManager networkManager;
  IHomeService(this.networkManager);

  Future<List<HomeModel>> fetchHomeItems();
}

class HomeService extends IHomeService with NetworkHelper {
  HomeService(INetworkManager networkManager) : super(networkManager);
  final box = GetStorage();

  @override
  Future<List<HomeModel>> fetchHomeItems() async {
    final response = await networkManager.send<HomeModel, List<HomeModel>>(
      'https://jsonplaceholder.typicode.com/posts',

      //  queryParameters:
      //     Map.fromEntries([MapEntry('personelGuid', personelGuid)]),
      parseModel: HomeModel(),
      method: RequestType.GET,
      // options: Options(// jwt can be written like in core/const/enums/get_s
      //   headers: {'Authorization':'Bearer '+ box.read('jwt') }
      // )
    );

    return response.data ?? [];
  }
}
