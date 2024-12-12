import 'package:flutter/material.dart';

class DashboardCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const DashboardCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Adaptive card width - smaller percentage for smaller screens
    double cardWidth = screenWidth < 600
        ? screenWidth * 0.85 // 85% width for small screens
        : screenWidth * 0.40; // 45% width for larger screens

    // Minimum height with flexible growth
    double minHeight = 300.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        constraints: BoxConstraints(
          minHeight: minHeight,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Allow column to wrap content
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
