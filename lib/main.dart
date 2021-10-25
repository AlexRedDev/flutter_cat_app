import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/home/favorite/repository/cached_favorite_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/home/models/cat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  await Firebase.initializeApp();
  final AuthRepository authRepository = AuthRepository();
  final favoriteRepository = CachedFavoriteRepository();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => authRepository),
      RepositoryProvider(create: (context) => favoriteRepository)
    ],
    child: App(),
  ));
}
