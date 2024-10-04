// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:caffely/feature/account/view/accountqr_code/bloc/cubit.dart';
import 'package:caffely/feature/account/view/center_help/bloc/cubit.dart';
import 'package:caffely/feature/account/view/center_help/bloc/event.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/complete/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/event.dart';
import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/password/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/sign_in/bloc/cubit.dart';
import 'package:caffely/feature/sign_up/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/main_viewmodel.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/initialize/app_start.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:caffely/product/theme/light_theme.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStart.initStartApp();

  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage();

  runApp(
    ChangeNotifierProvider(
      create: (_) => languageProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

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
        BlocProvider<SavedAdressBloc>(
          create: (BuildContext context) =>
              SavedAdressBloc()..add(LoadSavedAdressEvent()),
        ),
        BlocProvider<PersonalInformationBloc>(
          create: (BuildContext context) => PersonalInformationBloc(),
        ),
        BlocProvider<QrCodeCubit>(
          create: (BuildContext context) => QrCodeCubit(),
        ),
        BlocProvider<CenterHelpBloc>(
          create: (BuildContext context) =>
              CenterHelpBloc()..add(LoadCenterHelpEvent()),
        ),
        BlocProvider<BasketBloc>(
          create: (BuildContext context) =>
              BasketBloc()..add(LoadBasketEvent()),
        ),
      ],
      child: MaterialApp(
        locale: Locale(languageProvider.selectedLanguage),
        supportedLocales: const [
          Locale('en', ''),
          Locale('tr', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
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
