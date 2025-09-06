// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sleep Schedule Fixer';

  @override
  String get home => 'Home';

  @override
  String get schedule => 'Schedule';

  @override
  String get settings => 'Settings';

  @override
  String get wakeUpButton => 'I WOKE UP';

  @override
  String get wakeUpTitle => 'I woke up';

  @override
  String get wakeUpDescription => 'Wake up time';

  @override
  String get alreadyWokeUp => 'You already woke up today!';

  @override
  String wakeUpTime(Object time) {
    return 'Time: $time';
  }

  @override
  String get recordWakeUp => 'RECORD WAKE UP';

  @override
  String get todaysSchedule => 'Today\'s schedule:';

  @override
  String get welcome => 'Welcome!';

  @override
  String get welcomeMessage =>
      'Press the \"I woke up\" button when you wake up, and the app will create a personal daily schedule with gradual sleep schedule correction.';

  @override
  String get defaultGoal => 'Default goal: wake up at 8:00, sleep at 00:00';

  @override
  String get scheduleTitle => 'Daily Schedule';

  @override
  String get noSchedule => 'Schedule not created';

  @override
  String get noScheduleMessage =>
      'Press \"I woke up\" on the home screen to create a personal daily schedule.';

  @override
  String get wakeUp => 'I woke up';

  @override
  String get morningWater => 'Glass of water';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get exercise => 'Physical activity';

  @override
  String get dinner => 'Dinner';

  @override
  String get eveningWater => 'Last water intake';

  @override
  String get sleep => 'Alarm for tomorrow';

  @override
  String get wakeUpDesc => 'Wake up time';

  @override
  String get morningWaterDesc => 'Morning glass of water';

  @override
  String get breakfastDesc => 'Breakfast time';

  @override
  String get exerciseDesc => 'Time for exercise';

  @override
  String get dinnerDesc => 'Dinner time';

  @override
  String get eveningWaterDesc => 'Evening glass of water';

  @override
  String get sleepDesc => 'Sleep time';

  @override
  String timeFormat(Object time, Object timeUntil) {
    return '$time • $timeUntil';
  }

  @override
  String get passed => 'Passed';

  @override
  String inMinutes(Object minutes) {
    return 'In $minutes min';
  }

  @override
  String inHours(Object hours) {
    return 'In $hours h';
  }

  @override
  String inHoursMinutes(Object hours, Object minutes) {
    return 'In $hours h $minutes min';
  }

  @override
  String get soon => 'SOON';

  @override
  String get targetTimes => 'Target times';

  @override
  String get wakeUpTimeSetting => 'Wake up time';

  @override
  String get sleepTimeSetting => 'Sleep time';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get notificationsDescription => 'Daily event reminders';

  @override
  String get notificationMinutes => 'Minutes before notification';

  @override
  String get alarm => 'Alarm';

  @override
  String get builtInAlarm => 'Built-in alarm';

  @override
  String get alarmDescription => 'App alarm';

  @override
  String get appearance => 'Appearance';

  @override
  String get font => 'Font';

  @override
  String get backgroundColor => 'Background color';

  @override
  String get textColor => 'Text color';

  @override
  String get selectColor => 'Select color';

  @override
  String get language => 'Language';

  @override
  String get timeFormatSetting => 'Time format';

  @override
  String get format12h => '12-hour format';

  @override
  String get format24h => '24-hour format';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get wakeUpRecorded => 'Wake up time recorded!';

  @override
  String get alarmTitle => 'ALARM';

  @override
  String get timeToWakeUp => 'Time to wake up!';

  @override
  String setFor(Object time) {
    return 'Set for: $time';
  }

  @override
  String get stopAlarm => 'STOP ALARM';

  @override
  String get snooze5min => 'Snooze for 5 minutes';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get selectFont => 'Select font';

  @override
  String get selectBackgroundColor => 'Select background color';

  @override
  String get selectTextColor => 'Select text color';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'English';
}
