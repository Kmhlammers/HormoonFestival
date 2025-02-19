import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hormoon_festival/styles/text_style.dart';

class OverlayImageConfig {
  final String imagePath;
  final double top;
  final double right;
  final double height;

  OverlayImageConfig({
    required this.imagePath,
    this.top = 0,
    this.right = 0,
    this.height = 50,
  });
}


class LayoutScreen extends StatefulWidget {
  final Widget child;
  final String title;
  final OverlayImageConfig? overlayConfig;

  const LayoutScreen({
    super.key,
    required this.child,
    required this.title,
    this.overlayConfig,
  });

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(title: widget.title),
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
        ),
        if (widget.overlayConfig != null)
          Positioned(
             top: widget.overlayConfig!.top,
              //left: widget.overlayConfig!.left,
              right: widget.overlayConfig!.right,
              child: Image.asset(
                widget.overlayConfig!.imagePath,
                fit: BoxFit.cover,
                height: widget.overlayConfig!.height,
              ),
          ),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/festival')) return 1;
    if (path.startsWith('/info')) return 2;
    if (path.startsWith('/profile')) return 3;
    return 0;
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.height = 82.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 40,
      centerTitle: true,
      toolbarHeight: height,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, // Same color as AppBar
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(90, 0, 0, 0), // Subtle shadow
              offset: Offset(0, 7), // Shadow only below
              blurRadius: 10.0, // Soft blur for elevation effect
            ),
          ],
        ),
      ),
      
    );
  }

  Widget _buildTitle(BuildContext context) {
    // Check if the title contains the welcome message
    if (title.startsWith('H! Elke')) {
      return RichText(
        textAlign: TextAlign.justify,
        maxLines: 2,
        text: TextSpan(
          style: Theme.of(context).textTheme.titleLarge,
          children: [
            TextSpan(
              text: 'H! Elke, ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'leuk je\nhier weer te zien!',
            ),
          ],
        ),
      );
    }
    if (title.startsWith('QUIZZ') || title.startsWith('WIST')) {
      return Text(
        textAlign: TextAlign.start,
        title,
        style: AppStyle.boldTitleStyle.copyWith(
          wordSpacing: 1,
          letterSpacing: 2.0,
        ),
        
      );
    }
    
    // For all other titles
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
