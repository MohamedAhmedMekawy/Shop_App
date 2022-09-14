import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Modules/login/cubit/cubit.dart';
import 'package:shopping_app/Modules/login/login_screen.dart';
import 'package:shopping_app/Modules/on_boarding/onboarding_screen.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/layout/appcubit/appCubit.dart';
import 'package:shopping_app/layout/appcubit/appState.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/home_layot/layout_screen.dart';
import 'package:shopping_app/observer.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isDark = CacheHelper.getData(key: 'isDark');
    token = CacheHelper.getData(key: 'token');
  if(onBoarding != null){
    if(token != null) widget = ShopLayoutScreen();
    else widget = ShopLoginScreen();
  }
  else
    {
      widget = OnBoardingScreen();
    }
  print(token);
  print(onBoarding);
  DioHelper.init();
  runApp(MyApp(
    isDark: isDark,
startWidget: widget,
  ));
}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDark;
  MyApp({
    required this.startWidget,
     this.isDark
});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => ShopLayoutCubit()..getHomeData()..getCategories()..getFavorite()..getCart()..getAddress()..getUserData()..getFaqs()..getOrders(),
        ),
        BlocProvider(
          create: (context) => ShopRegisterCubit()..changePasswordModel,),
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return   MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,

                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  titleTextStyle: GoogleFonts.atkinsonHyperlegible(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  elevation: 30,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,

                )
            ),
            darkTheme: ThemeData(

                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.blue,
              backgroundColor: Colors.red,
              appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.light,
                        statusBarColor: HexColor('333739')
                    ),
                    backgroundColor: HexColor('333739'),
                    iconTheme: IconThemeData(
                        color: Colors.white
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  elevation: 0,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white
                    )
                ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },

      ),
    );
  }
}
