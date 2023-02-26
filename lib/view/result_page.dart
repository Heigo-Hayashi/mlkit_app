import 'package:mlkit_app/model/rakutenapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mlkit_app/view_model/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends ConsumerWidget {
  ResultPage({super.key, required this.keyword});

  final String keyword;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //この前に検索キーワードを渡したい
    final asyncValue = ref.watch(listProvider); //取得したAPIデータの監視
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("”$keyword”の検索結果"),
        elevation: 1.0,
      ),
      body: Center(
        child: asyncValue.when(
          data: (data) {
            if (data.isNotEmpty) {
              return ListView(
                children: data
                    .map(
                      (Rakutenapi rakuten) => Card(
                        child: ListTile(
                          leading: Image.network(rakuten.mediumImageUrls![0],
                          width:64,
                          height: 64,
                          fit: BoxFit.cover),
                          title: Text(rakuten.itemName!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("価格：${rakuten.itemPrice!.toString()}円",
                                style:TextStyle(color: Colors.red),),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(double.maxFinite),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  final pressUrl =
                                      Uri.parse(rakuten.itemUrl.toString());
                                  if (await canLaunchUrl(pressUrl)) {
                                    launchUrl(pressUrl,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    print("Cant launch $pressUrl");
                                  }
                                },
                                child: Text('商品をみる'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Text('商品が見つかりません。もういちど試してください。');
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
