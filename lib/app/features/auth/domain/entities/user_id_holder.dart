import 'package:equatable/equatable.dart';

class UserIdHolder extends Equatable{
  final String userId;

  const UserIdHolder(this.userId);

  @override
  List<Object?> get props => [userId];

}