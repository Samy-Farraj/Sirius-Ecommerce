import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  UserModel userData;

  RegisterResponse(this.userData);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
