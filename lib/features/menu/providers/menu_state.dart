import '../../../core/error/failures.dart';
import '../domain/entities/menu_entity.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuEntity> menuList;
  MenuLoaded(this.menuList);
}

class MenuLoadingFailed extends MenuState {
  final Failure failure;
  MenuLoadingFailed(this.failure);
}
