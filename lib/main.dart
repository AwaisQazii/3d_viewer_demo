import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Flutter3DController controller = Flutter3DController();

  @override
  void initState() {
    super.initState();
  }

  bool isPlaying = false;

  List<String> animations = [];

  initializeAnimations() async {
    final animations = await controller.getAvailableAnimations();

    this.animations.addAll(animations);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (animations.isEmpty)
                FloatingActionButton(
                  onPressed: () {
                    initializeAnimations();
                  },
                  child: const Icon(Icons.download),
                ),
              for (int i = 0; i < animations.length; i++) ...[
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                    isExtended: true,
                    onPressed: () async {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                      if (isPlaying) {
                        controller.playAnimation(animationName: animations[i]);
                      } else {
                        controller.pauseAnimation();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        animations[i].toString(),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ],
          ),
        ),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Flutter3DViewer(
                  controller: controller,
                  src: 'assets/business_man.glb',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
