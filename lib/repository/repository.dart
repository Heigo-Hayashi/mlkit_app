import 'package:mlkit_app/service/rakuten_api_client.dart';

class Repository {
  final api = RakutenApiClient();
  dynamic fetchList(String? location) async {
    return await api.fetchList(location!);
  }
}