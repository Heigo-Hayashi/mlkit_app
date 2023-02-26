// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rakutenapi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Rakutenapi _$$_RakutenapiFromJson(Map<String, dynamic> json) =>
    _$_Rakutenapi(
      itemName: json['itemName'] as String?,
      itemCaption: json['itemCaption'] as String?,
      itemUrl: json['itemUrl'] as String?,
      shopUrl: json['shopUrl'] as String?,
      shopName: json['shopName'] as String?,
      itemPrice: json['itemPrice'] as int?,
      mediumImageUrls: json['mediumImageUrls'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_RakutenapiToJson(_$_Rakutenapi instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'itemCaption': instance.itemCaption,
      'itemUrl': instance.itemUrl,
      'shopUrl': instance.shopUrl,
      'shopName': instance.shopName,
      'itemPrice': instance.itemPrice,
      'mediumImageUrls': instance.mediumImageUrls,
    };
