import '../../../../core/error/exceptions.dart';
import '../api/menu_api.dart';
import '../models/category_model.dart';
import '../models/dish_model.dart';


abstract interface class MenuRemoteDataSource {  
  Future<List<CategoryModel>> getCategories();
  Future<List<DishModel>> getDishes();
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final MenuApi api;

  MenuRemoteDataSourceImpl(this.api);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      List<CategoryModel> response = await api.getCategories();
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<DishModel>> getDishes() async {
    try {
      List<DishModel> response = await api.getDishes();
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}