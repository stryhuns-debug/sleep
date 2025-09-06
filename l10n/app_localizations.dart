import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep Schedule Fixer'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @wakeUpButton.
  ///
  /// In en, this message translates to:
  /// **'I WOKE UP'**
  String get wakeUpButton;

  /// No description provided for @wakeUpTitle.
  ///
  /// In en, this message translates to:
  /// **'I woke up'**
  String get wakeUpTitle;

  /// No description provided for @wakeUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Wake up time'**
  String get wakeUpDescription;

  /// No description provided for @alreadyWokeUp.
  ///
  /// In en, this message translates to:
  /// **'You already woke up today!'**
  String get alreadyWokeUp;

  /// No description provided for @wakeUpTime.
  ///
  /// In en, this message translates to:
  /// **'Time: {time}'**
  String wakeUpTime(Object time);

  /// No description provided for @recordWakeUp.
  ///
  /// In en, this message translates to:
  /// **'RECORD WAKE UP'**
  String get recordWakeUp;

  /// No description provided for @todaysSchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s schedule:'**
  String get todaysSchedule;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Press the \"I woke up\" button when you wake up, and the app will create a personal daily schedule with gradual sleep schedule correction.'**
  String get welcomeMessage;

  /// No description provided for @defaultGoal.
  ///
  /// In en, this message translates to:
  /// **'Default goal: wake up at 8:00, sleep at 00:00'**
  String get defaultGoal;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Schedule'**
  String get scheduleTitle;

  /// No description provided for @noSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule not created'**
  String get noSchedule;

  /// No description provided for @noScheduleMessage.
  ///
  /// In en, this message translates to:
  /// **'Press \"I woke up\" on the home screen to create a personal daily schedule.'**
  String get noScheduleMessage;

  /// No description provided for @wakeUp.
  ///
  /// In en, this message translates to:
  /// **'I woke up'**
  String get wakeUp;

  /// No description provided for @morningWater.
  ///
  /// In en, this message translates to:
  /// **'Glass of water'**
  String get morningWater;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Physical activity'**
  String get exercise;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @eveningWater.
  ///
  /// In en, this message translates to:
  /// **'Last water intake'**
  String get eveningWater;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Alarm for tomorrow'**
  String get sleep;

  /// No description provided for @wakeUpDesc.
  ///
  /// In en, this message translates to:
  /// **'Wake up time'**
  String get wakeUpDesc;

  /// No description provided for @morningWaterDesc.
  ///
  /// In en, this message translates to:
  /// **'Morning glass of water'**
  String get morningWaterDesc;

  /// No description provided for @breakfastDesc.
  ///
  /// In en, this message translates to:
  /// **'Breakfast time'**
  String get breakfastDesc;

  /// No description provided for @exerciseDesc.
  ///
  /// In en, this message translates to:
  /// **'Time for exercise'**
  String get exerciseDesc;

  /// No description provided for @dinnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Dinner time'**
  String get dinnerDesc;

  /// No description provided for @eveningWaterDesc.
  ///
  /// In en, this message translates to:
  /// **'Evening glass of water'**
  String get eveningWaterDesc;

  /// No description provided for @sleepDesc.
  ///
  /// In en, this message translates to:
  /// **'Sleep time'**
  String get sleepDesc;

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'{time} • {timeUntil}'**
  String timeFormat(Object time, Object timeUntil);

  /// No description provided for @passed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passed;

  /// No description provided for @inMinutes.
  ///
  /// In en, this message translates to:
  /// **'In {minutes} min'**
  String inMinutes(Object minutes);

  /// No description provided for @inHours.
  ///
  /// In en, this message translates to:
  /// **'In {hours} h'**
  String inHours(Object hours);

  /// No description provided for @inHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'In {hours} h {minutes} min'**
  String inHoursMinutes(Object hours, Object minutes);

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'SOON'**
  String get soon;

  /// No description provided for @targetTimes.
  ///
  /// In en, this message translates to:
  /// **'Target times'**
  String get targetTimes;

  /// No description provided for @wakeUpTimeSetting.
  ///
  /// In en, this message translates to:
  /// **'Wake up time'**
  String get wakeUpTimeSetting;

  /// No description provided for @sleepTimeSetting.
  ///
  /// In en, this message translates to:
  /// **'Sleep time'**
  String get sleepTimeSetting;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @notificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Daily event reminders'**
  String get notificationsDescription;

  /// No description provided for @notificationMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes before notification'**
  String get notificationMinutes;

  /// No description provided for @alarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get alarm;

  /// No description provided for @builtInAlarm.
  ///
  /// In en, this message translates to:
  /// **'Built-in alarm'**
  String get builtInAlarm;

  /// No description provided for @alarmDescription.
  ///
  /// In en, this message translates to:
  /// **'App alarm'**
  String get alarmDescription;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @font.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get font;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background color'**
  String get backgroundColor;

  /// No description provided for @textColor.
  ///
  /// In en, this message translates to:
  /// **'Text color'**
  String get textColor;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get selectColor;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @timeFormatSetting.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get timeFormatSetting;

  /// No description provided for @format12h.
  ///
  /// In en, this message translates to:
  /// **'12-hour format'**
  String get format12h;

  /// No description provided for @format24h.
  ///
  /// In en, this message translates to:
  /// **'24-hour format'**
  String get format24h;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @wakeUpRecorded.
  ///
  /// In en, this message translates to:
  /// **'Wake up time recorded!'**
  String get wakeUpRecorded;

  /// No description provided for @alarmTitle.
  ///
  /// In en, this message translates to:
  /// **'ALARM'**
  String get alarmTitle;

  /// No description provided for @timeToWakeUp.
  ///
  /// In en, this message translates to:
  /// **'Time to wake up!'**
  String get timeToWakeUp;

  /// No description provided for @setFor.
  ///
  /// In en, this message translates to:
  /// **'Set for: {time}'**
  String setFor(Object time);

  /// No description provided for @stopAlarm.
  ///
  /// In en, this message translates to:
  /// **'STOP ALARM'**
  String get stopAlarm;

  /// No description provided for @snooze5min.
  ///
  /// In en, this message translates to:
  /// **'Snooze for 5 minutes'**
  String get snooze5min;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @selectFont.
  ///
  /// In en, this message translates to:
  /// **'Select font'**
  String get selectFont;

  /// No description provided for @selectBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Select background color'**
  String get selectBackgroundColor;

  /// No description provided for @selectTextColor.
  ///
  /// In en, this message translates to:
  /// **'Select text color'**
  String get selectTextColor;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
