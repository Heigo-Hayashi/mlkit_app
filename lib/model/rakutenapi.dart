import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// build_runnerを使うことで自動生成されるファイル
part 'rakutenapi.freezed.dart';
part 'rakutenapi.g.dart';

@freezed
class Rakutenapi with _$Rakutenapi {
  factory Rakutenapi({
    String? itemName,
    String? itemCaption,
    String? itemUrl,
    String? shopUrl,
    String? shopName,
    int? itemPrice,
    List<dynamic>? mediumImageUrls,
  }) = _Rakutenapi;

  factory Rakutenapi.fromJson(Map<String,dynamic> json) => _$RakutenapiFromJson(json);
}