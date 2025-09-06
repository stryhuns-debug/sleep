import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/schedule_service.dart';
import '../services/notification_service.dart';
import '../services/localization_service.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _refreshSchedule();
  }

  void _refreshSchedule() {
    setState(() {});
  }

  Future<void> _onWakeUpPressed() async {
    await ScheduleService.recordWakeUp();
    
    // Show confirmation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.wakeUpRecorded ?? 'Wake up time recorded!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    
    _refreshSchedule();
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
        title: Text(l10n.appTitle),
        backgroundColor: settings.backgroundColor,
        foregroundColor: settings.textColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wake up button
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      size: 64,
                      color: hasWokenUp ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      hasWokenUp ? l10n.alreadyWokeUp : l10n.wakeUpTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: settings.textColor,
                        fontFamily: settings.fontFamily,
                      ),
                    ),
                    if (hasWokenUp) ...[
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.wakeUpTime.replaceAll('{time}', LocalizationService.formatTime(DateTime.now(), use24Hour: settings.use24HourFormat))}',
                        style: TextStyle(
                          fontSize: 16,
                          color: settings.textColor.withOpacity(0.7),
                          fontFamily: settings.fontFamily,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    if (!hasWokenUp)
                      ElevatedButton(
                        onPressed: _onWakeUpPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          l10n.recordWakeUp,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Today's schedule preview
            if (hasWokenUp) ...[
              Text(
                l10n.todaysSchedule,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: settings.textColor,
                  fontFamily: settings.fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    final item = schedule[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item.color.withOpacity(0.2),
                          child: Icon(
                            item.icon,
                            color: item.color,
                          ),
                        ),
                        title: Text(
                          LocalizationService.getScheduleItemTitle(item.type, settings.language),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: settings.textColor,
                            fontFamily: settings.fontFamily,
                          ),
                        ),
                        subtitle: Text(
                          '${LocalizationService.formatTime(item.scheduledTime, use24Hour: settings.use24HourFormat)} • ${LocalizationService.getTimeUntilText(item.minutesUntil, settings.language)}',
                          style: TextStyle(
                            color: settings.textColor.withOpacity(0.7),
                            fontFamily: settings.fontFamily,
                          ),
                        ),
                        trailing: item.minutesUntil <= 0
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              // Instructions for first use
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.welcome,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: settings.textColor,
                          fontFamily: settings.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.welcomeMessage,
                        style: TextStyle(
                          fontSize: 16,
                          color: settings.textColor,
                          fontFamily: settings.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.defaultGoal,
                        style: TextStyle(
                          fontSize: 14,
                          color: settings.textColor.withOpacity(0.7),
                          fontFamily: settings.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
