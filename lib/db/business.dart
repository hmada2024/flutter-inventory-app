import 'package:greenland_stock/db/model.dart';
import 'package:greenland_stock/services/user_service.dart';
import 'package:greenland_stock/db/address.dart';
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
  @JsonKey(name: 'business_name', defaultValue: "")
  String name;
  @JsonKey(name: 'users')
  List<String> users;
  @JsonKey(name: 'search_keys', defaultValue: [""])
  List<String> searchKeys;
  @JsonKey(name: 'address')
  Address address;
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

  String getID() {
    return this.uuid;
  }

  Stream<QuerySnapshot> streamForUser() {
    return getCollectionRef()
        .where('users', arrayContains: cachedLocalUser.getID())
        .snapshots();
  }

  Future<List<Business>> getStoresForUser() async {
    try {
      QuerySnapshot snap = await getCollectionRef()
          .where('users', arrayContains: cachedLocalUser.getID())
          .get();

      List<Business> _b = [];
      if (snap.docs.isNotEmpty) {
        for (var i = 0; i < snap.docs.length; i++) {
          Business _business = Business.fromJson(snap.docs[i].data());
          _b.add(_business);
        }
      }

      return _b;
    } catch (err) {
      throw err;
    }
  }

  Future<void> create() async {
    try {
      DocumentReference docRef = getCollectionRef().doc();
      this.createdAt = DateTime.now();
      this.updatedAt = DateTime.now();
      this.users = [cachedLocalUser.getID()];
      this.uuid = docRef.id;
      this.searchKeys =
          this.name.split(" ").map((e) => e.toLowerCase()).toList();

      await docRef.set(this.toJson());
    } catch (err) {
      throw err;
    }
  }
}
