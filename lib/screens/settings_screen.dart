import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/schedule_service.dart';
import '../services/localization_service.dart';
import '../models/schedule_settings.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ScheduleSettings _settings;
  late TimeOfDay _targetWakeUp;
  late TimeOfDay _targetSleep;
  late int _notificationMinutes;
  late bool _notificationsEnabled;
  late bool _alarmEnabled;
  late String _selectedFont;
  late Color _selectedBackgroundColor;
  late Color _selectedTextColor;
  late String _selectedLanguage;
  late bool _use24HourFormat;

  final List<String> _availableFonts = [
    'Roboto',
    'Arial',
    'Times New Roman',
    'Courier New',
    'Georgia',
  ];

  final List<Color> _availableColors = [
    Colors.white,
    Colors.grey.shade100,
    Colors.grey.shade200,
    Colors.blue.shade50,
    Colors.green.shade50,
    Colors.orange.shade50,
    Colors.purple.shade50,
    Colors.red.shade50,
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    _settings = ScheduleService.getSettings();
    _targetWakeUp = TimeOfDay(
      hour: _settings.targetWakeUpHour,
      minute: _settings.targetWakeUpMinute,
    );
    _targetSleep = TimeOfDay(
      hour: _settings.targetSleepHour,
      minute: _settings.targetSleepMinute,
    );
    _notificationMinutes = _settings.notificationMinutesBefore;
    _notificationsEnabled = _settings.notificationsEnabled;
    _alarmEnabled = _settings.alarmEnabled;
    _selectedFont = _settings.fontFamily;
    _selectedBackgroundColor = _settings.backgroundColor;
    _selectedTextColor = _settings.textColor;
    _selectedLanguage = _settings.language;
    _use24HourFormat = _settings.use24HourFormat;
  }

  Future<void> _saveSettings() async {
    final newSettings = _settings.copyWith(
      targetWakeUpHour: _targetWakeUp.hour,
      targetWakeUpMinute: _targetWakeUp.minute,
      targetSleepHour: _targetSleep.hour,
      targetSleepMinute: _targetSleep.minute,
      notificationMinutesBefore: _notificationMinutes,
      notificationsEnabled: _notificationsEnabled,
      alarmEnabled: _alarmEnabled,
      fontFamily: _selectedFont,
      backgroundColor: _selectedBackgroundColor,
      textColor: _selectedTextColor,
      language: _selectedLanguage,
      use24HourFormat: _use24HourFormat,
    );

    await ScheduleService.updateSettings(newSettings);
    setState(() {
      _settings = newSettings;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.settingsSaved ?? 'Settings saved'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectWakeUpTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _targetWakeUp,
    );
    if (picked != null) {
      setState(() {
        _targetWakeUp = picked;
      });
      await _saveSettings();
    }
  }

  Future<void> _selectSleepTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _targetSleep,
    );
    if (picked != null) {
      setState(() {
        _targetSleep = picked;
      });
      await _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: _selectedBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: _selectedBackgroundColor,
        foregroundColor: _selectedTextColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Language and time format section
          _buildSectionCard(
            title: l10n.language,
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.language),
                subtitle: Text(LocalizationService.getLanguageName(_selectedLanguage)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showLanguagePicker(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(l10n.timeFormatSetting),
                subtitle: Text(_use24HourFormat ? l10n.format24h : l10n.format12h),
                trailing: Switch(
                  value: _use24HourFormat,
                  onChanged: (value) {
                    setState(() {
                      _use24HourFormat = value;
                    });
                    _saveSettings();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Target times section
          _buildSectionCard(
            title: l10n.targetTimes,
            children: [
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: Text(l10n.wakeUpTimeSetting),
                subtitle: Text(LocalizationService.formatTimeOfDay(_targetWakeUp, use24Hour: _use24HourFormat)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _selectWakeUpTime,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.bedtime),
                title: Text(l10n.sleepTimeSetting),
                subtitle: Text(LocalizationService.formatTimeOfDay(_targetSleep, use24Hour: _use24HourFormat)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _selectSleepTime,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notifications section
          _buildSectionCard(
            title: l10n.notifications,
            children: [
              SwitchListTile(
                title: Text(l10n.enableNotifications),
                subtitle: Text(l10n.notificationsDescription),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  _saveSettings();
                },
              ),
              if (_notificationsEnabled) ...[
                const Divider(),
                ListTile(
                  title: Text(l10n.notificationMinutes),
                  subtitle: Text('$_notificationMinutes ${l10n.notificationMinutes.toLowerCase()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _notificationMinutes > 5
                            ? () {
                                setState(() {
                                  _notificationMinutes -= 5;
                                });
                                _saveSettings();
                              }
                            : null,
                      ),
                      Text('$_notificationMinutes'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _notificationMinutes < 60
                            ? () {
                                setState(() {
                                  _notificationMinutes += 5;
                                });
                                _saveSettings();
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 16),

          // Alarm section
          _buildSectionCard(
            title: l10n.alarm,
            children: [
              SwitchListTile(
                title: Text(l10n.builtInAlarm),
                subtitle: Text(l10n.alarmDescription),
                value: _alarmEnabled,
                onChanged: (value) {
                  setState(() {
                    _alarmEnabled = value;
                  });
                  _saveSettings();
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Appearance section
          _buildSectionCard(
            title: l10n.appearance,
            children: [
              ListTile(
                title: Text(l10n.font),
                subtitle: Text(_selectedFont),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showFontPicker(),
              ),
              const Divider(),
              ListTile(
                title: Text(l10n.backgroundColor),
                subtitle: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _selectedBackgroundColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.selectColor),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showColorPicker(true),
              ),
              const Divider(),
              ListTile(
                title: Text(l10n.textColor),
                subtitle: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _selectedTextColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.selectColor),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showColorPicker(false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _selectedTextColor,
                fontFamily: _selectedFont,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return LocalizationService.formatTimeOfDay(time, use24Hour: _use24HourFormat);
  }

  void _showLanguagePicker() {
    final l10n = AppLocalizations.of(context)!;
    final languages = [
      {'code': 'ru', 'name': l10n.russian},
      {'code': 'en', 'name': l10n.english},
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectLanguage),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              return ListTile(
                title: Text(language['name']!),
                trailing: _selectedLanguage == language['code'] 
                    ? const Icon(Icons.check) 
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language['code']!;
                  });
                  _saveSettings();
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showFontPicker() {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectFont),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _availableFonts.length,
            itemBuilder: (context, index) {
              final font = _availableFonts[index];
              return ListTile(
                title: Text(
                  font,
                  style: TextStyle(
                    fontFamily: font,
                    fontWeight: _selectedFont == font ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: _selectedFont == font ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    _selectedFont = font;
                  });
                  _saveSettings();
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showColorPicker(bool isBackground) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isBackground ? l10n.selectBackgroundColor : l10n.selectTextColor),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _availableColors.length,
            itemBuilder: (context, index) {
              final color = _availableColors[index];
              final isSelected = isBackground 
                  ? _selectedBackgroundColor == color
                  : _selectedTextColor == color;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isBackground) {
                      _selectedBackgroundColor = color;
                    } else {
                      _selectedTextColor = color;
                    }
                  });
                  _saveSettings();
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
