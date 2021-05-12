part of 'products.dart';

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products()
    ..uuid = json['uuid'] as String
    ..name = json['name'] as String ?? ''
    ..businessID = json['business_id'] as String ?? ''
    ..businessName = json['business_name'] as String ?? ''
    ..quantity = (json['quantity'] as num)?.toDouble() ?? 0.00
    ..minQuantity = (json['min_quantity'] as num)?.toDouble() ?? 0.00
    ..isLow = json['is_low'] as bool ?? false
    ..searchKeys = (json['search_keys'] as List)
            ?.map((e) => e == null ? null : e as String)
            ?.toList() ??
        []
    ..createdAt = json['created_at'] == null
        ? null
        : (json['created_at'] is Timestamp)
            ? DateTime.fromMillisecondsSinceEpoch(
                _getMillisecondsSinceEpoch(json['created_at'] as Timestamp))
            : DateTime.fromMillisecondsSinceEpoch(
                _getMillisecondsSinceEpoch(
                  Timestamp(json['created_at']['_seconds'],
                      json['created_at']['_nanoseconds']),
                ),
              )
    ..updatedAt = json['updated_at'] == null
        ? null
        : (json['updated_at'] is Timestamp)
            ? DateTime.fromMillisecondsSinceEpoch(
                _getMillisecondsSinceEpoch(json['updated_at'] as Timestamp))
            : DateTime.fromMillisecondsSinceEpoch(
                _getMillisecondsSinceEpoch(
                  Timestamp(json['updated_at']['_seconds'],
                      json['updated_at']['_nanoseconds']),
                ),
              );
}

int _getMillisecondsSinceEpoch(Timestamp ts) {
  return ts.millisecondsSinceEpoch;
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'business_id': instance.businessID,
      'business_name': instance.businessName,
      'quantity': instance.quantity ?? 0.00,
      'min_quantity': instance.minQuantity ?? 0.00,
      'is_low': instance.isLow,
      'search_keys': instance.searchKeys == null ? [] : instance.searchKeys,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
