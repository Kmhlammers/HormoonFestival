import 'package:flutter/material.dart';
import 'screens/festival_screen.dart';
import 'package:card_swiper/card_swiper.dart';
import 'screens/areas/hormonen_screen.dart';
import 'package:go_router/go_router.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Festival App',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF69FBE),
          onPrimary: Color(0xFF5F0037),
          primaryContainer: Color(0xFFD3E4FF),
          onPrimaryContainer: Color(0xFF001C38),
          secondary: Color(0xFF006495),
          onSecondary: Color(0xFFFFFFFF),
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5F0037),
          ),
          bodyLarge: const TextStyle(color: Color(0xFF5F0037)),
          bodyMedium: const TextStyle(color: Color(0xFF5F0037)),
          titleLarge: const TextStyle(color: Color(0xFF5F0037), fontSize: 30),
          titleMedium: const TextStyle(color: Color(0xFF5F0037), letterSpacing: -0.5,),
          titleSmall: const TextStyle(color: Color(0xFF5F0037)),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5F0037),
            letterSpacing: 0.5,
          ),
          centerTitle: true,
          elevation: 16,
          backgroundColor: Color(0xFFF69FBE),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black.withAlpha(128),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber, 
          textTheme: ButtonTextTheme.primary, 
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 16,
        title: _buildTitle(),
        centerTitle: true,
        toolbarHeight: 80,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withAlpha(128),
      ),
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/festival');
              break;
            case 2:
              context.go('/info');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        indicatorColor: const Color(0xFFF69FBE),
        selectedIndex: _calculateSelectedIndex(context),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.festival_outlined),
            selectedIcon: Icon(Icons.festival),
            label: 'Festival',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Info',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profiel',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/festival')) return 1;
    if (path.startsWith('/info')) return 2;
    if (path.startsWith('/profile')) return 3;
    return 0;
  }

  Widget _buildTitle() {
    final String path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/festival/hormonen/quiz')) {
      return Text(
        'QUIZZ',
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    if (path.startsWith('/festival/hormonen')) {
      return Text(
        'Welkom op het\nHORMONEN terrein',
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    if (path.startsWith('/festival')) {
      return Text(
        'Welkom op het\nFESTIVAL!',
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    if (path.startsWith('/info')) {
      return Text(
        'Info',
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    if (path.startsWith('/profile')) {
      return Text(
        'Profiel',
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 2,
      text: TextSpan(
        style: Theme.of(context).textTheme.titleLarge,
        children: const [
          TextSpan(
            text: 'H! Elke, ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'leuk je\nhier weer te zien!',
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double moodValue = 0.65;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood tracker
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoe voel je je vandaag?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.wb_sunny_outlined, color: Color(0xFFF69FBE), size: 30,),
                        Icon(Icons.wb_sunny, color: Color(0xFFF69FBE), size: 50,),
                        Icon(Icons.wb_sunny, color: Color(0xFFF69FBE), size: 70,),
                      ],
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Color(0xFFF69FBE),
                        thumbColor: Colors.white,
                        overlayColor: Colors.pink.withAlpha(20),
                      ),
                      child: Slider(
                        value: moodValue,
                        onChanged: (value) {
                          setState(() {
                            moodValue = value;
                          });
                        },
                      ),
                    ),
                    Text('${(moodValue * 100).toInt()}%'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Upcoming events section
            Text(
              'VOORUITZICHT DEZE WEEK:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5F0037),
              ),
            ),
            
            SizedBox(height: 8),

            SizedBox(
              height: 200,
              child: Swiper(
                itemBuilder: (BuildContext context,int index){
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                      Image.asset('assets/images/magazine1.jpg',
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                        ),
                      Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFF69FBE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'WEEK 2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                    ])
                    
                      
                      );
                },
                itemCount: 3,
                pagination: SwiperPagination(),
              ),
            ),
            
            
            
            SizedBox(height: 16),
            
            // Information card
            Card(
              color: Color(0xFF5F0037),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '"BRAIN FOG"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'is een veelvoorkomend symptoom, waardoor concentratie en geheugen minder scherp kunnen zijn.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'REBOOST\nNederland',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(0),
                  Colors.black.withAlpha(20),
                ],
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Screen'));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Screen'));
  }
}

