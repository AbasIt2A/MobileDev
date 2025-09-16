import 'package:flutter/material.dart';
import 'my_listings_screen.dart'; // Import the new listings screen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white, // Changed for better pinning transition
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(context),
            ),
            automaticallyImplyLeading: false, // Remove default back button
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildStatsRow(),
                      const SizedBox(height: 24),
                      _buildSectionHeader('My Activity'),
                      const SizedBox(height: 8),
                      // This ListTile is now clickable
                      _buildListTile(
                        icon: Icons.format_list_bulleted,
                        title: 'My Listings',
                        subtitle: 'View your posted items',
                        trailingText: '3 Active',
                        trailingColor: Colors.green,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyListingsScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildListTile(
                        icon: Icons.shopping_bag_outlined,
                        title: 'My Purchases',
                        subtitle: 'Track your orders',
                        trailingText: '2 Recent',
                        trailingColor: Colors.blue,
                        onTap: () {},
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Settings'),
                      const SizedBox(height: 8),
                      _buildListTile(
                        icon: Icons.person_outline,
                        title: 'Account Settings',
                        onTap: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildListTile(
                        icon: Icons.notifications_none,
                        title: 'Notifications',
                        onTap: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildListTile(
                        icon: Icons.shield_outlined,
                        title: 'Privacy & Security',
                        onTap: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildListTile(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {},
                      ),
                      const SizedBox(height: 24),
                      _buildListTile(
                        icon: Icons.logout,
                        title: 'Logout',
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        onTap: () {},
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00C6FF), // Lighter blue
            Color(0xFF0072FF), // Darker blue
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                onPressed: () {},
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.blue, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sarah Johnson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'sarah.johnson@email.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('12', 'Items Sold', Colors.purple.shade50),
        const SizedBox(width: 16),
        _buildStatCard('8', 'Items Bought', Colors.green.shade50),
        const SizedBox(width: 16),
        _buildStatCard('5', 'Items Donated', Colors.orange.shade50),
      ],
    );
  }

  Widget _buildStatCard(String count, String label, Color backgroundColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailingText,
    Color? trailingColor,
    Color iconColor = Colors.grey,
    Color textColor = Colors.black87,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.grey)) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trailingColor?.withOpacity(0.1) ?? Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trailingText,
                  style: TextStyle(
                    color: trailingColor ?? Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}