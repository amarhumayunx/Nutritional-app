import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'glass_card.dart';

void main() {
  runApp(const NutritionTrackerApp());
}

class NutritionTrackerApp extends StatelessWidget {
  const NutritionTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'SF Pro',
      ),
      home: const NutritionTrackerHome(),
    );
  }
}

class NutritionTrackerHome extends StatelessWidget {
  const NutritionTrackerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Stack(
          children: [
            // Scrollable Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 45),

                    // Today's Overview Title
                    const Text(
                      "Today's overview",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nutrition Overview Card
                    _buildNutritionOverviewCard(),
                    const SizedBox(height: 16),

                    // Streak Card
                    _buildStreakCard(),
                    const SizedBox(height: 16),

                    // Weight Progress Card
                    _buildWeightProgressCard(),
                    const SizedBox(height: 16),

                    // Nutritional Analysis Card
                    _buildNutritionalAnalysisCard(),
                    const SizedBox(height: 16),

                    // Exercise Card
                    _buildExerciseCard(),
                    const SizedBox(height: 16),

                    // Groceries Card
                    _buildGroceriesCard(),
                    const SizedBox(height: 120), // Space for navbar
                  ],
                ),
              ),
            ),

            // Fixed Menu Icon at Top Right
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        ' ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const GlassIconChip(
                        icon: Icon(Icons.menu, color: Colors.white, size: 24),
                        size: 45,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionOverviewCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nutrition Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SvgOrIcon(
                assetPath: 'assets/Info.svg',
                fallbackIcon: Icons.info_outline,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),

          const Text(
            'Calories & macros',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 24),

          // 🔹 Calorie Semi-Circle + Eaten/Goal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    '1250',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Eaten',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 140,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(140, 100),
                      painter: SemiCircleProgressPainter(
                        progress: 0.60, // 1250/3200
                        backgroundColor: Colors.white.withOpacity(0.2),
                        progressColor: const Color(0xFFFF5722),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SvgOrIcon(
                            assetPath: 'assets/FLAME.svg', // 🔸 your SVG
                            fallbackIcon: Icons.local_fire_department,
                            color: Color(0xFFFF5722),
                            size: 20,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '1503',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Remaining',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text(
                    '3200',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Goal',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(
            color: Colors.white,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Expanded(
                child: _buildMacroBar(
                  'assets/ProteinIcon.svg',
                  'Protein',
                  145,
                  180,
                  Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMacroBar(
                  'assets/CarbsIcon.svg',
                  'Carbs',
                  135,
                  210,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMacroBar(
                  'assets/FatsIcon.svg',
                  'Fats',
                  55,
                  90,
                  Colors.orange,
                ), // fallback emoji
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5722),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBar(
    String assetOrEmoji,
    String name,
    int current,
    int total,
    Color color,
  ) {
    final progress = current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconOrSvg(assetOrEmoji, size: 22),
            const SizedBox(width: 4),
            Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 7,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                height: 7,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            '$current / ${total}g',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconOrSvg(String assetOrEmoji, {double size = 24}) {
    if (assetOrEmoji.endsWith('.svg')) {
      // Try loading SVG — with graceful fallback if not found
      return SvgPicture.asset(
        assetOrEmoji,
        width: size,
        height: size,
        placeholderBuilder: (_) => const Icon(
          Icons.image_not_supported,
          color: Colors.white54,
          size: 20,
        ),
      );
    } else {
      // Otherwise, assume it's an emoji or text icon
      return Text(assetOrEmoji, style: TextStyle(fontSize: size));
    }
  }
}

Widget _buildStreakCard() {
  return GlassCard(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('🔥', style: TextStyle(fontSize: 42)),
              SizedBox(height: 8),
              Text(
                '37 Days',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Keep up the streak!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Small wins today fuel big results tomorrow.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white60,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              _buildDayProgressRow([
                {'day': 'Mon', 'completed': true},
                {'day': 'Tue', 'completed': true},
                {'day': 'Wed', 'completed': false},
                {'day': 'Thu', 'completed': false},
                {'day': 'Fri', 'completed': false},
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDayProgressRow(List<Map<String, dynamic>> days) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: List.generate(days.length, (index) {
      final day = days[index]['day'];
      final completed = days[index]['completed'];
      final isLast = index == days.length - 1;

      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle + label
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circle
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: completed
                        ? const Color(0xFFFF5722)
                        : Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: completed
                        ? null
                        : Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                  ),
                  child: completed
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),

            // Connector line (center-aligned between dots)
            if (!isLast)
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 18,
                    ), // Half of circle height
                    height: 2,
                    color: days[index + 1]['completed']
                        ? const Color(0xFFFF5722)
                        : Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
          ],
        ),
      );
    }),
  );
}

Widget _buildWeightProgressCard() {
  return GlassCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weight Progress',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: Stack(
            children: [
              // Chart itself
              Positioned.fill(
                left: 40, // leave space for vertical labels
                child: CustomPaint(painter: WeightChartPainterUpdated()),
              ),

              // Vertical labels
              Positioned(
                left: 0,
                top: 10,
                bottom: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '72k',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '71k',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '70k',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeightStatBox('7 days', '+0.35kg', const Color(0xFFFF5722)),
              _buildWeightStatBox('30 days', '-2.1kg', const Color(0xFF4CAF50)),
              _buildWeightStatBox('90 days', '-3.5kg', const Color(0xFF4CAF50)),
              _buildWeightStatBox(
                '120 days',
                '-9.2kg',
                const Color(0xFF4CAF50),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildWeightStatBox(String label, String value, Color valueColor) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: valueColor,
        ),
      ),
    ],
  );
}

