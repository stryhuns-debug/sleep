import 'package:flutter/material.dart';

enum ScheduleItemType {
  wakeUp,
  morningWater,
  breakfast,
  exercise,
  dinner,
  eveningWater,
  sleep,
}

class ScheduleItem {
  final ScheduleItemType type;
  final String title;
  final String description;
  final DateTime scheduledTime;
  final int minutesUntil;

  ScheduleItem({
    required this.type,
    required this.title,
    required this.description,
    required this.scheduledTime,
    required this.minutesUntil,
  });

  IconData get icon {
    switch (type) {
      case ScheduleItemType.wakeUp:
        return Icons.wb_sunny;
      case ScheduleItemType.morningWater:
        return Icons.local_drink;
      case ScheduleItemType.breakfast:
        return Icons.restaurant;
      case ScheduleItemType.exercise:
        return Icons.fitness_center;
      case ScheduleItemType.dinner:
        return Icons.dinner_dining;
      case ScheduleItemType.eveningWater:
        return Icons.local_drink;
      case ScheduleItemType.sleep:
        return Icons.bedtime;
    }
  }

  Color get color {
    switch (type) {
      case ScheduleItemType.wakeUp:
        return Colors.orange;
      case ScheduleItemType.morningWater:
        return Colors.blue;
      case ScheduleItemType.breakfast:
        return Colors.green;
      case ScheduleItemType.exercise:
        return Colors.red;
      case ScheduleItemType.dinner:
        return Colors.purple;
      case ScheduleItemType.eveningWater:
        return Colors.blue;
      case ScheduleItemType.sleep:
        return Colors.indigo;
    }
  }
}
