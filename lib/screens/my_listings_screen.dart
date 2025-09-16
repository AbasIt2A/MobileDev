import 'package:flutter/material.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'My Listings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 28),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
          ),
          tabs: const [
            Tab(text: 'All (12)'),
            Tab(text: 'Active (8)'),
            Tab(text: 'Sold (3)'),
            Tab(text: 'Hidden (1)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Items
          _buildListingList(),
          // Active Items
          _buildListingList(filter: 'Active'),
          // Sold Items
          _buildListingList(filter: 'Sold'),
          // Hidden Items
          _buildListingList(filter: 'Hidden'),
        ],
      ),
    );
  }

  Widget _buildListingList({String? filter}) {
    // In a real app, you would filter a list of item objects here.
    // For this UI example, we'll just show all items.
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildListingCard(
          imageUrl: 'assets/images/gadget1.jpg',
          title: 'iPhone 12 - Cracked Screen',
          postDate: 'Posted 2 days ago',
          price: '\$85',
          views: '3 views • 1 message',
          status: 'Active',
        ),
        _buildListingCard(
          imageUrl: 'assets/images/gadget2.jpg',
          title: 'Dell Laptop - Missing Keys',
          postDate: 'Sold 5 days ago',
          price: '\$45',
          views: '12 views • 4 messages',
          status: 'Sold',
        ),
        _buildListingCard(
          imageUrl: 'assets/images/ipad_mini.jpg',
          title: 'iPad Air - Screen Scratches',
          postDate: 'Posted 1 week ago',
          price: 'Free',
          views: '8 views • 2 messages',
          status: 'Donated',
        ),
         _buildListingCard(
          imageUrl: 'assets/images/gadget3.jpg',
          title: 'PS4 Controller - Broken Stick',
          postDate: 'Posted 3 days ago',
          price: '\$25',
          views: '6 views • 0 messages',
          status: 'Active',
        ),
      ],
    );
  }

  Widget _buildListingCard({
    required String imageUrl,
    required String title,
    required String postDate,
    required String price,
    required String views,
    required String status,
  }) {
    bool isSold = status == 'Sold';
    bool isDonated = status == 'Donated';
    bool isActive = status == 'Active';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(width: 80, height: 80, color: Colors.grey[200]),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isActive)
                            _buildStatusChip('Active', Colors.green),
                          if (isSold)
                            _buildStatusChip('Sold', Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(postDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(views, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isActive) _buildActiveButtons(),
            if (isSold) _buildSoldButtons(),
            if (isDonated) _buildDonatedButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildActiveButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Mark as Sold'),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () {}, child: const Text('Edit')),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () {}, child: const Icon(Icons.more_horiz)),
      ],
    );
  }

  Widget _buildSoldButtons() {
    return Row(
      children: [
        Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Sold'))),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () {}, child: const Text('View')),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          child: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  Widget _buildDonatedButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: const Text('Mark as Donated'),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () {}, child: const Text('Edit')),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () {}, child: const Icon(Icons.more_horiz)),
      ],
    );
  }
}