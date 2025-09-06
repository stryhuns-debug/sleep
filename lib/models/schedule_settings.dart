class ScheduleSettings {
  final int targetWakeUpHour;
  final int targetWakeUpMinute;
  final int targetSleepHour;
  final int targetSleepMinute;
  final int notificationMinutesBefore;
  final bool notificationsEnabled;
  final bool alarmEnabled;
  final String fontFamily;
  final Color backgroundColor;
  final Color textColor;
  final String language;
  final bool use24HourFormat;

  ScheduleSettings({
    required this.targetWakeUpHour,
    required this.targetWakeUpMinute,
    required this.targetSleepHour,
    required this.targetSleepMinute,
    required this.notificationMinutesBefore,
    required this.notificationsEnabled,
    required this.alarmEnabled,
    required this.fontFamily,
    required this.backgroundColor,
    required this.textColor,
    required this.language,
    required this.use24HourFormat,
  });

  factory ScheduleSettings.defaultSettings() {
    return ScheduleSettings(
      targetWakeUpHour: 8,
      targetWakeUpMinute: 0,
      targetSleepHour: 0,
      targetSleepMinute: 0,
      notificationMinutesBefore: 15,
      notificationsEnabled: true,
      alarmEnabled: true,
      fontFamily: 'Roboto',
      backgroundColor: const Color(0xFFF5F5F5),
      textColor: const Color(0xFF333333),
      language: 'ru',
      use24HourFormat: true,
    );
  }

  ScheduleSettings copyWith({
    int? targetWakeUpHour,
    int? targetWakeUpMinute,
    int? targetSleepHour,
    int? targetSleepMinute,
    int? notificationMinutesBefore,
    bool? notificationsEnabled,
    bool? alarmEnabled,
    String? fontFamily,
    Color? backgroundColor,
    Color? textColor,
    String? language,
    bool? use24HourFormat,
  }) {
    return ScheduleSettings(
      targetWakeUpHour: targetWakeUpHour ?? this.targetWakeUpHour,
      targetWakeUpMinute: targetWakeUpMinute ?? this.targetWakeUpMinute,
      targetSleepHour: targetSleepHour ?? this.targetSleepHour,
      targetSleepMinute: targetSleepMinute ?? this.targetSleepMinute,
      notificationMinutesBefore: notificationMinutesBefore ?? this.notificationMinutesBefore,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      alarmEnabled: alarmEnabled ?? this.alarmEnabled,
      fontFamily: fontFamily ?? this.fontFamily,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      language: language ?? this.language,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetWakeUpHour': targetWakeUpHour,
      'targetWakeUpMinute': targetWakeUpMinute,
      'targetSleepHour': targetSleepHour,
      'targetSleepMinute': targetSleepMinute,
      'notificationMinutesBefore': notificationMinutesBefore,
      'notificationsEnabled': notificationsEnabled,
      'alarmEnabled': alarmEnabled,
      'fontFamily': fontFamily,
      'backgroundColor': backgroundColor.value,
      'textColor': textColor.value,
      'language': language,
      'use24HourFormat': use24HourFormat,
    };
  }

  factory ScheduleSettings.fromJson(Map<String, dynamic> json) {
    return ScheduleSettings(
      targetWakeUpHour: json['targetWakeUpHour'] ?? 8,
      targetWakeUpMinute: json['targetWakeUpMinute'] ?? 0,
      targetSleepHour: json['targetSleepHour'] ?? 0,
      targetSleepMinute: json['targetSleepMinute'] ?? 0,
      notificationMinutesBefore: json['notificationMinutesBefore'] ?? 15,
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      alarmEnabled: json['alarmEnabled'] ?? true,
      fontFamily: json['fontFamily'] ?? 'Roboto',
      backgroundColor: Color(json['backgroundColor'] ?? 0xFFF5F5F5),
      textColor: Color(json['textColor'] ?? 0xFF333333),
      language: json['language'] ?? 'ru',
      use24HourFormat: json['use24HourFormat'] ?? true,
    );
  }
}
