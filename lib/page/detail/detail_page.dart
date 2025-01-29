import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:plantcare/models/plant_model.dart';
import 'package:plantcare/theme/colors.dart';

class DetailPage extends StatelessWidget {
  final Plant plant;

  const DetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFDCE6D9),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(plant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        FeatherIcons.arrowLeft,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 32, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            plant.location,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Care recommendations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCareCard(
                            FeatherIcons.droplet,
                            'Watering',
                            plant.watering,
                            Colors.blue[900]!,
                          ),
                          _buildCareCard(
                            FeatherIcons.sun,
                            'Light',
                            plant.light,
                            Colors.amber[900]!,
                          ),
                          _buildCareCard(
                            FeatherIcons.thermometer,
                            'Temperature',
                            plant.temperature,
                            Colors.pink[900]!,
                          ),
                          _buildCareCard(
                            FeatherIcons.cloud,
                            'Humidity',
                            plant.humidity,
                            Colors.teal[900]!,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareCard(
      IconData icon, String title, String value, Color bgColor) {
    return SizedBox(
      width: 170,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28, color: bgColor),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: bgColor,
                  ),
                  softWrap: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
