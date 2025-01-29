import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:plantcare/models/plant_model.dart';
import 'package:plantcare/theme/colors.dart';
import 'package:plantcare/widgets/plant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Plant> plants = [
    Plant(
      name: 'Beavertail Cactus',
      location: 'Bedroom\'s windowsill',
      imagePath: 'assets/beavertail_cactus.png',
      daysToWater: 2,
      watering: '100-200 ml',
      light: '6 Hours',
      temperature: '20-30°C',
      humidity: '60-70%',
    ),
    Plant(
      name: 'Vatikalive Canna',
      location: 'Kitchen\'s windowsill',
      imagePath: 'assets/vatikalive_canna.png',
      daysToWater: 3,
      watering: '200-300 ml',
      light: '4 Hours',
      temperature: '25-35°C',
      humidity: '70-80%',
    ),
    Plant(
      name: 'Mexican Fencepost',
      location: 'Bedroom\'s windowsill',
      imagePath: 'assets/mexican_fencepost.png',
      daysToWater: 5,
      watering: '150-250 ml',
      light: '5 Hours',
      temperature: '22-32°C',
      humidity: '65-75%',
    ),
    Plant(
      name: 'Hakone Grass',
      location: 'Kitchen\'s windowsill',
      imagePath: 'assets/hakone_grass.png',
      daysToWater: 6,
      watering: '100-200 ml',
      light: '3 Hours',
      temperature: '18-28°C',
      humidity: '55-65%',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  late List<Plant> _filteredPlants;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _filteredPlants = List.from(plants);
    _searchController.addListener(_filterPlants);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterPlants() {
    final query = _searchController.text.toLowerCase();
    final newList = query.isEmpty
        ? List.from(plants)
        : plants
            .where((plant) => plant.name.toLowerCase().contains(query))
            .toList();

    for (var i = _filteredPlants.length - 1; i >= 0; i--) {
      if (!newList.contains(_filteredPlants[i])) {
        _removeItem(i);
      }
    }

    for (var i = 0; i < newList.length; i++) {
      if (i >= _filteredPlants.length || _filteredPlants[i] != newList[i]) {
        _insertItem(i, newList[i]);
      }
    }
  }

  void _insertItem(int index, Plant plant) {
    _filteredPlants.insert(index, plant);
    _animatedListKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    final removedPlant = _filteredPlants.removeAt(index);
    _animatedListKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(removedPlant, animation),
    );
  }

  Widget _buildRemovedItem(Plant plant, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: PlantCard(plant: plant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Plants',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildSearchBox(),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _filteredPlants.isNotEmpty
                      ? AnimatedList(
                          key: _animatedListKey,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: _filteredPlants.length,
                          itemBuilder: (context, index, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              )),
                              child: Column(
                                children: [
                                  PlantCard(plant: _filteredPlants[index]),
                                  if (index != _filteredPlants.length - 1)
                                    const SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No plants found',
                              style: TextStyle(
                                  color: AppColors.gray, fontSize: 16),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by plant name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    FeatherIcons.search,
                    color: AppColors.primaryColor,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(FeatherIcons.settings,
                  color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
