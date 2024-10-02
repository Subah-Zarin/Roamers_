import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roamers/Setting/setting_item.dart';
import 'package:roamers/Setting/setting_switch.dart';
import 'package:roamers/homepage/profile.dart';
import '../Chat/chat.dart';
import '../homepage/homepage.dart';
import 'CreditsPage.dart';
import 'DetailsPage.dart';

import 'forward_button.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isDarkMode = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("assets/images/avatar.jpg",
                        width: 70, height: 70),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Edit profile",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => profile(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Details",
                icon: Ionicons.desktop_outline,
                bgColor: Colors.blueGrey.shade50,
                iconColor: Colors.lightBlueAccent,
                value: "Purpose",
                onTap: () {
                  // Navigate to the Details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Detailspage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Credits",
                icon: Ionicons.albums_outline,
                bgColor: Colors.blueGrey.shade50,
                iconColor: Colors.lightBlueAccent,
                value: "About us",
                onTap: () {
                  // Navigate to the Credits page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Creditspage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help",
                icon: Ionicons.nuclear,
                bgColor: Colors.blueGrey.shade50,
                iconColor: Colors.lightBlueAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>ChatPage(),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for DetailsPage
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: const Center(child: Text("Details Page")),
    );
  }
}

// Placeholder for CreditsPage
class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Credits")),
      body: const Center(child: Text("Credits Page")),
    );
  }
}
