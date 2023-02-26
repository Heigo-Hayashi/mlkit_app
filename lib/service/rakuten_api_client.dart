import 'package:mlkit_app/model/rakutenapi.dart';
import 'package:dio/dio.dart';

class RakutenApiClient {
  Future<List<Rakutenapi>?> fetchList(String? location) async {
    final dio = Dio();
    const appId = '1089609546998600127';
    var url =
        'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&formatVersion=2&keyword=$location&sort=%2BitemPrice&carrier=2&imageFlag=1&applicationId=$appId';
    url = url.replaceAll(RegExp('\\s'), "");
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      try {
        final datas = response.data["Items"] as List<dynamic>;
        final list = datas.map((e) => Rakutenapi.fromJson(e)).toList();
        return list;
      } catch (e) {
        throw e;
      }
    }
    return null;
  }
}
