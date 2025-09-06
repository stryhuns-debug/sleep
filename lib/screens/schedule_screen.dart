import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/schedule_service.dart';
import '../services/localization_service.dart';
import '../models/schedule_item.dart';
import '../l10n/app_localizations.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    _refreshSchedule();
  }

  void _refreshSchedule() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final settings = ScheduleService.getSettings();
    final schedule = ScheduleService.getTodaySchedule();
    final hasWokenUp = ScheduleService.hasWokenUpToday();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: settings.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.scheduleTitle),
        backgroundColor: settings.backgroundColor,
        foregroundColor: settings.textColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshSchedule,
          ),
        ],
      ),
      body: hasWokenUp
          ? _buildScheduleList(schedule, settings)
          : _buildNoScheduleMessage(settings),
    );
  }

  Widget _buildScheduleList(List<ScheduleItem> schedule, settings) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final item = schedule[index];
        final isCompleted = item.minutesUntil <= 0;
        final isUpcoming = item.minutesUntil > 0 && item.minutesUntil <= 60;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: isUpcoming ? 6 : 2,
          color: isUpcoming 
              ? item.color.withOpacity(0.1)
              : isCompleted 
                  ? Colors.green.withOpacity(0.1)
                  : null,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: isCompleted 
                  ? Colors.green.withOpacity(0.2)
                  : item.color.withOpacity(0.2),
              child: Icon(
                item.icon,
                color: isCompleted ? Colors.green : item.color,
                size: 28,
              ),
            ),
            title: Text(
              LocalizationService.getScheduleItemTitle(item.type, settings.language),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: settings.textColor,
                fontFamily: settings.fontFamily,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  LocalizationService.getScheduleItemDescription(item.type, settings.language),
                  style: TextStyle(
                    fontSize: 14,
                    color: settings.textColor.withOpacity(0.7),
                    fontFamily: settings.fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: settings.textColor.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      LocalizationService.formatTime(item.scheduledTime, use24Hour: settings.use24HourFormat),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: settings.textColor,
                        fontFamily: settings.fontFamily,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: settings.textColor.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      LocalizationService.getTimeUntilText(item.minutesUntil, settings.language),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCompleted 
                            ? Colors.green
                            : isUpcoming 
                                ? item.color
                                : settings.textColor,
                        fontFamily: settings.fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: isCompleted
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 32,
                  )
                : isUpcoming
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.soon,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: settings.fontFamily,
                          ),
                        ),
                      )
                    : null,
          ),
        );
      },
    );
  }

  Widget _buildNoScheduleMessage(settings) {
    final l10n = AppLocalizations.of(context)!;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 80,
              color: settings.textColor.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noSchedule,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: settings.textColor,
                fontFamily: settings.fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noScheduleMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: settings.textColor.withOpacity(0.7),
                fontFamily: settings.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeUntil(int minutes) {
    if (minutes <= 0) {
      return 'Прошло';
    } else if (minutes < 60) {
      return 'Через $minutes мин';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return 'Через $hours ч';
      } else {
        return 'Через $hours ч $remainingMinutes мин';
      }
    }
  }
}
