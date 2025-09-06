import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/schedule_item.dart';
import '../models/schedule_settings.dart';
import 'notification_service.dart';
import 'alarm_service.dart';
import 'localization_service.dart';

class ScheduleService {
  static const String _lastWakeUpKey = 'last_wake_up';
  static const String _settingsKey = 'schedule_settings';
  
  static ScheduleSettings _settings = ScheduleSettings.defaultSettings();
  static DateTime? _lastWakeUp;
  static List<ScheduleItem> _todaySchedule = [];

  static Future<void> initialize() async {
    await _loadSettings();
    await _loadLastWakeUp();
    _generateTodaySchedule();
  }

  static Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString(_settingsKey);
    if (settingsJson != null) {
      _settings = ScheduleSettings.fromJson(json.decode(settingsJson));
    } else {
      // First time setup - detect system language
      final systemLanguage = LocalizationService.getDefaultLanguage();
      _settings = ScheduleSettings.defaultSettings().copyWith(
        language: systemLanguage,
      );
    }
  }

  static Future<void> _loadLastWakeUp() async {
    final prefs = await SharedPreferences.getInstance();
    final lastWakeUpMillis = prefs.getInt(_lastWakeUpKey);
    if (lastWakeUpMillis != null) {
      _lastWakeUp = DateTime.fromMillisecondsSinceEpoch(lastWakeUpMillis);
    }
  }

  static Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, json.encode(_settings.toJson()));
  }

  static Future<void> _saveLastWakeUp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastWakeUpKey, _lastWakeUp!.millisecondsSinceEpoch);
  }

  static void _generateTodaySchedule() {
    if (_lastWakeUp == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Calculate target wake up time for today
    final targetWakeUp = DateTime(
      today.year, 
      today.month, 
      today.day, 
      _settings.targetWakeUpHour, 
      _settings.targetWakeUpMinute
    );
    
    // Calculate actual wake up time (with 15-minute adjustments)
    final actualWakeUp = _calculateAdjustedWakeUpTime(_lastWakeUp!, targetWakeUp);
    
    // Generate schedule items
    _todaySchedule = [
      ScheduleItem(
        type: ScheduleItemType.wakeUp,
        title: 'Я проснулся',
        description: 'Время пробуждения',
        scheduledTime: actualWakeUp,
        minutesUntil: _calculateMinutesUntil(actualWakeUp),
      ),
      ScheduleItem(
        type: ScheduleItemType.morningWater,
        title: 'Стакан воды',
        description: 'Утренний стакан воды',
        scheduledTime: actualWakeUp.add(const Duration(minutes: 5)),
        minutesUntil: _calculateMinutesUntil(actualWakeUp.add(const Duration(minutes: 5))),
      ),
      ScheduleItem(
        type: ScheduleItemType.breakfast,
        title: 'Завтрак',
        description: 'Время завтрака',
        scheduledTime: actualWakeUp.add(const Duration(hours: 1)),
        minutesUntil: _calculateMinutesUntil(actualWakeUp.add(const Duration(hours: 1))),
      ),
      ScheduleItem(
        type: ScheduleItemType.exercise,
        title: 'Физическая активность',
        description: 'Время для физкультуры',
        scheduledTime: actualWakeUp.add(const Duration(hours: 2)),
        minutesUntil: _calculateMinutesUntil(actualWakeUp.add(const Duration(hours: 2))),
      ),
      ScheduleItem(
        type: ScheduleItemType.dinner,
        title: 'Ужин',
        description: 'Время ужина',
        scheduledTime: _calculateDinnerTime(actualWakeUp),
        minutesUntil: _calculateMinutesUntil(_calculateDinnerTime(actualWakeUp)),
      ),
      ScheduleItem(
        type: ScheduleItemType.eveningWater,
        title: 'Последний приём воды',
        description: 'Вечерний стакан воды',
        scheduledTime: _calculateEveningWaterTime(actualWakeUp),
        minutesUntil: _calculateMinutesUntil(_calculateEveningWaterTime(actualWakeUp)),
      ),
      ScheduleItem(
        type: ScheduleItemType.sleep,
        title: 'Будильник на завтра',
        description: 'Время засыпания',
        scheduledTime: _calculateSleepTime(actualWakeUp),
        minutesUntil: _calculateMinutesUntil(_calculateSleepTime(actualWakeUp)),
      ),
    ];

    // Schedule notifications
    _scheduleNotifications();
    
    // Schedule alarm if enabled
    _scheduleAlarm();
  }

  static DateTime _calculateAdjustedWakeUpTime(DateTime lastWakeUp, DateTime targetWakeUp) {
    final lastWakeUpTime = TimeOfDay.fromDateTime(lastWakeUp);
    final targetWakeUpTime = TimeOfDay.fromDateTime(targetWakeUp);
    
    final lastMinutes = lastWakeUpTime.hour * 60 + lastWakeUpTime.minute;
    final targetMinutes = targetWakeUpTime.hour * 60 + targetWakeUpTime.minute;
    
    int difference = targetMinutes - lastMinutes;
    
    // Round to nearest 15 minutes
    difference = ((difference / 15).round()) * 15;
    
    // Limit adjustment to 15 minutes per day
    if (difference > 15) difference = 15;
    if (difference < -15) difference = -15;
    
    final adjustedMinutes = lastMinutes + difference;
    final adjustedHour = (adjustedMinutes / 60).floor() % 24;
    final adjustedMinute = adjustedMinutes % 60;
    
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      adjustedHour,
      adjustedMinute,
    );
  }

  static DateTime _calculateDinnerTime(DateTime wakeUp) {
    final sleepTime = _calculateSleepTime(wakeUp);
    return sleepTime.subtract(const Duration(hours: 3));
  }

  static DateTime _calculateEveningWaterTime(DateTime wakeUp) {
    final sleepTime = _calculateSleepTime(wakeUp);
    return sleepTime.subtract(const Duration(hours: 2));
  }

  static DateTime _calculateSleepTime(DateTime wakeUp) {
    final targetSleep = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _settings.targetSleepHour,
      _settings.targetSleepMinute,
    );
    
    // If target sleep time is before wake up time, it's next day
    if (targetSleep.isBefore(wakeUp)) {
      return targetSleep.add(const Duration(days: 1));
    }
    
    return targetSleep;
  }

  static int _calculateMinutesUntil(DateTime scheduledTime) {
    final now = DateTime.now();
    final difference = scheduledTime.difference(now);
    return difference.inMinutes;
  }

  static void _scheduleNotifications() {
    if (!_settings.notificationsEnabled) return;

    for (final item in _todaySchedule) {
      if (item.minutesUntil > 0) {
        final notificationTime = item.scheduledTime.subtract(
          Duration(minutes: _settings.notificationMinutesBefore),
        );
        
        if (notificationTime.isAfter(DateTime.now())) {
          NotificationService.scheduleNotification(
            id: item.type.index,
            title: 'Напоминание: ${item.title}',
            body: 'Через ${_settings.notificationMinutesBefore} минут',
            scheduledDate: notificationTime,
          );
        }
      }
    }
  }

  static void _scheduleAlarm() {
    if (!_settings.alarmEnabled) return;

    // Find the wake up time for tomorrow
    final wakeUpItem = _todaySchedule.firstWhere(
      (item) => item.type == ScheduleItemType.wakeUp,
    );
    
    // Set alarm for tomorrow's wake up time
    final tomorrowWakeUp = wakeUpItem.scheduledTime.add(const Duration(days: 1));
    AlarmService.setAlarm(tomorrowWakeUp);
  }

  // Public methods
  static List<ScheduleItem> getTodaySchedule() => _todaySchedule;

  static Future<void> recordWakeUp() async {
    _lastWakeUp = DateTime.now();
    await _saveLastWakeUp();
    _generateTodaySchedule();
  }

  static ScheduleSettings getSettings() => _settings;

  static Future<void> updateSettings(ScheduleSettings newSettings) async {
    _settings = newSettings;
    await _saveSettings();
    _generateTodaySchedule();
  }

  static bool hasWokenUpToday() {
    if (_lastWakeUp == null) return false;
    final today = DateTime.now();
    final lastWakeUpDay = DateTime(_lastWakeUp!.year, _lastWakeUp!.month, _lastWakeUp!.day);
    final todayDay = DateTime(today.year, today.month, today.day);
    return lastWakeUpDay.isAtSameMomentAs(todayDay);
  }
}
