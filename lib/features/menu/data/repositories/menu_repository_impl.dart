import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/constants_text.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/dish_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_data_source.dart';
import '../models/category_model.dart';
import '../models/dish_model.dart';


class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  MenuRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return _getCategories(
      () async => await remoteDataSource.getCategories(),
    );
  }

  @override
  Future<Either<Failure, List<DishEntity>>> getDishes() {
    return _getDishes(
      () async => await remoteDataSource.getDishes(),
    );
  }

  Future<Either<Failure, List<CategoryEntity>>> _getCategories(
    Future<List<CategoryModel>> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(ConstantsText.noConnectionErrorMessage));
      }
      final response = await fn();
      List<CategoryEntity> categories = [];
      for (final category in response) {
        categories.add(category.toEntity());
      }
      
      return right(categories);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, List<DishEntity>>> _getDishes(
    Future<List<DishModel>> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(ConstantsText.noConnectionErrorMessage));
      }
      final response = await fn();
      List<DishEntity> dishes = [];
      for (final dish in response) {
        dishes.add(dish.toEntity());
      }
      
      return right(dishes);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
