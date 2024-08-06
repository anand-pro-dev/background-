import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CallApp());
}

class CallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CallScreen(),
    );
  }
}

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with WidgetsBindingObserver {
  double _xOffset = 0.0;
  double _yOffset = 0.0;
  bool isDragging = false;

  late AppLifecycleNotifier _appLifecycleNotifier;
  late StreamSubscription<bool> _lifecycleSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _appLifecycleNotifier = AppLifecycleNotifier();
    _lifecycleSubscription =
        _appLifecycleNotifier.isResumedStream.listen((isResumed) {
      if (isResumed) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _appLifecycleNotifier.dispose();
    _lifecycleSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calling Screen'),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Your Call Screen Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Positioned(
            left: _xOffset,
            top: _yOffset,
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  isDragging = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _xOffset += details.delta.dx;
                  _yOffset += details.delta.dy;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  isDragging = false;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDragging ? Colors.blue : Colors.green,
                ),
                child: const Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppLifecycleNotifier extends WidgetsBindingObserver {
  Stream<bool> get isResumedStream => _isResumedController.stream;
  final StreamController<bool> _isResumedController =
      StreamController<bool>.broadcast();

  AppLifecycleNotifier() {
    WidgetsBinding.instance!.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _isResumedController.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isResumedController.add(state == AppLifecycleState.resumed);
  }
}

class AnotherSceen extends StatefulWidget {
  const AnotherSceen({super.key});

  @override
  State<AnotherSceen> createState() => _AnotherSceenState();
}

class _AnotherSceenState extends State<AnotherSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("data"),
    );
  }
}
