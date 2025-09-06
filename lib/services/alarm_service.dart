import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/notification_service.dart';

class AlarmService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isAlarmActive = false;
  static DateTime? _alarmTime;

  static Future<void> initialize() async {
    // Initialize audio player
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  static Future<void> setAlarm(DateTime alarmTime) async {
    _alarmTime = alarmTime;
    
    // Schedule notification for alarm
    await NotificationService.scheduleNotification(
      id: 999, // Special ID for alarm
      title: 'Будильник',
      body: 'Время просыпаться!',
      scheduledDate: alarmTime,
    );
  }

  static Future<void> startAlarm() async {
    if (_isAlarmActive) return;

    _isAlarmActive = true;
    
    try {
      // Play alarm sound (you can replace with your own sound file)
      await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
      
      // Vibrate device
      await HapticFeedback.heavyImpact();
      
      // Show immediate notification
      await NotificationService.showImmediateNotification(
        title: 'Будильник',
        body: 'Время просыпаться!',
      );
    } catch (e) {
      debugPrint('Error playing alarm: $e');
      // Fallback: just vibrate
      await HapticFeedback.heavyImpact();
    }
  }

  static Future<void> stopAlarm() async {
    if (!_isAlarmActive) return;

    _isAlarmActive = false;
    
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping alarm: $e');
    }
  }

  static bool get isAlarmActive => _isAlarmActive;
  
  static DateTime? get alarmTime => _alarmTime;

  static Future<void> cancelAlarm() async {
    await NotificationService.cancelNotification(999);
    _alarmTime = null;
  }

  static Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
