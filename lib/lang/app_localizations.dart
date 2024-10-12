import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @onboarding_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboarding_continue;

  /// No description provided for @onboarding_previous_btn.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_previous_btn;

  /// No description provided for @onboarding_start_btn.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboarding_start_btn;

  /// No description provided for @onboarding_late_btn.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get onboarding_late_btn;

  /// No description provided for @onboarding_title_one.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Caffely'**
  String get onboarding_title_one;

  /// No description provided for @onboarding_subtitle_one.
  ///
  /// In en, this message translates to:
  /// **'Quickly order your coffee with Caffely.'**
  String get onboarding_subtitle_one;

  /// No description provided for @onboarding_title_second.
  ///
  /// In en, this message translates to:
  /// **'Start Using Caffely'**
  String get onboarding_title_second;

  /// No description provided for @onboarding_subtitle_second.
  ///
  /// In en, this message translates to:
  /// **'Order the coffee that suits you best from your nearest branch.'**
  String get onboarding_subtitle_second;

  /// No description provided for @onboarding_title_three.
  ///
  /// In en, this message translates to:
  /// **'Coffee Ordering is Now Easier'**
  String get onboarding_title_three;

  /// No description provided for @onboarding_subtitle_three.
  ///
  /// In en, this message translates to:
  /// **'Log in to order coffee with Caffely.'**
  String get onboarding_subtitle_three;

  /// No description provided for @version_title.
  ///
  /// In en, this message translates to:
  /// **'New Version Released!'**
  String get version_title;

  /// No description provided for @version_subtitle.
  ///
  /// In en, this message translates to:
  /// **'The new version of the Caffely App is now available. Update it from your app store.'**
  String get version_subtitle;

  /// No description provided for @version_btn.
  ///
  /// In en, this message translates to:
  /// **'Go to Store'**
  String get version_btn;

  /// No description provided for @sign_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Caffely'**
  String get sign_title;

  /// No description provided for @sign_google_sign_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get sign_google_sign_btn;

  /// No description provided for @sign_email_sign_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get sign_email_sign_btn;

  /// No description provided for @sign_signup_title.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get sign_signup_title;

  /// No description provided for @sign_signup_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get sign_signup_btn;

  /// No description provided for @sign_email_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in👩‍💻'**
  String get sign_email_title;

  /// No description provided for @sign_email_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your account details to log in to Caffely'**
  String get sign_email_subtitle;

  /// No description provided for @sign_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get sign_email;

  /// No description provided for @sign_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get sign_password;

  /// No description provided for @sign_remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get sign_remember_me;

  /// No description provided for @sign_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get sign_forgot_password;

  /// No description provided for @sign_signup.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get sign_signup;

  /// No description provided for @sign_sign_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_sign_btn;

  /// No description provided for @sign_error.
  ///
  /// In en, this message translates to:
  /// **'No user found in the session'**
  String get sign_error;

  /// No description provided for @sign_email_verified_error.
  ///
  /// In en, this message translates to:
  /// **'Please verify your account'**
  String get sign_email_verified_error;

  /// No description provided for @sign_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User Not Found'**
  String get sign_user_not_found;

  /// No description provided for @sign_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get sign_wrong_password;

  /// No description provided for @sign_too_many_request.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts, your account has been blocked. Please try again later.'**
  String get sign_too_many_request;

  /// No description provided for @sign_user_disabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get sign_user_disabled;

  /// No description provided for @sign_auth_exception_error.
  ///
  /// In en, this message translates to:
  /// **'Invalid information, please check your details.'**
  String get sign_auth_exception_error;

  /// No description provided for @sign_catch_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get sign_catch_error;

  /// No description provided for @sign_google_success.
  ///
  /// In en, this message translates to:
  /// **'Signing in with your Google Account.'**
  String get sign_google_success;

  /// No description provided for @sign_google_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during sign-in, please try again later.'**
  String get sign_google_error;

  /// No description provided for @sign_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Signing in to Your Account'**
  String get sign_loading_title;

  /// No description provided for @sign_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get sign_loading_subtitle;

  /// No description provided for @signup_email_title.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signup_email_title;

  /// No description provided for @signup_email_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account and sign in to Caffely'**
  String get signup_email_subtitle;

  /// No description provided for @signup_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signup_email;

  /// No description provided for @signup_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signup_password;

  /// No description provided for @signup_user_agreement.
  ///
  /// In en, this message translates to:
  /// **'I accept the User Agreement.'**
  String get signup_user_agreement;

  /// No description provided for @signup_agreement.
  ///
  /// In en, this message translates to:
  /// **'User Agreement'**
  String get signup_agreement;

  /// No description provided for @signup_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signup_btn;

  /// No description provided for @signup_sign.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signup_sign;

  /// No description provided for @signup_sign_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signup_sign_btn;

  /// No description provided for @signup_agreement_error.
  ///
  /// In en, this message translates to:
  /// **'You need to accept the agreement'**
  String get signup_agreement_error;

  /// No description provided for @signup_success.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully created!'**
  String get signup_success;

  /// No description provided for @signup_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'This email address is already in use.'**
  String get signup_email_already_in_use;

  /// No description provided for @signup_email_erorr.
  ///
  /// In en, this message translates to:
  /// **'Registration failed.'**
  String get signup_email_erorr;

  /// No description provided for @signup_error.
  ///
  /// In en, this message translates to:
  /// **'Registration failed.'**
  String get signup_error;

  /// No description provided for @signup_loading.
  ///
  /// In en, this message translates to:
  /// **'Please Wait'**
  String get signup_loading;

  /// No description provided for @sign_complete_title.
  ///
  /// In en, this message translates to:
  /// **'Complete Caffely Account Information👤'**
  String get sign_complete_title;

  /// No description provided for @sign_complete_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You need to complete your account information to get started.'**
  String get sign_complete_subtitle;

  /// No description provided for @sign_complete_name_surname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get sign_complete_name_surname;

  /// No description provided for @sign_complete_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get sign_complete_phone_number;

  /// No description provided for @sign_complete_city_error.
  ///
  /// In en, this message translates to:
  /// **'Please select city and district information'**
  String get sign_complete_city_error;

  /// No description provided for @sign_complete_btn.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get sign_complete_btn;

  /// No description provided for @sign_complete_success_title.
  ///
  /// In en, this message translates to:
  /// **'All Done!'**
  String get sign_complete_success_title;

  /// No description provided for @sign_complete_success_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Since your Caffely account details are complete, you can now log in.'**
  String get sign_complete_success_subtitle;

  /// No description provided for @sign_complete_start_btn.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get sign_complete_start_btn;

  /// No description provided for @sign_complete_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while completing your profile, please try again later.'**
  String get sign_complete_error;

  /// No description provided for @sign_complete_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Signing in to Your Account'**
  String get sign_complete_loading_title;

  /// No description provided for @sign_complete_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get sign_complete_loading_subtitle;

  /// No description provided for @agreement_appbar.
  ///
  /// In en, this message translates to:
  /// **'Caffely User Agreement'**
  String get agreement_appbar;

  /// No description provided for @account_appbar.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get account_appbar;

  /// No description provided for @account_save_adress_menu.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get account_save_adress_menu;

  /// No description provided for @account_campaign_discaoun_menu.
  ///
  /// In en, this message translates to:
  /// **'Campaigns and Discounts'**
  String get account_campaign_discaoun_menu;

  /// No description provided for @account_menu_group_title.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get account_menu_group_title;

  /// No description provided for @account_personal_information_menu.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get account_personal_information_menu;

  /// No description provided for @account_notification_menu.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get account_notification_menu;

  /// No description provided for @account_security_menu.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get account_security_menu;

  /// No description provided for @account_langue_menu.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get account_langue_menu;

  /// No description provided for @account_langue_en_menu.
  ///
  /// In en, this message translates to:
  /// **'English (EN)'**
  String get account_langue_en_menu;

  /// No description provided for @account_langue_tr_menu.
  ///
  /// In en, this message translates to:
  /// **'Turkish (TR)'**
  String get account_langue_tr_menu;

  /// No description provided for @account_menu_group_second_title.
  ///
  /// In en, this message translates to:
  /// **'Other Settings'**
  String get account_menu_group_second_title;

  /// No description provided for @account_help_menu.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get account_help_menu;

  /// No description provided for @account_about_menu.
  ///
  /// In en, this message translates to:
  /// **'About Caffely'**
  String get account_about_menu;

  /// No description provided for @account_exit_menu.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get account_exit_menu;

  /// No description provided for @account_aboutapp_appbar.
  ///
  /// In en, this message translates to:
  /// **'About Caffely'**
  String get account_aboutapp_appbar;

  /// No description provided for @account_aboutapp_title.
  ///
  /// In en, this message translates to:
  /// **'About Caffely App'**
  String get account_aboutapp_title;

  /// No description provided for @account_aboutapp_subtitle.
  ///
  /// In en, this message translates to:
  /// **'The Caffely project was developed by Nuhcan ATAR and provided me with an opportunity to learn, explore, and further develop myself in mobile app development. During the development of this project, I focused on utilizing my limited time efficiently. Caffely was created with no commercial intent, aimed at personal growth and knowledge sharing with the community.\nThroughout the project, in addition to implementing what I have learned, I believed in the power of knowledge sharing with the mobile development community. As a result, I shared the project as open-source on GitHub.\nYou can find this project on my GitHub account (Nuhcan ATAR), accessible to anyone who wants to contribute to the mobile development world. If you are a mobile developer, you can review the open-source code, contribute, or share your suggestions and feedback. Your feedback is valuable for both the project and my personal growth. My goal is to create projects that benefit as many people as possible in the mobile development world and contribute to this field.\nIn conclusion, Caffely is not just an app; it is also a tool for knowledge sharing for mobile developers, an opportunity for personal growth, and a reflection of my journey in developing creative projects. You can review, enhance, and join me on this journey to broaden our knowledge in mobile development!'**
  String get account_aboutapp_subtitle;

  /// No description provided for @account_qrcode_appbar.
  ///
  /// In en, this message translates to:
  /// **'Caffely Profile QR Code'**
  String get account_qrcode_appbar;

  /// No description provided for @account_qrcode_create_btn.
  ///
  /// In en, this message translates to:
  /// **'Create QR Code'**
  String get account_qrcode_create_btn;

  /// No description provided for @account_qrcode_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified Account'**
  String get account_qrcode_verified;

  /// No description provided for @account_qrcode_create_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Creating QR Code'**
  String get account_qrcode_create_loading_title;

  /// No description provided for @account_qrcode_create_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'This might take a moment, please wait.'**
  String get account_qrcode_create_loading_subtitle;

  /// No description provided for @account_qrcode_not_exist_title.
  ///
  /// In en, this message translates to:
  /// **'Get discounted coffee with Caffely QR Code!'**
  String get account_qrcode_not_exist_title;

  /// No description provided for @account_qrcode_not_exist_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a QR code linked to your account and enjoy discounts on coffee at Caffely branches.'**
  String get account_qrcode_not_exist_subtitle;

  /// No description provided for @account_qrcode_error_title.
  ///
  /// In en, this message translates to:
  /// **'Caffely QR Code, Error Occurred'**
  String get account_qrcode_error_title;

  /// No description provided for @account_qrcode_error_subtitle.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while creating/showing the QR Code, please try again later.'**
  String get account_qrcode_error_subtitle;

  /// No description provided for @account_qrcode_error_subtitle_second.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while creating the QR Code, please try again later.'**
  String get account_qrcode_error_subtitle_second;

  /// No description provided for @account_campaign_discaount_title.
  ///
  /// In en, this message translates to:
  /// **'No campaigns or discounts available yet.'**
  String get account_campaign_discaount_title;

  /// No description provided for @account_campaign_discaount_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Campaigns and discounts are not available yet, but will be shared soon.'**
  String get account_campaign_discaount_subtitle;

  /// No description provided for @account_centerhelp_appbar.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get account_centerhelp_appbar;

  /// No description provided for @account_centerhelp_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Content in Help Center'**
  String get account_centerhelp_empty_title;

  /// No description provided for @account_centerhelp_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'It seems like there is nothing new in the help center yet. Please check back later.'**
  String get account_centerhelp_empty_subtitle;

  /// No description provided for @account_centerhelp_footer_btn.
  ///
  /// In en, this message translates to:
  /// **'Caffely WhatsApp Contact'**
  String get account_centerhelp_footer_btn;

  /// No description provided for @account_langue_appbar.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get account_langue_appbar;

  /// No description provided for @account_notification_appbar.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get account_notification_appbar;

  /// No description provided for @account_notification_title.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get account_notification_title;

  /// No description provided for @account_notification_subtitle.
  ///
  /// In en, this message translates to:
  /// **'The app requests your permission for order status or communication purposes.'**
  String get account_notification_subtitle;

  /// No description provided for @account_personal_information_appbar.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get account_personal_information_appbar;

  /// No description provided for @account_personal_information_name_surname.
  ///
  /// In en, this message translates to:
  /// **'Name Surname'**
  String get account_personal_information_name_surname;

  /// No description provided for @account_personal_information_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get account_personal_information_phone_number;

  /// No description provided for @account_personal_information_footer_btn.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get account_personal_information_footer_btn;

  /// No description provided for @account_personal_information_city_error.
  ///
  /// In en, this message translates to:
  /// **'Please select a city and district.'**
  String get account_personal_information_city_error;

  /// No description provided for @account_personal_information_success.
  ///
  /// In en, this message translates to:
  /// **'Profile information updated successfully!'**
  String get account_personal_information_success;

  /// No description provided for @account_personal_information_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while updating profile information, please try again later.'**
  String get account_personal_information_error;

  /// No description provided for @account_personal_information_loading.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get account_personal_information_loading;

  /// No description provided for @account_saveadress_appbar.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get account_saveadress_appbar;

  /// No description provided for @account_saveadress_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Saved Addresses.'**
  String get account_saveadress_empty_title;

  /// No description provided for @account_saveadress_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You have no saved addresses yet. You can create a new one now.'**
  String get account_saveadress_empty_subtitle;

  /// No description provided for @account_saveadress_create_appbar.
  ///
  /// In en, this message translates to:
  /// **'Create Address'**
  String get account_saveadress_create_appbar;

  /// No description provided for @account_saveadress_title.
  ///
  /// In en, this message translates to:
  /// **'Address Title'**
  String get account_saveadress_title;

  /// No description provided for @account_saveadress_street.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood/Street'**
  String get account_saveadress_street;

  /// No description provided for @account_saveadress_apartment.
  ///
  /// In en, this message translates to:
  /// **'Building Number'**
  String get account_saveadress_apartment;

  /// No description provided for @account_saveadress_floor.
  ///
  /// In en, this message translates to:
  /// **'Door Number'**
  String get account_saveadress_floor;

  /// No description provided for @account_saveadress_directions.
  ///
  /// In en, this message translates to:
  /// **'Address Directions'**
  String get account_saveadress_directions;

  /// No description provided for @account_saveadress_contact_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get account_saveadress_contact_name;

  /// No description provided for @account_saveadress_contact_surname.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get account_saveadress_contact_surname;

  /// No description provided for @account_saveadress_contact_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get account_saveadress_contact_phone_number;

  /// No description provided for @account_saveadress_save_button.
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get account_saveadress_save_button;

  /// No description provided for @account_saveadress_edit_appbar.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get account_saveadress_edit_appbar;

  /// No description provided for @account_saveadress_edit_btn.
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get account_saveadress_edit_btn;

  /// No description provided for @account_saveadress_city_error.
  ///
  /// In en, this message translates to:
  /// **'Please select a city and district.'**
  String get account_saveadress_city_error;

  /// No description provided for @account_saveadress_load_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving the address, please try again later.'**
  String get account_saveadress_load_error;

  /// No description provided for @account_saveadress_create_succcess.
  ///
  /// In en, this message translates to:
  /// **'Address saved successfully.'**
  String get account_saveadress_create_succcess;

  /// No description provided for @account_saveadress_create_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving the address, please try again later.'**
  String get account_saveadress_create_error;

  /// No description provided for @account_saveadress_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Address deleted successfully.'**
  String get account_saveadress_delete_success;

  /// No description provided for @account_saveadress_delete_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while removing the address, please try again later.'**
  String get account_saveadress_delete_error;

  /// No description provided for @account_saveadress_edit_success.
  ///
  /// In en, this message translates to:
  /// **'Address updated successfully.'**
  String get account_saveadress_edit_success;

  /// No description provided for @account_saveadress_edit_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while updating the address, please try again later.'**
  String get account_saveadress_edit_error;

  /// No description provided for @account_security_appbar.
  ///
  /// In en, this message translates to:
  /// **'Security Settings'**
  String get account_security_appbar;

  /// No description provided for @account_security_forgot_password_menu.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get account_security_forgot_password_menu;

  /// No description provided for @home_appbar_good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get home_appbar_good_evening;

  /// No description provided for @home_appbar_good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get home_appbar_good_morning;

  /// No description provided for @home_appbar_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get home_appbar_unknown;

  /// No description provided for @home_stores_list_title.
  ///
  /// In en, this message translates to:
  /// **'Caffely Branches'**
  String get home_stores_list_title;

  /// No description provided for @home_stores_list_next.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get home_stores_list_next;

  /// No description provided for @home_popular_products_list_title.
  ///
  /// In en, this message translates to:
  /// **'Popular Coffees'**
  String get home_popular_products_list_title;

  /// No description provided for @home_popular_products_list_next.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get home_popular_products_list_next;

  /// No description provided for @forgot_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password? 🔑'**
  String get forgot_password_title;

  /// No description provided for @forgot_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address registered to your account and quickly reset your password.'**
  String get forgot_password_subtitle;

  /// No description provided for @forgot_password_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get forgot_password_email;

  /// No description provided for @forgot_password_correct_btn.
  ///
  /// In en, this message translates to:
  /// **'VERIFY'**
  String get forgot_password_correct_btn;

  /// No description provided for @forgot_password_success.
  ///
  /// In en, this message translates to:
  /// **'A password reset email has been sent to your email address.'**
  String get forgot_password_success;

  /// No description provided for @forgot_password_error.
  ///
  /// In en, this message translates to:
  /// **'Email address not found, please check your email address.'**
  String get forgot_password_error;

  /// No description provided for @forgot_password_email_error.
  ///
  /// In en, this message translates to:
  /// **'Email address not found, please check your email address.'**
  String get forgot_password_email_error;

  /// No description provided for @forgot_password_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Logging into your account'**
  String get forgot_password_loading_title;

  /// No description provided for @forgot_password_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get forgot_password_loading_subtitle;

  /// No description provided for @products_appbar.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products_appbar;

  /// No description provided for @products_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Loading Products'**
  String get products_loading_title;

  /// No description provided for @products_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get products_loading_subtitle;

  /// No description provided for @products_search.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get products_search;

  /// No description provided for @products_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get products_empty_title;

  /// No description provided for @products_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'No products found, you can browse other items if you like.'**
  String get products_empty_subtitle;

  /// No description provided for @products_avaible.
  ///
  /// In en, this message translates to:
  /// **'Coffee Temperature'**
  String get products_avaible;

  /// No description provided for @products_hot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get products_hot;

  /// No description provided for @products_ice.
  ///
  /// In en, this message translates to:
  /// **'Iced'**
  String get products_ice;

  /// No description provided for @products_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get products_size;

  /// No description provided for @products_size_small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get products_size_small;

  /// No description provided for @products_size_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get products_size_medium;

  /// No description provided for @products_size_large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get products_size_large;

  /// No description provided for @products_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get products_total_price;

  /// No description provided for @products_basket_add_btn.
  ///
  /// In en, this message translates to:
  /// **'Add to Basket'**
  String get products_basket_add_btn;

  /// No description provided for @products_basket_add_select_error.
  ///
  /// In en, this message translates to:
  /// **'Please make your coffee selection'**
  String get products_basket_add_select_error;

  /// No description provided for @products_store_favorite_add_success.
  ///
  /// In en, this message translates to:
  /// **'Branch added to favorites!'**
  String get products_store_favorite_add_success;

  /// No description provided for @products_store_favorite_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Branch removed from favorites!'**
  String get products_store_favorite_delete_success;

  /// No description provided for @products_favorite_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later.'**
  String get products_favorite_error;

  /// No description provided for @products_basket_add_success.
  ///
  /// In en, this message translates to:
  /// **'Product added to basket!'**
  String get products_basket_add_success;

  /// No description provided for @products_basket_add_error.
  ///
  /// In en, this message translates to:
  /// **'There was an issue adding the product to the basket.'**
  String get products_basket_add_error;

  /// No description provided for @favorite_appbar.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorite_appbar;

  /// No description provided for @favorite_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get favorite_loading_title;

  /// No description provided for @favorite_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get favorite_loading_subtitle;

  /// No description provided for @favorite_contained_tabs_product.
  ///
  /// In en, this message translates to:
  /// **'Coffees'**
  String get favorite_contained_tabs_product;

  /// No description provided for @favorite_contained_tabs_stores.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get favorite_contained_tabs_stores;

  /// No description provided for @favorite_stores_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Branches Found'**
  String get favorite_stores_empty_title;

  /// No description provided for @favorite_stores_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You currently have no favorite branches, you can start adding your favorite branches if you like.'**
  String get favorite_stores_empty_subtitle;

  /// No description provided for @favorite_products_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get favorite_products_empty_title;

  /// No description provided for @favorite_products_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You currently have no favorite products, you can start adding your favorite items if you like.'**
  String get favorite_products_empty_subtitle;

  /// No description provided for @stores_appbar.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get stores_appbar;

  /// No description provided for @stores_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Loading Branches'**
  String get stores_loading_title;

  /// No description provided for @stores_loading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get stores_loading_subtitle;

  /// No description provided for @stores_search.
  ///
  /// In en, this message translates to:
  /// **'Search branches'**
  String get stores_search;

  /// No description provided for @stores_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Caffely Branches Found'**
  String get stores_empty_title;

  /// No description provided for @stores_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'No Caffely Branches found, you may search for another branch.'**
  String get stores_empty_subtitle;

  /// No description provided for @stores_detail_location_not_found.
  ///
  /// In en, this message translates to:
  /// **'URL Address Not Found'**
  String get stores_detail_location_not_found;

  /// No description provided for @stores_information_appbar.
  ///
  /// In en, this message translates to:
  /// **'About the Branch'**
  String get stores_information_appbar;

  /// No description provided for @stores_information_opening_time.
  ///
  /// In en, this message translates to:
  /// **'Opens at'**
  String get stores_information_opening_time;

  /// No description provided for @stores_information_close_time.
  ///
  /// In en, this message translates to:
  /// **'Open until'**
  String get stores_information_close_time;

  /// No description provided for @stores_information_trade_name.
  ///
  /// In en, this message translates to:
  /// **'Seller\'s Trade Name'**
  String get stores_information_trade_name;

  /// No description provided for @stores_information_payment_type.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get stores_information_payment_type;

  /// No description provided for @stores_information_delivery_type.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get stores_information_delivery_type;

  /// No description provided for @stores_information_delivery_type_explanation.
  ///
  /// In en, this message translates to:
  /// **'The delivery fee is determined by the distance and time of day.'**
  String get stores_information_delivery_type_explanation;

  /// No description provided for @stores_information_min_basket_value.
  ///
  /// In en, this message translates to:
  /// **'Min. Basket Value'**
  String get stores_information_min_basket_value;

  /// No description provided for @stores_information_min_basket_explanation.
  ///
  /// In en, this message translates to:
  /// **'This branch does not accept orders below'**
  String get stores_information_min_basket_explanation;

  /// No description provided for @stores_information_min_basket_explanation_second.
  ///
  /// In en, this message translates to:
  /// **'TL.'**
  String get stores_information_min_basket_explanation_second;

  /// No description provided for @stores_information_location_btn.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get stores_information_location_btn;

  /// No description provided for @stores_information_location_not_found.
  ///
  /// In en, this message translates to:
  /// **'Directions Not Found!'**
  String get stores_information_location_not_found;

  /// No description provided for @stores_information_call_btn.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get stores_information_call_btn;

  /// No description provided for @stores_information_call_error.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Not Found!'**
  String get stores_information_call_error;

  /// No description provided for @stores_information_favorite_add_success.
  ///
  /// In en, this message translates to:
  /// **'Branch added to favorites!'**
  String get stores_information_favorite_add_success;

  /// No description provided for @stores_information_favorite_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Branch removed from favorites!'**
  String get stores_information_favorite_delete_success;

  /// No description provided for @stores_information_favorite_add_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later.'**
  String get stores_information_favorite_add_error;

  /// No description provided for @stores_information_favorite_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get stores_information_favorite_loading_title;

  /// No description provided for @notification_appbar.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_appbar;

  /// No description provided for @basket_appbar.
  ///
  /// In en, this message translates to:
  /// **'Basket'**
  String get basket_appbar;

  /// No description provided for @basket_product_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Products in the Basket Yet'**
  String get basket_product_empty_title;

  /// No description provided for @basket_product_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'There are no products in your basket yet, you can start adding products if you like.'**
  String get basket_product_empty_subtitle;

  /// No description provided for @basket_product_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get basket_product_error;

  /// No description provided for @basket_store_product_empty.
  ///
  /// In en, this message translates to:
  /// **'No Products Belonging to the Branch'**
  String get basket_store_product_empty;

  /// No description provided for @basket_complete_btn.
  ///
  /// In en, this message translates to:
  /// **'Complete the Order'**
  String get basket_complete_btn;

  /// No description provided for @basket_complete_empty_error.
  ///
  /// In en, this message translates to:
  /// **'There are no products in your basket'**
  String get basket_complete_empty_error;

  /// No description provided for @basket_order_complete_appbar.
  ///
  /// In en, this message translates to:
  /// **'Complete the Order'**
  String get basket_order_complete_appbar;

  /// No description provided for @basket_order_complete_product_quanity.
  ///
  /// In en, this message translates to:
  /// **'Product Quantity'**
  String get basket_order_complete_product_quanity;

  /// No description provided for @basket_order_complete_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get basket_order_complete_total_price;

  /// No description provided for @basket_order_complete_main_total.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get basket_order_complete_main_total;

  /// No description provided for @basket_order_complete_create_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Order'**
  String get basket_order_complete_create_btn;

  /// No description provided for @basket_order_complete_control_branches_empty.
  ///
  /// In en, this message translates to:
  /// **'No Branches in the Basket Yet!'**
  String get basket_order_complete_control_branches_empty;

  /// No description provided for @basket_order_complete_products_empty.
  ///
  /// In en, this message translates to:
  /// **'No Products in the Basket Yet!'**
  String get basket_order_complete_products_empty;

  /// No description provided for @basket_order_complete_erorr_btn.
  ///
  /// In en, this message translates to:
  /// **'Please mark your order details!'**
  String get basket_order_complete_erorr_btn;

  /// No description provided for @basket_success_appbar.
  ///
  /// In en, this message translates to:
  /// **'Your Order Has Been Received'**
  String get basket_success_appbar;

  /// No description provided for @basket_success_title.
  ///
  /// In en, this message translates to:
  /// **'Thank You for Your Order'**
  String get basket_success_title;

  /// No description provided for @basket_success_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your order is being prepared for delivery. You can track your order in the orders section of your profile.'**
  String get basket_success_subtitle;

  /// No description provided for @basket_success_btn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get basket_success_btn;

  /// No description provided for @basket_quanity_erorr.
  ///
  /// In en, this message translates to:
  /// **'Quantity must be at least 1'**
  String get basket_quanity_erorr;

  /// No description provided for @basket_order_complete_success.
  ///
  /// In en, this message translates to:
  /// **'Your order has been successfully created.'**
  String get basket_order_complete_success;

  /// No description provided for @basket_order_complete_error.
  ///
  /// In en, this message translates to:
  /// **'There was an error creating the order'**
  String get basket_order_complete_error;

  /// No description provided for @basket_loading_title.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get basket_loading_title;

  /// No description provided for @order_appbar.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get order_appbar;

  /// No description provided for @order_error_title.
  ///
  /// In en, this message translates to:
  /// **'Orders Not Found'**
  String get order_error_title;

  /// No description provided for @order_error_subtitle.
  ///
  /// In en, this message translates to:
  /// **'There was an error loading the orders, please try again later.'**
  String get order_error_subtitle;

  /// No description provided for @order_empty_title.
  ///
  /// In en, this message translates to:
  /// **'You Have No Orders'**
  String get order_empty_title;

  /// No description provided for @order_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t created a new order yet, you can start creating a new order if you like.'**
  String get order_empty_subtitle;

  /// No description provided for @order_detail_appbar.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_detail_appbar;

  /// No description provided for @order_detail_basket_erorr_title.
  ///
  /// In en, this message translates to:
  /// **'Order Details Not Found'**
  String get order_detail_basket_erorr_title;

  /// No description provided for @order_detail_basket_error_subtitle.
  ///
  /// In en, this message translates to:
  /// **'There was an issue loading the order details, please try again later.'**
  String get order_detail_basket_error_subtitle;

  /// No description provided for @order_detail_basket_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Order Details Not Found'**
  String get order_detail_basket_empty_title;

  /// No description provided for @order_detail_basket_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'There was an issue loading the order details, please try again later.'**
  String get order_detail_basket_empty_subtitle;

  /// No description provided for @order_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get order_error;

  /// No description provided for @account_exit_title.
  ///
  /// In en, this message translates to:
  /// **'Logging Out'**
  String get account_exit_title;

  /// No description provided for @account_exit_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get account_exit_subtitle;

  /// No description provided for @account_exit_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get account_exit_yes;

  /// No description provided for @account_exit_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get account_exit_no;

  /// No description provided for @permission_appbar.
  ///
  /// In en, this message translates to:
  /// **'PERMISSION MANAGEMENT'**
  String get permission_appbar;

  /// No description provided for @permission_title.
  ///
  /// In en, this message translates to:
  /// **'You Cannot Turn Off Permissions!'**
  String get permission_title;

  /// No description provided for @permission_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can enable permissions within the app, but you cannot turn them off. To manage permissions, please go to the app settings.'**
  String get permission_subtitle;

  /// No description provided for @permission_app_setting_btn.
  ///
  /// In en, this message translates to:
  /// **'GO TO APP SETTINGS'**
  String get permission_app_setting_btn;

  /// No description provided for @validator_error.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get validator_error;

  /// No description provided for @validator_invalid_value.
  ///
  /// In en, this message translates to:
  /// **'Invalid Value'**
  String get validator_invalid_value;

  /// No description provided for @validator_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Email field cannot be empty'**
  String get validator_email_empty;

  /// No description provided for @validator_email_error.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get validator_email_error;

  /// No description provided for @validator_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password field cannot be empty'**
  String get validator_password_empty;

  /// No description provided for @validator_password_error_one.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get validator_password_error_one;

  /// No description provided for @validator_password_error_second.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get validator_password_error_second;

  /// No description provided for @validator_password_error_three.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get validator_password_error_three;

  /// No description provided for @validator_password_error_four.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one digit'**
  String get validator_password_error_four;

  /// No description provided for @validator_password_error_five.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get validator_password_error_five;

  /// No description provided for @validator_phone_number_empty.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get validator_phone_number_empty;

  /// No description provided for @validator_phone_number_error.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number'**
  String get validator_phone_number_error;

  /// No description provided for @validator_phone_number_error_second.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number'**
  String get validator_phone_number_error_second;

  /// No description provided for @adress_select_title.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get adress_select_title;

  /// No description provided for @adress_select_add.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get adress_select_add;

  /// No description provided for @adress_select.
  ///
  /// In en, this message translates to:
  /// **'Select Delivery Address'**
  String get adress_select;

  /// No description provided for @adress_edit_btn.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adress_edit_btn;

  /// No description provided for @adress_delete_btn.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adress_delete_btn;

  /// No description provided for @adress_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want to Delete the Address?'**
  String get adress_dialog_title;

  /// No description provided for @basket_product_list_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get basket_product_list_size;

  /// No description provided for @basket_product_list_avaible.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get basket_product_list_avaible;

  /// No description provided for @location_menu_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get location_menu_city;

  /// No description provided for @location_menu_district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get location_menu_district;

  /// No description provided for @order_card_date.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get order_card_date;

  /// No description provided for @order_card_detail_btn.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_card_detail_btn;

  /// No description provided for @order_card_online_payment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get order_card_online_payment;

  /// No description provided for @order_card_payatthe_door.
  ///
  /// In en, this message translates to:
  /// **'Pay at the Door'**
  String get order_card_payatthe_door;

  /// No description provided for @order_paymentdetail_card_title.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get order_paymentdetail_card_title;

  /// No description provided for @order_paymentdetail_card_payment_type.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get order_paymentdetail_card_payment_type;

  /// No description provided for @order_paymentdetail_card_online_payment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get order_paymentdetail_card_online_payment;

  /// No description provided for @order_paymentdetail_card_atthe_door.
  ///
  /// In en, this message translates to:
  /// **'Pay at the Door'**
  String get order_paymentdetail_card_atthe_door;

  /// No description provided for @order_paymentdetail_card_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get order_paymentdetail_card_total_price;

  /// No description provided for @order_paymentdetail_card_quanity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get order_paymentdetail_card_quanity;

  /// No description provided for @order_paymentdetail_card_service_price.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get order_paymentdetail_card_service_price;

  /// No description provided for @order_paymentdetail_card_delivery_price.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get order_paymentdetail_card_delivery_price;

  /// No description provided for @order_paymentdetail_card_total_pay.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get order_paymentdetail_card_total_pay;

  /// No description provided for @order_product_card_quanity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get order_product_card_quanity;

  /// No description provided for @order_product_card_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get order_product_card_size;

  /// No description provided for @order_product_card_small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get order_product_card_small;

  /// No description provided for @order_product_card_middle.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get order_product_card_middle;

  /// No description provided for @order_product_card_large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get order_product_card_large;

  /// No description provided for @order_product_card_avaible.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get order_product_card_avaible;

  /// No description provided for @order_product_card_not_select.
  ///
  /// In en, this message translates to:
  /// **'No Selection'**
  String get order_product_card_not_select;

  /// No description provided for @order_product_card_hot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get order_product_card_hot;

  /// No description provided for @order_product_card_ice.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get order_product_card_ice;

  /// No description provided for @order_product_card_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get order_product_card_price;

  /// No description provided for @order_product_card_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get order_product_card_total_price;

  /// No description provided for @order_status_card_one.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get order_status_card_one;

  /// No description provided for @order_status_card_second.
  ///
  /// In en, this message translates to:
  /// **'Being Prepared'**
  String get order_status_card_second;

  /// No description provided for @order_status_card_three.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get order_status_card_three;

  /// No description provided for @order_status.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get order_status;

  /// No description provided for @order_status_rejected.
  ///
  /// In en, this message translates to:
  /// **'Order Canceled'**
  String get order_status_rejected;

  /// No description provided for @order_status_received.
  ///
  /// In en, this message translates to:
  /// **'Order Received'**
  String get order_status_received;

  /// No description provided for @order_status_inprogress.
  ///
  /// In en, this message translates to:
  /// **'Order Being Prepared'**
  String get order_status_inprogress;

  /// No description provided for @order_status_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Order on the Way'**
  String get order_status_on_the_way;

  /// No description provided for @order_status_delivered.
  ///
  /// In en, this message translates to:
  /// **'Order Delivered'**
  String get order_status_delivered;

  /// No description provided for @order_status_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get order_status_unknow;

  /// No description provided for @payment_type_select_title.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_type_select_title;

  /// No description provided for @payment_type_online_payment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get payment_type_online_payment;

  /// No description provided for @payment_type_atthe_door.
  ///
  /// In en, this message translates to:
  /// **'Pay at the Door'**
  String get payment_type_atthe_door;

  /// No description provided for @product_basket_card_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get product_basket_card_size;

  /// No description provided for @product_basket_card_avaible.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get product_basket_card_avaible;

  /// No description provided for @store_card_min_basket_value.
  ///
  /// In en, this message translates to:
  /// **'Minimum Basket Amount in TL'**
  String get store_card_min_basket_value;

  /// No description provided for @store_card_free_delivery.
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get store_card_free_delivery;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
