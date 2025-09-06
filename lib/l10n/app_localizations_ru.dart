// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Исправитель режима сна';

  @override
  String get home => 'Главная';

  @override
  String get schedule => 'Расписание';

  @override
  String get settings => 'Настройки';

  @override
  String get wakeUpButton => 'Я ПРОСНУЛСЯ';

  @override
  String get wakeUpTitle => 'Я проснулся';

  @override
  String get wakeUpDescription => 'Время пробуждения';

  @override
  String get alreadyWokeUp => 'Вы уже проснулись сегодня!';

  @override
  String wakeUpTime(Object time) {
    return 'Время: $time';
  }

  @override
  String get recordWakeUp => 'ЗАПИСАТЬ ПРОБУЖДЕНИЕ';

  @override
  String get todaysSchedule => 'Расписание на сегодня:';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get welcomeMessage =>
      'Нажмите кнопку \"Я проснулся\" когда проснётесь, и приложение создаст для вас персональное расписание дня с постепенной корректировкой режима сна.';

  @override
  String get defaultGoal =>
      'Цель по умолчанию: вставать в 8:00, ложиться в 00:00';

  @override
  String get scheduleTitle => 'Расписание дня';

  @override
  String get noSchedule => 'Расписание не создано';

  @override
  String get noScheduleMessage =>
      'Нажмите \"Я проснулся\" на главном экране, чтобы создать персональное расписание дня.';

  @override
  String get wakeUp => 'Я проснулся';

  @override
  String get morningWater => 'Стакан воды';

  @override
  String get breakfast => 'Завтрак';

  @override
  String get exercise => 'Физическая активность';

  @override
  String get dinner => 'Ужин';

  @override
  String get eveningWater => 'Последний приём воды';

  @override
  String get sleep => 'Будильник на завтра';

  @override
  String get wakeUpDesc => 'Время пробуждения';

  @override
  String get morningWaterDesc => 'Утренний стакан воды';

  @override
  String get breakfastDesc => 'Время завтрака';

  @override
  String get exerciseDesc => 'Время для физкультуры';

  @override
  String get dinnerDesc => 'Время ужина';

  @override
  String get eveningWaterDesc => 'Вечерний стакан воды';

  @override
  String get sleepDesc => 'Время засыпания';

  @override
  String timeFormat(Object time, Object timeUntil) {
    return '$time • $timeUntil';
  }

  @override
  String get passed => 'Прошло';

  @override
  String inMinutes(Object minutes) {
    return 'Через $minutes мин';
  }

  @override
  String inHours(Object hours) {
    return 'Через $hours ч';
  }

  @override
  String inHoursMinutes(Object hours, Object minutes) {
    return 'Через $hours ч $minutes мин';
  }

  @override
  String get soon => 'СКОРО';

  @override
  String get targetTimes => 'Целевое время';

  @override
  String get wakeUpTimeSetting => 'Время пробуждения';

  @override
  String get sleepTimeSetting => 'Время засыпания';

  @override
  String get notifications => 'Уведомления';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get notificationsDescription => 'Напоминания о событиях дня';

  @override
  String get notificationMinutes => 'За сколько минут уведомлять';

  @override
  String get alarm => 'Будильник';

  @override
  String get builtInAlarm => 'Встроенный будильник';

  @override
  String get alarmDescription => 'Будильник в приложении';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get font => 'Шрифт';

  @override
  String get backgroundColor => 'Цвет фона';

  @override
  String get textColor => 'Цвет текста';

  @override
  String get selectColor => 'Выбрать цвет';

  @override
  String get language => 'Язык';

  @override
  String get timeFormatSetting => 'Формат времени';

  @override
  String get format12h => '12-часовой формат';

  @override
  String get format24h => '24-часовой формат';

  @override
  String get settingsSaved => 'Настройки сохранены';

  @override
  String get wakeUpRecorded => 'Время пробуждения записано!';

  @override
  String get alarmTitle => 'БУДИЛЬНИК';

  @override
  String get timeToWakeUp => 'Время просыпаться!';

  @override
  String setFor(Object time) {
    return 'Установлен на: $time';
  }

  @override
  String get stopAlarm => 'ОСТАНОВИТЬ БУДИЛЬНИК';

  @override
  String get snooze5min => 'Отложить на 5 минут';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get selectFont => 'Выберите шрифт';

  @override
  String get selectBackgroundColor => 'Выберите цвет фона';

  @override
  String get selectTextColor => 'Выберите цвет текста';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'English';
}
