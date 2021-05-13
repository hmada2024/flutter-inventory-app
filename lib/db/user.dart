import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/model.dart';
import 'package:greenland_stock/services/user_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Model {
  static CollectionReference _userCollRef =
      Model.db.collection(is_prod_env ? "users" : "test_users");

  @JsonKey(name: 'guid')
  String guid;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name', defaultValue: "")
  String lastName;
  @JsonKey(name: 'mobile_number')
  int mobileNumber;
  @JsonKey(name: 'country_code')
  int countryCode;
  @JsonKey(name: 'emailID', defaultValue: "")
  String emailID;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'gender', defaultValue: "")
  String gender;
  @JsonKey(name: 'profile_path', defaultValue: "")
  String profilePath;
  @JsonKey(name: 'date_of_birth', defaultValue: "")
  int dateOfBirth;
  @JsonKey(name: 'last_signed_in_at')
  DateTime lastSignInTime;
  @JsonKey(name: 'is_active', defaultValue: true)
  bool isActive;
  @JsonKey(name: 'deactivated_at')
  int deactivatedAt;
  @JsonKey(name: 'business')
  List<String> business;
  @JsonKey(name: 'primary_business')
  String primaryBusiness;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  User();

  String getProfilePicPath() {
    if (this.profilePath != null && this.profilePath != "")
      return this.profilePath;
    return "";
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  CollectionReference getCollectionRef() {
    return _userCollRef;
  }

  CollectionReference getLocationCollectionRef() {
    return _userCollRef.doc(getID()).collection("user_locations");
  }

  DocumentReference getDocumentReference(String id) {
    return _userCollRef.doc(id);
  }

  String getID() {
    return this.countryCode.toString() + this.mobileNumber.toString();
  }

  String getFullName() {
    return this.firstName + " " + this.lastName ?? "";
  }

  int getIntID() {
    return int.parse(
        this.countryCode.toString() + this.mobileNumber.toString());
  }

  Future<User> create() async {
    this.createdAt = DateTime.now();
    this.updatedAt = DateTime.now();
    this.isActive = true;

    await super.add(this.toJson());

    return this;
  }

  Future updatePlatformDetails(Map<String, dynamic> data) async {
    this.update(data);
  }

  Future updatePrimary(String id) async {
    cachedLocalUser.primaryBusiness = id;

    DocumentReference docReef = getDocumentReference(cachedLocalUser.getID());
    await docReef.update({'primary_business': cachedLocalUser.primaryBusiness});
  }
}
