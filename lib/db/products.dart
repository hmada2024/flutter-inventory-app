import 'package:greenland_stock/db/model.dart';
import 'package:greenland_stock/services/user_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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

  String getID() {
    return this.uuid;
  }

  Future<void> create() async {
    try {
      DocumentReference docRef = getCollectionRef().doc();
      this.createdAt = DateTime.now();
      this.updatedAt = DateTime.now();
      this.uuid = docRef.id;
      this.searchKeys =
          this.name.split(" ").map((e) => e.toLowerCase()).toList();

      await docRef.set(this.toJson());
    } catch (err) {
      throw err;
    }
  }

  Stream<QuerySnapshot> streamAllProducts() {
    return getCollectionRef()
        .where('business_id', whereIn: cachedLocalUser.business)
        .snapshots();
  }

  Stream<QuerySnapshot> searchByKeys(String key) {
    List<String> keys = key.split(" ").map((e) => e.toLowerCase()).toList();

    List<Stream<QuerySnapshot>> streams = [];

    for (var i = 0; i < cachedLocalUser.business.length; i++) {
      streams.add(getCollectionRef()
          .where('business_id', isEqualTo: cachedLocalUser.business[i])
          .where('search_keys', arrayContainsAny: keys)
          .snapshots());
    }

    return ConcatStream(streams);
  }

  Future<void> remove() async {
    try {
      DocumentReference docRef = getDocumentReference(this.uuid);
      await docRef.delete();
    } catch (err) {
      throw err;
    }
  }
}
