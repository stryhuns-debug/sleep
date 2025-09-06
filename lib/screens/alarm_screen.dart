import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/alarm_service.dart';
import '../services/localization_service.dart';
import '../l10n/app_localizations.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    _checkAlarmStatus();
  }

  void _checkAlarmStatus() {
    setState(() {});
  }

  Future<void> _stopAlarm() async {
    await AlarmService.stopAlarm();
    _checkAlarmStatus();
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAlarmActive = AlarmService.isAlarmActive;
    final alarmTime = AlarmService.alarmTime;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Alarm icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Alarm text
              Text(
                l10n.alarmTitle,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                l10n.timeToWakeUp,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red.shade600,
                ),
              ),
              
              if (alarmTime != null) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.setFor.replaceAll('{time}', LocalizationService.formatTime(alarmTime)),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red.shade500,
                  ),
                ),
              ],
              
              const SizedBox(height: 48),
              
              // Stop alarm button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _stopAlarm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    l10n.stopAlarm,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Snooze button (optional)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    // Snooze for 5 minutes
                    HapticFeedback.lightImpact();
                    // You can implement snooze functionality here
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                    side: BorderSide(color: Colors.red.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    l10n.snooze5min,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