Widget _buildNutritionalAnalysisCard() {
  return GlassCard(
    padding: EdgeInsets.zero,
    child: CustomPaint(
      painter: DottedBorderPainter(),
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.bolt_rounded, color: Color(0xFFFF7A3C), size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's Nutritional Analysis",
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13.8,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(text: "You haven't eaten any "),
                            TextSpan(
                              text: "iron",
                              style: TextStyle(
                                color: const Color(0xFFFF7A3C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " today. "),
                            const TextSpan(text: "\n"),
                            const TextSpan(text: "Consider adding "),
                            TextSpan(
                              text: "beans",
                              style: TextStyle(
                                color: const Color(0xFFFF7A3C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " to your dinner."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildExerciseCard() {
  return GlassCard(
    padding: const EdgeInsets.all(19),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Exercise',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Color(0xFFFF5722),
                        size: 24,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '551',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'kcal',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                  Text(
                    'Calories Burnt Today',
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildIconOrImage('assets/exercise.png', size: 120),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 72),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Logging an Exercise',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildIconOrImage(String assetOrEmoji, {double size = 80}) {
  if (assetOrEmoji.endsWith('.png') || assetOrEmoji.endsWith('.jpg')) {
    return FutureBuilder<bool>(
      future: _isAssetAvailable(assetOrEmoji),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: size,
            height: size,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Image.asset(
            assetOrEmoji,
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
        } else {
          return const Text('🏋️', style: TextStyle(fontSize: 80));
        }
      },
    );
  } else {
    return Text(assetOrEmoji, style: TextStyle(fontSize: size));
  }
}

Future<bool> _isAssetAvailable(String path) async {
  try {
    await rootBundle.load(path);
    return true;
  } catch (_) {
    return false;
  }
}

Widget _buildGroceriesCard() {
  return GlassCard(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Groceries',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Turn your weekly diet into\na shopping list with no effort.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Generate Shopping List',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
        _buildbasketIconOrImage('assets/basket.png', size: 150),
      ],
    ),
  );
}

Widget _buildbasketIconOrImage(String assetOrEmoji, {double size = 60}) {
  if (assetOrEmoji.endsWith('.png')) {
    return Image.asset(
      assetOrEmoji,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.image_not_supported,
        color: Colors.white54,
        size: 40,
      ),
    );
  } else {
    return Text(assetOrEmoji, style: TextStyle(fontSize: size));
  }
}

Widget _buildBottomNavigationBar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          borderRadius: 40,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.home, "Home", isActive: true),
                _buildNavItem(Icons.description_outlined, "Diary"),
                const SizedBox(width: 60), // Space for + button
                _buildNavItem(Icons.restaurant, "Diet"),
                _buildNavItem(Icons.insert_chart_outlined, "Progress"),
              ],
            ),
          ),
        ),
        Positioned(
          top: -28,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF5722),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5722).withOpacity(0.6),
                  blurRadius: 30,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFFF5722),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 22,
        color: isActive
            ? const Color(0xFFFF5722)
            : Colors.white.withOpacity(0.7),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          color: isActive
              ? const Color(0xFFFF5722)
              : Colors.white.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}


