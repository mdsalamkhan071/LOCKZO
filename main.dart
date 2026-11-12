import 'package:flutter/material.dart';

void main() {
  runApp(const LockzoApp());
}

const navy = Color(0xFF071326);
const panel = Color(0xFF10213B);
const gold = Color(0xFFFFC94A);
const muted = Color(0xFF9EADC3);

class LockzoApp extends StatelessWidget {
  const LockzoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOCKZO',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
          primary: gold,
          surface: panel,
        ),
        fontFamily: 'Roboto',
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
  int _index = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    SecurityPage(),
    AppLockPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0B1A30),
        indicatorColor: gold.withOpacity(.18),
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shield_outlined), selectedIcon: Icon(Icons.shield), label: 'Security'),
          NavigationDestination(icon: Icon(Icons.apps_outlined), selectedIcon: Icon(Icons.apps), label: 'App Lock'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const PageHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Row(
        children: [
          Container(
            height: 42, width: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(colors: [Color(0xFFFFE28A), gold, Color(0xFFB87512)]),
            ),
            child: const Icon(Icons.shield_rounded, color: navy, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
              if (subtitle != null) Text(subtitle!, style: const TextStyle(color: muted, fontSize: 12)),
            ]),
          ),
          const Icon(Icons.notifications_none_rounded, color: muted),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageHeader(title: 'LOCKZO', subtitle: 'VOICE LOCK & SECURITY SYSTEM'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF18365B), Color(0xFF0B172A), Color(0xFF101D32)],
              ),
              border: Border.all(color: gold.withOpacity(.45)),
              boxShadow: [BoxShadow(color: gold.withOpacity(.08), blurRadius: 24, spreadRadius: 1)],
            ),
            child: Column(children: [
              Container(
                height: 104, width: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: gold, width: 2),
                  color: navy,
                ),
                child: const Icon(Icons.mic_rounded, color: gold, size: 52),
              ),
              const SizedBox(height: 14),
              const Text('Your Security, Your Voice', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Manage your app protection in one place.', textAlign: TextAlign.center,
                  style: TextStyle(color: muted)),
              const SizedBox(height: 18),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.verified_user, color: gold, size: 17),
                SizedBox(width: 7),
                Text('Security tools ready to configure', style: TextStyle(color: gold, fontSize: 12)),
              ]),
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text('SECURITY TOOLS', style: TextStyle(color: muted, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.18,
            children: const [
              ToolTile(icon: Icons.mic_rounded, title: 'Voice Lock', detail: 'Voice phrase setup'),
              ToolTile(icon: Icons.dialpad_rounded, title: 'PIN Lock', detail: 'Backup PIN'),
              ToolTile(icon: Icons.gesture_rounded, title: 'Pattern Lock', detail: 'Draw a pattern'),
              ToolTile(icon: Icons.apps_rounded, title: 'App Lock', detail: 'Protect selected apps'),
              ToolTile(icon: Icons.palette_outlined, title: 'Themes', detail: 'Personalize your look'),
              ToolTile(icon: Icons.wallpaper_outlined, title: 'Wallpapers', detail: 'Choose a background'),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text('IMPORTANT', style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'This starter app is a UI prototype. Real app-lock protection needs Android permissions and native integration. Voice matching should not be treated as secure biometric authentication.',
            style: TextStyle(color: muted, height: 1.45, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class ToolTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  const ToolTile({super.key, required this.icon, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.white.withOpacity(.07)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: gold, size: 29),
        const Spacer(),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 4),
        Text(detail, style: const TextStyle(color: muted, fontSize: 11)),
      ]),
    );
  }
}

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const PageHeader(title: 'Security', subtitle: 'Choose your protection method'),
      const SecurityOption(icon: Icons.mic_rounded, title: 'Voice phrase', description: 'Set up a phrase as a convenience feature.'),
      const SecurityOption(icon: Icons.pin_rounded, title: 'Backup PIN', description: 'Use a PIN as a fallback method.'),
      const SecurityOption(icon: Icons.gesture_rounded, title: 'Pattern lock', description: 'Configure a pattern for the app interface.'),
      const SecurityOption(icon: Icons.lock_reset_rounded, title: 'Recovery options', description: 'Review recovery and reset choices.'),
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text('For real device security, keep Android screen lock enabled. A recorded voice phrase can be copied or replayed and is not equivalent to fingerprint or face authentication.',
          style: TextStyle(color: muted, height: 1.5, fontSize: 12)),
      ),
    ]);
  }
}

class SecurityOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const SecurityOption({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Icon(icon, color: gold, size: 28),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(color: muted, fontSize: 12)),
        ])),
        const Icon(Icons.chevron_right, color: muted),
      ]),
    );
  }
}

class AppLockPage extends StatefulWidget {
  const AppLockPage({super.key});

  @override
  State<AppLockPage> createState() => _AppLockPageState();
}

class _AppLockPageState extends State<AppLockPage> {
  final Map<String, bool> _protected = {
    'WhatsApp': true,
    'Instagram': true,
    'Facebook': false,
    'Gallery': true,
    'YouTube': false,
    'Chrome': false,
    'Settings': false,
  };

  final Map<String, IconData> _icons = {
    'WhatsApp': Icons.chat_rounded,
    'Instagram': Icons.camera_alt_rounded,
    'Facebook': Icons.facebook_rounded,
    'Gallery': Icons.photo_library_rounded,
    'YouTube': Icons.play_circle_fill_rounded,
    'Chrome': Icons.public_rounded,
    'Settings': Icons.settings_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const PageHeader(title: 'App Lock', subtitle: 'Select apps to protect'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search apps',
            prefixIcon: const Icon(Icons.search, color: muted),
            filled: true, fillColor: panel,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
        child: Text('YOUR APPS', style: TextStyle(color: muted, letterSpacing: 1.3, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      ..._protected.keys.map((name) => Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 9),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          CircleAvatar(backgroundColor: gold.withOpacity(.14), child: Icon(_icons[name], color: gold)),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600))),
          Switch(
            value: _protected[name]!,
            activeColor: gold,
            onChanged: (value) => setState(() => _protected[name] = value),
          ),
        ]),
      )),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Text('Demo list only: this screen does not yet block access to other installed apps.',
          style: TextStyle(color: muted, fontSize: 12)),
      ),
    ]);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool intruderAlert = false;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const PageHeader(title: 'Settings', subtitle: 'Personalize LOCKZO'),
      SwitchListTile(
        value: notifications,
        activeColor: gold,
        onChanged: (v) => setState(() => notifications = v),
        title: const Text('Security notifications'),
        subtitle: const Text('Show reminders and app alerts', style: TextStyle(color: muted, fontSize: 12)),
      ),
      SwitchListTile(
        value: intruderAlert,
        activeColor: gold,
        onChanged: (v) => setState(() => intruderAlert = v),
        title: const Text('Intruder alert (coming soon)'),
        subtitle: const Text('Requires camera permission and clear consent', style: TextStyle(color: muted, fontSize: 12)),
      ),
      const Divider(color: Colors.white12, height: 30),
      const ListTile(leading: Icon(Icons.info_outline, color: gold), title: Text('About LOCKZO'), subtitle: Text('Voice Lock & Security System')),
      const ListTile(leading: Icon(Icons.privacy_tip_outlined, color: gold), title: Text('Privacy & permissions')),
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text('LOCKZO starter version 1.0.0', style: TextStyle(color: muted, fontSize: 12)),
      ),
    ]);
  }
}
