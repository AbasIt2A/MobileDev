import 'package:flutter/material.dart';
import 'chat_details_screen.dart'; // Corrected import

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSearchBar(),
          _buildActiveConversations(context),
          _buildRecentConversations(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search conversations...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveConversations(BuildContext context) {
    final activeUsers = [
      {'name': 'John', 'avatarUrl': 'assets/images/john.jpg'},
      {'name': 'Sarah', 'avatarUrl': 'assets/images/sarah.jpg'},
      {'name': 'Mike', 'avatarUrl': 'https://i.pravatar.cc/150?img=3'},
      {'name': 'Emma', 'avatarUrl': 'https://i.pravatar.cc/150?img=4'},
      {'name': 'David', 'avatarUrl': 'https://i.pravatar.cc/150?img=5'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16.0),
          itemCount: activeUsers.length,
          itemBuilder: (context, index) {
            final user = activeUsers[index];
            return _buildActiveUserAvatar(
              context: context,
              imageUrl: user['avatarUrl']!,
              name: user['name']!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildActiveUserAvatar({
    required BuildContext context,
    required String imageUrl,
    required String name,
  }) {
    final ImageProvider imageProvider;
    if (imageUrl.startsWith('http')) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = AssetImage(imageUrl);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
              name: name,
              avatarUrl: imageUrl,
            ),
          ));
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: imageProvider,
              ),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentConversations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildConversationTile(
            context: context,
            name: 'John Smith',
            message: 'Thanks for the quick delivery!',
            time: '2m',
            avatarUrl: 'assets/images/john.jpg', // Using local asset
            isOnline: true,
            hasUnread: true,
          ),
          _buildConversationTile(
            context: context,
            name: 'Sarah Johnson',
            message: 'Do you have any organic fertilizers available?',
            time: '15m',
            avatarUrl: 'assets/images/sarah.jpg', // Using local asset
            isOnline: false,
          ),
          _buildConversationTile(
            context: context,
            name: 'Mike Wilson',
            message: 'Perfect! I\'ll take 5 of those.',
            time: '1h',
            avatarUrl: 'https://i.pravatar.cc/150?img=3', // Using network image
            isOnline: true,
            unreadCount: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildConversationTile({
    required BuildContext context,
    required String name,
    required String message,
    required String time,
    required String avatarUrl,
    bool isOnline = false,
    bool hasUnread = false,
    int unreadCount = 0,
  }) {
    final ImageProvider imageProvider;
    if (avatarUrl.startsWith('http')) {
      imageProvider = NetworkImage(avatarUrl);
    } else {
      imageProvider = AssetImage(avatarUrl);
    }

    return InkWell(
      onTap: () {
        // Correctly navigates to ChatDetailsScreen
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatDetailsScreen(
            name: name,
            avatarUrl: avatarUrl,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: imageProvider,
                ),
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hasUnread || unreadCount > 0 ? Colors.black : Colors.grey,
                      fontWeight: hasUnread || unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                if (hasUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  ),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}