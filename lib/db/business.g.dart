part of 'business.dart';

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business()
    ..uuid = json['uuid'] as String
    ..name = json['business_name'] as String ?? ''
    ..ownedBy = json['owned_by'] as String
    ..users = (json['users'] as List)
            ?.map((e) => e == null ? null : e as String)
            ?.toList() ??
        []
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

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'business_name': instance.name,
      'owned_by': instance.ownedBy,
      'users': instance.users == null ? [] : instance.users,
      'search_keys': instance.searchKeys == null ? [] : instance.searchKeys,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
