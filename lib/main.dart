import 'package:flutter/material.dart';
import 'earbudscase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBluetoothEnabled = false;
  bool isVisible = false;

  void _toggleEarbudsCaseVisibility() {
    setState(() {
      isVisible = !isVisible;
    });

    if (isBluetoothEnabled && isVisible) {
      // Both conditions met: Bluetooth enabled and earbuds case visible
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bluetooth Connected'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Bluetooth',
            style: TextStyle(color: Color.fromARGB(255, 94, 111, 240)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loo.png'), 
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bluetooth,
                            size: 50,
                            color: isBluetoothEnabled
                                ? Color.fromARGB(255, 94, 111, 240)
                                : Colors.white,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Bluetooth',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Switch(
                            value: isBluetoothEnabled,
                            onChanged: (value) {
                              setState(() {
                                isBluetoothEnabled = value;
                              });
                            },
                            activeColor: const Color.fromARGB(255, 94, 111, 240),
                            inactiveThumbColor: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isBluetoothEnabled ? 'Enabled' : 'Disabled',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _toggleEarbudsCaseVisibility,
                            child: Text(isVisible ? 'Close' : 'Open'),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 02,
                      left: 50, 
                      child: Container(
                        width: 100,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                EarbudsCase(isVisible: isVisible),
              ],
            ),
          ),
        ),
      ),
    );
  }
}