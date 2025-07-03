import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_id_holder.dart';

part 'user_id_holder_model.g.dart';

@JsonSerializable()
class UserIdHolderModel extends UserIdHolder{
  const UserIdHolderModel(super.userId);
  factory UserIdHolderModel.fromJson(Map<String, dynamic> json) =>
      _$UserIdHolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdHolderModelToJson(this);
}