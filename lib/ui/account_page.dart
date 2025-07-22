
import 'package:article_hub/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: DrawerSections.values.length,
        itemBuilder: (ctx, index) {
          final section = DrawerSections.values[index];
          return _buildSettingsItem(section.title, section.icon);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          );
        }
      ),
    );
  }


  Widget _buildSettingsItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

enum DrawerSections {
  myDetails(title: "My Details", icon: Icons.person),
  notifications(title: 'Notifications', icon: Icons.notifications),
  settings(title: 'Settings', icon: Icons.settings),
  logout(title: 'Logout', icon: Icons.logout);

  final String title;
  final IconData icon;

  const DrawerSections({required this.title, required this.icon});

}