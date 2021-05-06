part of 'product_tracker.dart';

ProductTracker _$ProductTrackerFromJson(Map<String, dynamic> json) {
  return ProductTracker()
    ..uuid = json['uuid'] as String
    ..businessID = json['business_id'] as String ?? ''
    ..productID = json['product_id'] as String ?? ''
    ..quantity = (json['quantity'] as num)?.toDouble() ?? 0.00
    ..type = json['type'] as int ?? 0
    ..createdBy = json['created_by'] as String ?? ''
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

Map<String, dynamic> _$ProductTrackerToJson(ProductTracker instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'business_id': instance.businessID,
      'product_id': instance.productID,
      'quantity': instance.quantity ?? 0.00,
      'type': instance.type ?? 0,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
