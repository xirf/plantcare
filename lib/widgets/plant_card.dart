import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:plantcare/models/plant_model.dart';
import 'package:plantcare/page/detail/detail_page.dart';
import 'package:plantcare/theme/colors.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(plant: plant),
          ),
        );
      },
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlantInfo(),
                      const SizedBox(height: 16),
                      _buildWateringInfo(),
                    ],
                  )),
            ),
            const SizedBox(width: 16),
            _buildPlantImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        plant.imagePath,
        width: 130,
        height: 130,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildPlantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plant.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          plant.location,
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }

  Widget _buildWateringInfo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.accentColor.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FeatherIcons.droplet, size: 16, color: AppColors.accentColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'In ${plant.daysToWater} days',
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
