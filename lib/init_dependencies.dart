import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/connection_checker.dart';
import 'core/providers/navigation_provider.dart';
import 'core/router/app_router.dart';
import 'core/storage/basket_storage_service.dart';
import 'core/storage/shared_preferences_async.dart';
import 'core/storage/user_storage_service.dart';
import 'features/basket/providers/basket_provider.dart';
import 'features/login/data/api/login_api.dart';
import 'features/login/data/datasources/login_remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/providers/login_provider.dart';
import 'features/menu/data/api/menu_api.dart';
import 'features/menu/data/datasources/menu_remote_data_source.dart';
import 'features/menu/data/repositories/menu_repository_impl.dart';
import 'features/menu/domain/repositories/menu_repository.dart';
import 'features/menu/domain/usecases/get_categories_usecase.dart';
import 'features/menu/domain/usecases/get_dishes_usecase.dart';
import 'features/menu/providers/menu_provider.dart';
import 'features/order_payment/data/api/order_api.dart';
import 'features/order_payment/data/datasources/order_remote_data_source.dart';
import 'features/order_payment/data/repositories/order_repository_impl.dart';
import 'features/order_payment/domain/repositories/order_repository.dart';
import 'features/order_payment/domain/usecases/fetch_orders_usecase.dart';
import 'features/order_payment/domain/usecases/post_order_usecase.dart';
import 'features/order_payment/presentation/services/order_storage_service.dart';
import 'features/order_payment/providers/order_payment_provider.dart';
import 'features/order_payment/providers/order_provider.dart';


part 'init_dependencies.main.dart';