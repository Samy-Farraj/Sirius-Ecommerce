part of 'color_bloc.dart';

abstract class SizeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllSizesEvent extends SizeEvent {
  String categoryId;

  GetAllSizesEvent({
    required this.categoryId,
  });
}
