import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';

class WistJeDatScreen extends StatefulWidget {
  const WistJeDatScreen({super.key});

  @override
  State<WistJeDatScreen> createState() => _WistJeDatScreenState();
}

class _WistJeDatScreenState extends State<WistJeDatScreen> {
  final List<bool> isBoxOpen = [false, false, false];

  final List<(String, String)> boxImages = [
    ('blue_box', 'blue_box_open'),
    ('red_box', 'red_box_open'),
    ('pink_box', 'pink_box_open'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Back button
        Positioned(
          top: 7,
          left: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ElevatedButton(
              onPressed: () => context.go('/festival/hormonen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'KAART',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),

        // Main content with Swiper
        Positioned(
          bottom: 80, // Space for bottom navigation bar
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // Close other boxes when opening a new one
                    for (int i = 0; i < isBoxOpen.length; i++) {
                      if (i != index) isBoxOpen[i] = false;
                    }
                    isBoxOpen[index] = !isBoxOpen[index];
                  });
                },
                child: Image.asset(
                  'assets/images/${isBoxOpen[index] ? boxImages[index].$2 : boxImages[index].$1}.png',
                  fit: BoxFit.contain,
                ),
              );
            },
            itemCount: 3,
            control: SwiperControl(),
          ),
        ),

        // Text box overlay when any box is open
        if (isBoxOpen.any((isOpen) => isOpen))
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double imageHeight = MediaQuery.of(context).size.height * 0.4;
                
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Background tekstvak image with border
                    SizedBox(
                      width: 350, // Set a fixed maximum width
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Image.asset(
                          'assets/images/tekstvak_paars.png',
                          fit: BoxFit.contain,
                          height: imageHeight,
                        ),
                      ),
                    ),
                    // Text overlay with border
                    SizedBox(
                      width: 330, 
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 40.0),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 350,
                              maxHeight: 200,
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'FEIT - ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 30, 
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'OESTROGEEN IS NIET ALLEEN EEN \'VROUWELIJK\' HORMOON. MANNEN HEBBEN HET OOK NODIG, MAAR IN KLEINERE HOEVEELHEDEN.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18, // Original font size for the rest
                                      height: 2.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
