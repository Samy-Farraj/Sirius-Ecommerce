part of 'branches_bloc.dart';

abstract class BranchesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteBranchEvent extends BranchesEvent {
  String branchId;

  DeleteBranchEvent({
    required this.branchId,
  });
}

class AddBranchLocationEvent extends BranchesEvent {
  String areaName;
  LatLng location;

  AddBranchLocationEvent({
    required this.areaName,
    required this.location,
  });
}

class UpdateBranchEvent extends BranchesEvent {
  NewBranchParameter parameter;

  UpdateBranchEvent({
    required this.parameter,
  });
}

class StoreNewBranchEvent extends BranchesEvent {
  NewBranchParameter parameter;

  StoreNewBranchEvent({
    required this.parameter,
  });
}
