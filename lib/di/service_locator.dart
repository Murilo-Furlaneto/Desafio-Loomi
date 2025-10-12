import 'package:desafio_loomi/data/repository/firebase_repository.dart';
import 'package:desafio_loomi/data/repository/firebase_repository_impl.dart';
import 'package:desafio_loomi/data/services/api_service.dart'; 
import 'package:desafio_loomi/data/services/firebase_service.dart';
import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/store/auth_store.dart';
import 'package:desafio_loomi/ui/features/home/store/home_store.dart';
import 'package:desafio_loomi/ui/features/profile/store/profile_store.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void locator(){
  getIt.registerSingleton<ApiService>(ApiService()); 

  getIt.registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl(FirebaseService()));
  
  getIt.registerSingleton<AuthStore>(AuthStore(getIt<FirebaseRepository>()));
  getIt.registerSingleton<ProfileStore>(ProfileStore());
  getIt.registerSingleton<HomeStore>(HomeStore());

  getIt.registerSingleton<ThemeApp>(ThemeApp());
}
