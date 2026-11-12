
import 'package:flutter/material.dart';

void main() {
  runApp(const LockzoApp());
}

const navy = Color(0xFF07152B);
const panel = Color(0xFF10233F);
const gold = Color(0xFFD4AF37);

class LockzoApp extends StatelessWidget {
  const LockzoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOCKZO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const LockzoHome(),
    );
  }
}

class LockzoHome extends StatefulWidget {
  const LockzoHome({super.key});

  @override
  State<LockzoHome> createState() => _LockzoHomeState();
}

class _LockzoHomeState extends State<LockzoHome> {
  int page = 0;
  bool voiceLock = false;
  bool pinLock = true;
  bool fingerprint = false;

  final Map<String, bool> apps = {
    'WhatsApp': false,
    'Instagram': false,
    'Facebook': false,
    'Gallery': false,
    'YouTube': false,
    'Chrome': false,
  };

  @override
  Widget build(BuildContext context) {
    final screens = [
      homePage(),
      securityPage(),
      appLockPage(),
      settingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        title: const Text(
          'LOCKZO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showMessage('Notifications coming soon'),
            icon: const Icon(Icons.notifications_none, color: gold),
          ),
        ],
      ),
      body: SafeArea(child: screens[page]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        selectedIndex: page,
        indicatorColor: gold.withValues(alpha: 0.2),
        onDestinationSelected: (index) {
          setState(() => page = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            label: 'Security',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps),
            label: 'App Lock',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget homePage() {
    final count = apps.values.where((v) => v).length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF183858), Color(0xFF0B1B32)],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gold.withValues(alpha: 0.5)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_moon_outlined, color: gold, size: 48),
              SizedBox(height: 16),
              Text(
                'Your Privacy. Your Control.',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Voice Lock & Security System',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'SECURITY OVERVIEW',
          style: TextStyle(color: gold, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: statCard(
                'PIN Lock',
                pinLock ? 'Enabled' : 'Off',
                Icons.password,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: statCard(
                'Voice Lock',
                voiceLock ? 'Enabled' : 'Off',
                Icons.graphic_eq,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        statCard('Apps selected', '$count apps', Icons.lock_outline),
        const SizedBox(height: 20),
        actionTile(
          Icons.shield_outlined,
          'Security Settings',
          'Manage protection methods',
          () => setState(() => page = 1),
        ),
        actionTile(
          Icons.apps,
          'App Lock',
          'Choose apps for your lock list',
          () => setState(() => page = 2),
        ),
      ],
    );
  }

  Widget securityPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Security Center',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Manage your security methods.',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),
        switchTile(
          Icons.graphic_eq,
          'Voice Lock',
          'Voice phrase setup is not active yet.',
          voiceLock,
          (v) => setState(() => voiceLock = v),
        ),
        switchTile(
          Icons.password,
          'PIN Lock',
          'PIN protection setup is not active yet.',
          pinLock,
          (v) => setState(() => pinLock = v),
        ),
        switchTile(
          Icons.fingerprint,
          'Fingerprint',
          'Biometric setup is not active yet.',
          fingerprint,
          (v) => setState(() => fingerprint = v),
        ),
        notice(
          'These controls are currently demo switches. They do not yet secure your device.',
        ),
      ],
    );
  }

  Widget appLockPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'App Lock',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        notice(
          'Demo only: selecting an app does not currently block access to it.',
        ),
        const SizedBox(height: 12),
        ...apps.keys.map((name) {
          return Card(
            color: panel,
            child: SwitchListTile(
              secondary: const Icon(Icons.lock_outline, color: gold),
              title: Text(name),
              subtitle: Text(apps[name]! ? 'Selected' : 'Not selected'),
              value: apps[name]!,
              activeColor: gold,
              onChanged: (value) {
                setState(() => apps[name] = value);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget settingsPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        actionTile(
          Icons.notifications_outlined,
          'Notifications',
          'Notification preferences',
          () => showMessage('Coming soon'),
        ),
        actionTile(
          Icons.privacy_tip_outlined,
          'Privacy',
          'Privacy information',
          () => showMessage('Privacy details coming soon'),
        ),
        actionTile(
          Icons.help_outline,
          'Help & Support',
          'Get help using LOCKZO',
          () => showMessage('Help centre coming soon'),
        ),
        actionTile(
          Icons.info_outline,
          'About LOCKZO',
          'Version 1.0.0',
          () => showMessage('LOCKZO - Voice Lock & Security System'),
        ),
      ],
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: gold, size: 28),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget actionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      color: panel,
      child: ListTile(
        leading: Icon(icon, color: gold),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget switchTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Card(
      color: panel,
      child: SwitchListTile(
        secondary: Icon(icon, color: gold),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        activeColor: gold,
        onChanged: onChanged,
      ),
    );
  }

  Widget notice(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: gold),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
