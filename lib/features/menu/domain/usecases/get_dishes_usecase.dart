import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/dish_entity.dart';
import '../repositories/menu_repository.dart';


class GetDishesUseCase {
  final MenuRepository repository;

  GetDishesUseCase(this.repository);

  Future<Either<Failure, List<DishEntity>>> call() async {
    return await repository.getDishes();
  }
}
