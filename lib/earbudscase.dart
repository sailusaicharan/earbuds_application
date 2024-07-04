import 'package:flutter/material.dart';

class EarbudsCase extends StatefulWidget {
  final bool isVisible;

  const EarbudsCase({Key? key, required this.isVisible}) : super(key: key);

  @override
  _EarbudsCaseState createState() => _EarbudsCaseState();
}

class _EarbudsCaseState extends State<EarbudsCase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 80).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      isExpanded = !isExpanded;
    });

    if (isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: widget.isVisible ? 250 : 0,
      width: widget.isVisible ? 280 : 0,
      curve: Curves.easeInOut,
      child: widget.isVisible
          ? Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: Center(
                child: Container(
                  height: 250,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 105,
                        child: ElevatedButton(
                          onPressed: () {
                            _toggleVisibility();
                            print('Button inside case pressed.');
                          },
                          child: const Text('Button'),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _heightAnimation,
                        builder: (context, child) {
                          return Stack(
                            children: [
                              Positioned(
                                bottom: 90,
                                left: 100,
                                child: Container(
                                  width: 20,
                                  height: _heightAnimation.value,
                                  color: const Color.fromARGB(255, 189, 163, 246),
                                ),
                              ),
                              Positioned(
                                bottom: 60 + _heightAnimation.value - 10,
                                left: 80,
                                child: Container(
                                  width: 30,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 189, 163, 246),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _heightAnimation,
                        builder: (context, child) {
                          return Stack(
                            children: [
                              Positioned(
                                bottom: 90,
                                left: 180,
                                child: Container(
                                  width: 20,
                                  height: _heightAnimation.value,
                                  color: const Color.fromARGB(255, 189, 163, 246),
                                ),
                              ),
                              Positioned(
                                bottom: 60 + _heightAnimation.value - 10, 
                                left: 190,
                                child: Container(
                                  width: 30,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 189, 163, 246),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}