class WeightChartPainterUpdated extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw filled area under curve
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFF5722).withOpacity(0.3),
          const Color(0xFFFF5722).withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Horizontal grid lines
    for (int i = 0; i < 3; i++) {
      final y = size.height * 0.15 + (i * size.height * 0.35);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Chart data points
    final points = [
      Offset(0, size.height * 0.45),
      Offset(size.width * 0.14, size.height * 0.25),
      Offset(size.width * 0.28, size.height * 0.2),
      Offset(size.width * 0.42, size.height * 0.35),
      Offset(size.width * 0.56, size.height * 0.3),
      Offset(size.width * 0.7, size.height * 0.25),
      Offset(size.width * 0.84, size.height * 0.35),
      Offset(size.width, size.height * 0.45),
    ];

    // Create smooth curve path
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlX = (p0.dx + p1.dx) / 2;
      final controlY = (p0.dy + p1.dy) / 2;
      path.quadraticBezierTo(p0.dx, p0.dy, controlX, controlY);
    }
    path.lineTo(points.last.dx, points.last.dy);

    // Fill area under curve
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw the curve line
    final linePaint = Paint()
      ..color = const Color(0xFFFF5722)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    // X-axis labels
    final days = ['M', 'T', 'W', 'Th', 'F', 'S', 'S'];
    for (int i = 0; i < days.length; i++) {
      final x = size.width * (i / 6);
      final textPainter = TextPainter(
        text: TextSpan(
          text: days[i],
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height + 10),
      );
    }

    // Draw "0" label at bottom left
    final zeroTextPainter = TextPainter(
      text: TextSpan(
        text: '0',
        style: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    zeroTextPainter.layout();
    zeroTextPainter.paint(
      canvas,
      Offset(
        -zeroTextPainter.width - 12,
        size.height - zeroTextPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 8;
    const dashSpace = 6;
    const radius = 38.0;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(radius),
        ),
      );

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final start = distance;
        final double end = (distance + dashWidth).clamp(0, metric.length);
        dashPath.addPath(metric.extractPath(start, end), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GradientBackground extends StatelessWidget {
  final Widget? child;

  const GradientBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF3D2A1F), Color(0xFF000000)],
          center: Alignment.topRight,
          radius: 1.5,
          stops: [0.0, 0.7],
        ),
      ),
      child: Stack(
        children: [
          // Decorative blobs
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF5C3D2E).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF4A3020).withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF5C3D2E).withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -20,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF4A3020).withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main content goes here
          if (child != null) child!,
        ],
      ),
    );
  }
}

class SemiCircleProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  SemiCircleProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 45);
    final radius = size.width / 2 - 10;
    const strokeWidth = 12.0;

    // Background arc
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // 🟢 Change this angle to increase arc length
    const arcAngle = math.pi * 1.4; // 1.0 = 180°, 1.2 = 216°

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi - (arcAngle - math.pi) / 2,
      arcAngle,
      false,
      bgPaint,
    );

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi - (arcAngle - math.pi) / 2,
      arcAngle * progress,
      false,
      progressPaint,
    );

    // White dot at the end
    final angle = math.pi - (arcAngle - math.pi) / 2 + (arcAngle * progress);
    final dotX = center.dx + radius * math.cos(angle);
    final dotY = center.dy + radius * math.sin(angle);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(dotX, dotY), 3, dotPaint);
  }

  @override
  bool shouldRepaint(SemiCircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class SvgOrIcon extends StatelessWidget {
  final String? assetPath;
  final IconData fallbackIcon;
  final double size;
  final Color color;

  const SvgOrIcon({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    this.size = 24,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath != null && assetPath!.isNotEmpty) {
      return SvgPicture.asset(
        assetPath!,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        placeholderBuilder: (_) => Icon(fallbackIcon, size: size, color: color),
      );
    } else {
      return Icon(fallbackIcon, size: size, color: color);
    }
  }
}

class GlassIconChip extends StatelessWidget {
  final Widget icon;
  final double size;
  final VoidCallback? onTap;

  const GlassIconChip({
    super.key,
    required this.icon,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: EdgeInsets.zero,
        borderRadius: size / 2,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}