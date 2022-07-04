import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_internship_task/presentation/router/app_router.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import 'app_local.dart';
import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'business_logic/localize_cubit/localize_cubit.dart';
import 'business_logic/login_cubit/login_cubit.dart';
import 'business_logic/register_cubit/register_cubit.dart';
import 'data/local/cache_helper.dart';
import 'data/network/responses/login_respository.dart';
import 'data/network/responses/register_repository.dart';
import 'data/remote/dio_helper.dart';


//late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
      DioHelper.init();
      await CacheHelper.init();
      final locale =
          CacheHelper.getDataFromSharedPreference(key: 'language') ?? "en";
      /*delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));*/
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //Intl.defaultLocale = delegate.currentLocale.languageCode;

    /*delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        showToast(e.toString());
      }
    };*/
  }

  @override
  Widget build(BuildContext context) {
    LocalizeState localState;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => GlobalCubit()),
        ),
        BlocProvider(
          create: ((context) => LocalizeCubit()),
        ),
        BlocProvider(
          create: ((context) => LoginCubit(loginRepository: LoginRepository())),
        ),
        BlocProvider(
          create: ((context) => RegisterCubit(registerRepository: RegisterRepository())),
        ),
      ],
      child: BlocBuilder<LocalizeCubit, LocalizeState>(
        buildWhen: (previousState, currentState) => previousState != currentState,
        builder: (context, state) {
          localState=state;
          return Sizer(
            builder: (context, orientation, deviceType) {
              return
                LayoutBuilder(builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Werash',
                      localizationsDelegates: const [
                        AppLocale.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        DefaultCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        //delegate,
                      ],
                      localeResolutionCallback: (currentLang, supportLang) {
                        if (currentLang != null) {
                          for (Locale locale in supportLang) {
                            if (locale.languageCode == currentLang.languageCode) {
                              CacheHelper.saveDataSharedPreference(key: 'language', value: currentLang.languageCode);
                              return currentLang;
                            }
                          }
                        }
                        return supportLang.first;
                      },
                      locale:localState.locale ,
                      supportedLocales: const [
                        Locale("en", ""),
                        Locale("ar", ""),
                      ],//supportedLocales: delegate.supportedLocales,
                      onGenerateRoute: widget.appRouter.onGenerateRoute,
                      theme: ThemeData(
                        fontFamily: 'cairo',
                        //scaffoldBackgroundColor: AppColors.white,
                        appBarTheme: const AppBarTheme(
                          elevation: 0.0,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            //statusBarColor: AppColors.transparent,
                            statusBarIconBrightness: Brightness.dark,
                          ),
                        ),
                      ),
                    ),
                  );
                });
            },
          );
        },
      ),
    );
  }
}