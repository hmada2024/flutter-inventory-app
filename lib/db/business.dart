import 'package:greenland_stock/db/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'business.g.dart';

@JsonSerializable(explicitToJson: true)
class Business extends Model {
  static CollectionReference _bCollRef = Model.db.collection("business");

  @JsonKey(name: 'uuid')
  String uuid;
  @JsonKey(name: 'owned_by', defaultValue: "")
  String ownedBy;
  @JsonKey(name: 'store_name', defaultValue: "")
  String name;
  @JsonKey(name: 'users')
  List<String> users;
  @JsonKey(name: 'search_keys', defaultValue: [""])
  List<String> searchKeys;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Business();

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);

  CollectionReference getCollectionRef() {
    return _bCollRef;
  }

  DocumentReference getDocumentReference(String uuid) {
    return _bCollRef.doc(uuid);
  }

}