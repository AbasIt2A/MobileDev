import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

enum Condition { working, needsRepair, forParts }

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  Condition? _selectedCondition;
  String? _selectedCategory;

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
          'Post Item',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Item Name *'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Category *'),
                _buildCategoryDropdown(),
                const SizedBox(height: 24),
                _buildSectionTitle('Condition *'),
                _buildConditionRadios(),
                const SizedBox(height: 24),
                _buildSectionTitle('Photos'),
                const Text(
                  'Add up to 5 photos to help buyers see your item',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _buildPhotoUploaders(),
                const SizedBox(height: 24),
                _buildSectionTitle('Price'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    hintText: '0.00',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Location *'),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    hintText: 'Enter your location',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildPostButton(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      hint: const Text('Select category'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      items: ['Phones', 'Laptops', 'Appliances', 'Accessories']
          .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  Widget _buildConditionRadios() {
    return Column(
      children: [
        RadioListTile<Condition>(
          title: const Text('Working'),
          value: Condition.working,
          groupValue: _selectedCondition,
          onChanged: (Condition? value) {
            setState(() {
              _selectedCondition = value;
            });
          },
        ),
        RadioListTile<Condition>(
          title: const Text('Needs Repair'),
          value: Condition.needsRepair,
          groupValue: _selectedCondition,
          onChanged: (Condition? value) {
            setState(() {
              _selectedCondition = value;
            });
          },
        ),
        RadioListTile<Condition>(
          title: const Text('For Parts'),
          value: Condition.forParts,
          groupValue: _selectedCondition,
          onChanged: (Condition? value) {
            setState(() {
              _selectedCondition = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPhotoUploaders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPhotoBox(icon: Icons.camera_alt_outlined, label: 'Camera'),
        _buildPhotoBox(icon: Icons.photo_library_outlined, label: 'Gallery'),
        _buildPhotoBox(icon: null, label: null),
      ],
    );
  }

  Widget _buildPhotoBox({required IconData? icon, required String? label}) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      dashPattern: const [6, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.grey, size: 30),
                  const SizedBox(height: 4),
                  Text(label!, style: const TextStyle(color: Colors.grey)),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildPostButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D63F3),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Post Item', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}