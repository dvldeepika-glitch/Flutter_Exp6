import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Global application theme
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Widgets and Theming',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF3F8F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.amber,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

// Custom reusable avatar widget
class CustomAvatar extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final String? initials;
  final Color backgroundColor;

  const CustomAvatar({
    super.key,
    this.radius = 45,
    this.imageUrl,
    this.initials,
    this.backgroundColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage:
          imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              initials ?? 'U',
              style: TextStyle(
                fontSize: radius * 0.65,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

// Custom reusable profile card
class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        trailing: trailingIcon != null
            ? Icon(
                trailingIcon,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

// Custom reusable gradient button
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradientColors = const [
      Colors.teal,
      Color(0xFF26A69A),
    ],
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 10),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main profile screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const CustomAvatar(
                  radius: 55,
                  initials: 'DV',
                  backgroundColor: Colors.teal,
                ),

                const SizedBox(height: 16),

                Text(
                  'Deepika',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 6),

                Text(
                  'Flutter Developer',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 24),

                ProfileCard(
                  title: 'Deepika',
                  subtitle: 'deepika@example.com',
                  trailingIcon: Icons.person_outline,
                  onTap: () {
                    _showMessage(context, 'Profile details selected');
                  },
                ),

                ProfileCard(
                  title: 'Account Settings',
                  subtitle: 'Manage your preferences',
                  trailingIcon: Icons.settings_outlined,
                  onTap: () {
                    _showMessage(context, 'Account settings selected');
                  },
                ),

                const SizedBox(height: 24),

                CustomButton(
                  label: 'Edit Profile',
                  icon: Icons.edit,
                  onPressed: () {
                    _showMessage(context, 'Edit Profile button pressed');
                  },
                ),

                const SizedBox(height: 16),

                CustomButton(
                  label: 'Settings',
                  icon: Icons.settings,
                  gradientColors: const [
                    Colors.amber,
                    Color(0xFFFF8F00),
                  ],
                  onPressed: () {
                    _showMessage(context, 'Settings button pressed');
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'Custom Widgets • Reusable UI • Flutter ThemeData',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Display feedback when a button or card is tapped
void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}