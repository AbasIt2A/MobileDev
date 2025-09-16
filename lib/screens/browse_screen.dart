import 'package:flutter/material.dart';
import 'item_details_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String? selectedFilter = 'All Items';
  bool isGridView = true;

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
          'Browse Market',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildFilterAndLayoutButtons(),
          const SizedBox(height: 24),
          _buildTagFilters(),
          const SizedBox(height: 24),
          isGridView ? _buildGridItems() : _buildListItems(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search electronics...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndLayoutButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            label: const Text('Filters', style: TextStyle(color: Colors.black)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.grid_view, color: isGridView ? Colors.green : Colors.grey),
                onPressed: () {
                  setState(() {
                    isGridView = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.list, color: isGridView ? Colors.grey : Colors.green),
                onPressed: () {
                  setState(() {
                    isGridView = false;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagFilters() {
    final tags = ['All Items', 'Free', 'Working', 'For Parts', 'Phones', 'Laptops', 'Repair', 'New'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = selectedFilter == tag;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  selectedFilter = selected ? tag : null;
                });
              },
              selectedColor: Colors.green.withOpacity(0.1),
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? Colors.green : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridItems() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 0.65,
      children: [
        _buildItemCard(
          imageUrl: 'assets/images/gadget1.jpg',
          title: 'iPhone 12 - Cracked',
          price: '\$45',
          status: 'For Parts',
          statusColor: Colors.red,
          showViewButton: true,
        ),
        _buildItemCard(
          imageUrl: 'assets/images/gadget2.jpg',
          title: 'Dell Laptop',
          price: '\$120',
          status: 'Working',
          statusColor: Colors.green,
          showViewButton: true,
        ),
        _buildItemCard(
          imageUrl: 'assets/images/ipad_mini.jpg',
          title: 'iPad Mini',
          price: 'FREE',
          status: 'Free',
          statusColor: Colors.blue,
          showClaimButton: true,
        ),
        _buildItemCard(
          imageUrl: 'assets/images/ps4_console.jpg',
          title: 'PS4 Console',
          price: '\$85',
          status: 'Repair',
          statusColor: Colors.orange,
          showViewButton: true,
        ),
      ],
    );
  }

  Widget _buildListItems() {
    return Column(
      children: [
        _buildItemCard(
          imageUrl: 'assets/images/gadget1.jpg',
          title: 'iPhone 12 - Cracked',
          description: 'Screen broken, otherwise works fine',
          price: '\$45',
          status: 'For Parts',
          statusColor: Colors.red,
        ),
        const SizedBox(height: 16),
        _buildItemCard(
          imageUrl: 'assets/images/gadget2.jpg',
          title: 'Dell Laptop',
          description: 'Used, good condition',
          price: '\$120',
          status: 'Working',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildItemCard({
    required String imageUrl,
    required String title,
    String? description,
    required String price,
    required String status,
    required Color statusColor,
    bool showViewButton = false,
    bool showClaimButton = false,
  }) {
    bool isListView = description != null;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(
              imageUrls: [imageUrl], // <-- FIXED: pass as a list
              title: title,
              price: price,
              status: status,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: isListView
            ? Row(
                children: [
                  _buildImageStack(imageUrl, status, statusColor, isListView),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 100,
                        child: _buildItemDetails(title, description, price),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(imageUrl, status, statusColor, isListView),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _buildItemDetails(title, description, price, showViewButton: showViewButton, showClaimButton: showClaimButton),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildImageStack(String imageUrl, String status, Color statusColor, bool isListView) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: isListView
              ? const BorderRadius.all(Radius.circular(15))
              : const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Image.asset(
            imageUrl,
            height: 120,
            width: isListView ? 120 : double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                width: isListView ? 120 : double.infinity,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
              );
            },
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
            child: const Icon(Icons.favorite_border, color: Colors.black, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildItemDetails(String title, String? description, String price, {bool showViewButton = false, bool showClaimButton = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const Spacer(),
        Text(
          price,
          style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (showViewButton) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // The main onTap is on the parent GestureDetector
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('View', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
        if (showClaimButton) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Claim', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ],
    );
  }
}