import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/schedule_settings.dart';
import '../models/schedule_item.dart';

class LocalizationService {
  static Locale _currentLocale = const Locale('ru', '');
  static ScheduleSettings? _settings;

  static void initialize(ScheduleSettings settings) {
    _settings = settings;
    _currentLocale = Locale(settings.language);
  }

  static Locale get currentLocale => _currentLocale;

  static void setLocale(Locale locale) {
    _currentLocale = locale;
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return 'Русский';
    }
  }

  static String formatTime(DateTime time, {bool? use24Hour}) {
    final use24 = use24Hour ?? _settings?.use24HourFormat ?? true;
    
    if (use24) {
      return DateFormat('HH:mm').format(time);
    } else {
      return DateFormat('h:mm a').format(time);
    }
  }

  static String formatTimeOfDay(TimeOfDay time, {bool? use24Hour}) {
    final use24 = use24Hour ?? _settings?.use24HourFormat ?? true;
    
    if (use24) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  static String getTimeUntilText(int minutes, String languageCode) {
    if (minutes <= 0) {
      return languageCode == 'en' ? 'Passed' : 'Прошло';
    } else if (minutes < 60) {
      return languageCode == 'en' 
          ? 'In $minutes min' 
          : 'Через $minutes мин';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return languageCode == 'en' 
            ? 'In $hours h' 
            : 'Через $hours ч';
      } else {
        return languageCode == 'en' 
            ? 'In $hours h $remainingMinutes min' 
            : 'Через $hours ч $remainingMinutes мин';
      }
    }
  }

  static String getScheduleItemTitle(ScheduleItemType type, String languageCode) {
    switch (type) {
      case ScheduleItemType.wakeUp:
        return languageCode == 'en' ? 'I woke up' : 'Я проснулся';
      case ScheduleItemType.morningWater:
        return languageCode == 'en' ? 'Glass of water' : 'Стакан воды';
      case ScheduleItemType.breakfast:
        return languageCode == 'en' ? 'Breakfast' : 'Завтрак';
      case ScheduleItemType.exercise:
        return languageCode == 'en' ? 'Physical activity' : 'Физическая активность';
      case ScheduleItemType.dinner:
        return languageCode == 'en' ? 'Dinner' : 'Ужин';
      case ScheduleItemType.eveningWater:
        return languageCode == 'en' ? 'Last water intake' : 'Последний приём воды';
      case ScheduleItemType.sleep:
        return languageCode == 'en' ? 'Alarm for tomorrow' : 'Будильник на завтра';
    }
  }

  static String getScheduleItemDescription(ScheduleItemType type, String languageCode) {
    switch (type) {
      case ScheduleItemType.wakeUp:
        return languageCode == 'en' ? 'Wake up time' : 'Время пробуждения';
      case ScheduleItemType.morningWater:
        return languageCode == 'en' ? 'Morning glass of water' : 'Утренний стакан воды';
      case ScheduleItemType.breakfast:
        return languageCode == 'en' ? 'Breakfast time' : 'Время завтрака';
      case ScheduleItemType.exercise:
        return languageCode == 'en' ? 'Time for exercise' : 'Время для физкультуры';
      case ScheduleItemType.dinner:
        return languageCode == 'en' ? 'Dinner time' : 'Время ужина';
      case ScheduleItemType.eveningWater:
        return languageCode == 'en' ? 'Evening glass of water' : 'Вечерний стакан воды';
      case ScheduleItemType.sleep:
        return languageCode == 'en' ? 'Sleep time' : 'Время засыпания';
    }
  }

  static String getSystemLanguage() {
    final systemLocale = PlatformDispatcher.instance.locale;
    return systemLocale.languageCode;
  }

  static String getDefaultLanguage() {
    final systemLang = getSystemLanguage();
    return (systemLang == 'ru' || systemLang == 'en') ? systemLang : 'ru';
  }
}

