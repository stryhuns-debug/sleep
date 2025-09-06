import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/alarm_screen.dart';
import 'services/notification_service.dart';
import 'services/schedule_service.dart';
import 'services/alarm_service.dart';
import 'services/localization_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service
  await NotificationService.initialize();
  
  // Initialize schedule service
  await ScheduleService.initialize();
  
  // Initialize alarm service
  await AlarmService.initialize();
  
  // Initialize localization service
  final settings = ScheduleService.getSettings();
  LocalizationService.initialize(settings);
  
  runApp(const SleepScheduleApp());
}

class SleepScheduleApp extends StatelessWidget {
  const SleepScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = ScheduleService.getSettings();
    final locale = Locale(settings.language);
    
    return MaterialApp(
      title: 'Sleep Schedule Fixer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkAlarmStatus();
  }

  void _checkAlarmStatus() {
    // Check if alarm is active and show alarm screen
    if (AlarmService.isAlarmActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AlarmScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)?.home ?? 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: AppLocalizations.of(context)?.schedule ?? 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)?.settings ?? 'Settings',
          ),
        ],
      ),
    );
  }
}
