part of 'init_dependencies.dart';


GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await AppRouter.initialize();


  await SharedPreferencesAsync.init();
    
  getIt.registerLazySingleton<UserStorageService>(
    () => UserStorageService()
  );

  getIt.registerLazySingleton<BasketStorageService>(
    () => BasketStorageService()
  );


  getIt.registerFactory(
    () => InternetConnection()
  );
  getIt.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => NavigationProvider(),
  );


  getIt
    ..registerLazySingleton<LoginApi>(() => LoginApi())
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt()),
    )
    ..registerLazySingleton<LoginProvider>(
      () => LoginProvider(
        getLoginUseCase: getIt(),
        storage: getIt(),
      ),
    );


  getIt
    ..registerLazySingleton<MenuApi>(() => MenuApi())
    ..registerLazySingleton<MenuRemoteDataSource>(
      () => MenuRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<MenuRepository>(
      () => MenuRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(getIt()),
    )
    ..registerLazySingleton<GetDishesUseCase>(
      () => GetDishesUseCase(getIt()),
    )
    ..registerLazySingleton<MenuProvider>(
      () => MenuProvider(getIt()),
    );

  getIt.registerLazySingleton<BasketProvider>(
    () => BasketProvider(
      storage: getIt()
    ),
  );


  getIt
    ..registerLazySingleton<OrderApi>(() => OrderApi())
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<PostOrderUseCase>(
      () => PostOrderUseCase(getIt()),
    )
    ..registerLazySingleton<FetchOrdersUseCase>(
      () => FetchOrdersUseCase(getIt()),
    )
    ..registerLazySingleton<OrderPaymentProvider>(
      () => OrderPaymentProvider(
        postOrderUseCase: getIt()
      ),
    )
    ..registerLazySingleton<OrderStorageService>(
      () => OrderStorageService()
    )
    ..registerFactory<OrderProvider>(
      () => OrderProvider(getIt()),
    );
}