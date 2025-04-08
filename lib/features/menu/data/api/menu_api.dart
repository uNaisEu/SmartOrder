import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../models/category_model.dart';
import '../models/dish_model.dart';

class MenuApi {
  final Dio _dio = Dio();

  final String _categoryUrl = '${Constants.apiJsonsUrl}/category.json';
  final String _dishesUrl = '${Constants.apiJsonsUrl}/dishes.json';

  // Загрузка категорий
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(_categoryUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Ошибка загрузки категорий: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Ошибка при загрузке категорий: $e");
      throw Exception("Не удалось загрузить категории.");
    }
  }

  // Загрузка блюд
  Future<List<DishModel>> getDishes() async {
    try {
      final response = await _dio.get(_dishesUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => DishModel.fromJson(json)).toList();
      } else {
        throw Exception("Ошибка загрузки блюд: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Ошибка при загрузке блюд: $e");
      throw Exception("Не удалось загрузить блюда.");
    }
  }
}
