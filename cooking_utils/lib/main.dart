import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const accentCol = Color(0xfff5c2e7);

    const textCol = Color(0xffcdd6f4);
    const sbtxt1Col = Color(0xffbac2de);

    const bgCol = Color(0xff1e1e2e);
    const srf1Col = Color(0xff313244);

    return MaterialApp(
      title: 'Flutter Demo test',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, primary: Colors.black, inversePrimary: Colors.white, surface: Colors.black),
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xffcdd6f4)),
          bodyLarge: TextStyle(fontSize: 18, color: textCol),
          bodyMedium: TextStyle(color: textCol),
          headlineMedium: TextStyle(color: accentCol),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          iconTheme: IconThemeData(color: textCol),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: bgCol,
          inversePrimary: accentCol,
          primary: accentCol,
          onPrimary: srf1Col,
          secondary: accentCol,
          tertiary: accentCol,
          onSurface: textCol,
          surface: bgCol,
          brightness: Brightness.dark
        ).copyWith(brightness: Brightness.dark),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
bool isUnfolded(BuildContext context) {
  // If displayFeatures is not empty, we assume the app is spanned (unfolded).
  // Alternatively, you can check MediaQuery.of(context).size.width.
  final mediaQuery = MediaQuery.of(context);
  return mediaQuery.displayFeatures.isNotEmpty ||
      mediaQuery.size.width > 600;
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Widget _buildContent(int index) {
    // Return the content corresponding to the selected tab.
    switch (index) {
      case 0:
        return Center(child: Text('Home Page'));
      case 1:
        return Center(child: Text('Settings'));
      // add more cases as needed...
      default:
        return Center(child: Text('Page $index'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final unfolded = isUnfolded(context);

    if (unfolded) {
      // Use a NavigationRail for the unfolded (wide) layout.
      const sidebarDest = [
                NavigationRailDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: Text('misc'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.timer_outlined),
                  selectedIcon: Icon(Icons.timer),
                  label: Text('Timer'),
                ),
                // add more destinations as needed...
              ];

      var test = ((_selectedIndex) - (sidebarDest.length -1)) * -1;

      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: ((_selectedIndex) - (sidebarDest.length - 1 )) * -1,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = ((index) - (sidebarDest.length - 1)) * -1;
                });
              },
              labelType: NavigationRailLabelType.all,
              groupAlignment: 0,
              destinations: sidebarDest,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _buildContent(_selectedIndex)),
          ],
        ),
      );
    } else {
      // Use a BottomNavigationBar for the folded (narrow) layout.
      return Scaffold(
        body: _buildContent(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
            // add more items as needed...
          ],
        ),
      );
    }
  }
}
