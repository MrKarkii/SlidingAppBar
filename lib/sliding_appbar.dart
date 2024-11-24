import 'package:flutter/material.dart';

class SlidingTextAppBar extends StatefulWidget {
  const SlidingTextAppBar({Key? key}) : super(key: key);

  @override
  State<SlidingTextAppBar> createState() => _SlidingTextAppBarState();
}

class _SlidingTextAppBarState extends State<SlidingTextAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Adjust the slide animation to ensure it stops fading out 10 pixels before the menu icon
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start from the far right
      end: const Offset(-0.15, 0), // Stop slightly before it goes off-screen
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Fade animation to ensure text starts fading 10 pixels before reaching the menu icon
    _fadeAnimation = Tween<double>(
      begin: 1.0, // Fully visible
      end: 0.0, // Fully faded
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.7, // Start fading out 70% of the way
          1.0, // Fully faded by the end
          curve: Curves.easeIn,
        ),
      ),
    );

    // Repeat the animation
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Sliding & Fading Text',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Body Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SlidingTextAppBar(),
  ));
}
