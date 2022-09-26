import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/bloc_observer.dart';
import 'package:hadith_app/config/routes/app_route.dart';
import 'package:hadith_app/config/themes/app_theme.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'injection_container.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HadithCubit>(
      create: (context) => di.sl<HadithCubit>(),
      child: MaterialApp(
        theme: appTheme(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate, // Here !
          DefaultWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          // Locale('en'),
          Locale('ar'),
        ],
        locale: const Locale('ar'),
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
