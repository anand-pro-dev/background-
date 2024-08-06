import 'dart:developer';

import 'package:flutter/material.dart';

class BottomIndexScreen extends StatefulWidget {
  const BottomIndexScreen({Key? key}) : super(key: key);

  @override
  State<BottomIndexScreen> createState() => _BottomIndexScreenState();
}

class _BottomIndexScreenState extends State<BottomIndexScreen>
    with AutomaticKeepAliveClientMixin {
  //
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  late PageController _pageController;

  @override
  bool get wantKeepAlive => true; // Ensure the state is kept alive

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    log(_selectedIndex.toString());

    if (_selectedIndex != 0) {
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

      setState(() {
        _selectedIndex = 0;
      });
      return false; // Prevent app from closing
    }

    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Do you want to close the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _onItemTapped(int index) {
    // Update the selected index to the tapped index
    setState(() {
      _selectedIndex = index;
    });
    // Change the page in the PageView to the tapped index with animation
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to maintain state
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BottomNavigationBar Sample'),
        ),
        body: PageView.builder(
          controller: _pageController, // Pass the PageController
          itemCount: _widgetOptions.length,
          itemBuilder: (context, index) {
            return Center(child: _widgetOptions[index]);
          },
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
