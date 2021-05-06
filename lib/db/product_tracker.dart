import 'package:greenland_stock/db/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_tracker.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductTracker {
  @JsonKey(name: 'uuid')
  String uuid;
  @JsonKey(name: 'business_id', defaultValue: "")
  String businessID;
  @JsonKey(name: 'product_id', defaultValue: "")
  String productID;
  @JsonKey(name: 'quantity', defaultValue: 1)
  double quantity;
  @JsonKey(name: 'type', defaultValue: 1)
  int type;
  @JsonKey(name: 'created_by', defaultValue: "")
  String createdBy;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  ProductTracker();

  factory ProductTracker.fromJson(Map<String, dynamic> json) =>
      _$ProductTrackerFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTrackerToJson(this);

  Query getGroupQuery() {
    return Model.db.collectionGroup('product_tracker');
  }

  CollectionReference getCollectionRef(String id) {
    return Model.db
        .collection("products")
        .doc(id)
        .collection("product_tracker");
  }
}
