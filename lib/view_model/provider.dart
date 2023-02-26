import 'package:mlkit_app/model/rakutenapi.dart';
import 'package:mlkit_app/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textNameProvider = StateProvider((ref) =>'たけのこの里');

// Repository(APIの取得)の状態を管理する
final repositoryProvider = Provider((ref) => Repository());

// 上記を非同期で管理する
//autoDispose修飾子がないと状態が破棄されずに再度ボタンが押されたときにも前の状態が表示される
final listProvider = FutureProvider.autoDispose<List<Rakutenapi>>((ref) async {
  final repository = ref.read(repositoryProvider);
  final textName = ref.watch(textNameProvider.notifier);
  return await repository.fetchList(textName.state);
});

//文字認識した値を管理
final textProvider = StateProvider<String>((ref) {
  return '';
});
