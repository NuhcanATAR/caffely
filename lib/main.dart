import 'package:caffely/feature/complete/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/event.dart';
import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/password/bloc/cubit.dart';
import 'package:caffely/feature/sign_in/bloc/cubit.dart';
import 'package:caffely/feature/sign_up/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/main_viewmodel.dart';
import 'package:caffely/product/initialize/app_start.dart';
import 'package:caffely/product/theme/light_theme.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/favorite/bloc/cubit.dart';
import 'feature/products/bloc/cubit.dart';
import 'product/constants/logo.dart';

void main() async {
  await AppStart.initStartApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(),
        ),
        BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(),
        ),
        BlocProvider<PasswordBloc>(
          create: (BuildContext context) => PasswordBloc(),
        ),
        BlocProvider<ProfileCompleteBloc>(
          create: (BuildContext context) => ProfileCompleteBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc()..add(LoadHome()),
        ),
        BlocProvider<StoreBloc>(
          create: (BuildContext context) => StoreBloc()..add(LoadStores("")),
        ),
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => ProductBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (BuildContext context) =>
              FavoriteBloc()..add(LoadFavoriteProduct()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomLightTheme().themeData,
        themeMode: ThemeMode.light,
        home: const FirsView(),
      ),
    );
  }
}

class FirsView extends StatefulWidget {
  const FirsView({super.key});

  @override
  State<FirsView> createState() => _FirsViewState();
}

class _FirsViewState extends MainViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isInitialized
            ? Padding(
                padding: PaddingSizedsUtility.all(
                  130,
                ),
                child: Center(
                  child: Container(
                    padding: PaddingSizedsUtility.all(
                      PaddingSizedsUtility.smallPaddingValue,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          RadiusUtility.circularMediumValue,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: AppLogoConstants.appLogoTextPrimaryColor.toImg,
                  ),
                ),
              )
            : Padding(
                padding: PaddingSizedsUtility.all(
                  130,
                ),
                child: Center(
                  child: Container(
                    padding: PaddingSizedsUtility.all(
                      PaddingSizedsUtility.smallPaddingValue,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          RadiusUtility.circularMediumValue,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: AppLogoConstants.appLogoTextPrimaryColor.toImg,
                  ),
                ),
              ),
      ),
    );
  }
}
