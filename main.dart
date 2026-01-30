import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const GroupedContactScreen(),
    );
  }
}

class GroupedContactScreen extends StatelessWidget {
  const GroupedContactScreen({super.key});

  String _getInitials(String name) {
    List<String> parts = name.trim().split(" ");
    String initials = "";

    if (parts.isNotEmpty && parts[0].isNotEmpty) {
      initials += parts[0][0];
    }

    if (parts.length > 1 && parts.last.isNotEmpty) {
      initials += parts.last[0];
    }

    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFEF5350);

    final List<Map<String, String>> rawContacts = [
      {'name': 'An Nguyễn', 'phone': '0901 234 567'},
      {'name': 'Anh Tuấn', 'phone': '0902 111 222'},
      {'name': 'Bình Trần', 'phone': '0912 345 678'},
      {'name': 'Bảo Ngọc', 'phone': '0913 999 888'},
      {'name': 'Cường Lê', 'phone': '0987 654 321'},
      {'name': 'Dũng Phạm', 'phone': '0933 112 233'},
      {'name': 'Hùng Hoàng', 'phone': '0944 556 677'},
      {'name': 'Hương Giang', 'phone': '0945 000 111'},
    ];

    rawContacts.sort((a, b) => a['name']!.compareTo(b['name']!));

    Map<String, List<Map<String, String>>> groupedContacts = {};
    for (var contact in rawContacts) {
      String firstLetter = contact['name']![0].toUpperCase();
      if (!groupedContacts.containsKey(firstLetter)) {
        groupedContacts[firstLetter] = [];
      }
      groupedContacts[firstLetter]!.add(contact);
    }

    final List<String> alphabets = groupedContacts.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'DANH BẠ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(primaryColor),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: alphabets.length,
              itemBuilder: (context, index) {
                String letter = alphabets[index];
                List<Map<String, String>> contactsInGroup = groupedContacts[letter]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                    ...contactsInGroup.map((c) => _buildContactCard(c['name']!, c['phone']!, primaryColor)).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm trong danh bạ...',
            prefixIcon: Icon(Icons.search, color: primaryColor),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String phone, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor.withOpacity(0.7), accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Text(
              _getInitials(name),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.phone, color: accentColor, size: 22),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}
