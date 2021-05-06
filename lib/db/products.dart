import 'package:greenland_stock/db/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'products.g.dart';

@JsonSerializable(explicitToJson: true)
class Products extends Model {
  static CollectionReference _productCollRef = Model.db.collection("products");

  @JsonKey(name: 'uuid')
  String uuid;
  @JsonKey(name: 'name', defaultValue: "")
  String name;
  @JsonKey(name: 'business_id', defaultValue: "")
  String businessID;
  @JsonKey(name: 'business_name', defaultValue: "")
  String businessName;
  @JsonKey(name: 'quantity', defaultValue: 1)
  double quantity;
  @JsonKey(name: 'min_quantity', defaultValue: 1)
  double minQuantity;
  @JsonKey(name: 'search_keys', defaultValue: [""])
  List<String> searchKeys;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Products();

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  CollectionReference getCollectionRef() {
    return _productCollRef;
  }

  DocumentReference getDocumentReference(String uuid) {
    return _productCollRef.doc(uuid);
  }

}