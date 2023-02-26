import 'package:flutter/material.dart';
import 'package:mlkit_app/view/camera_page.dart';
import 'package:animated_background/animated_background.dart';

class RecognizedStart extends StatefulWidget {
  const RecognizedStart({super.key, required this.title});
  final String title;

  @override
  State<RecognizedStart> createState() => _RecognizedStartState();
}

class _RecognizedStartState extends State<RecognizedStart>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(252, 255, 255, 255),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Colors.red,
          ),
        ),
        vsync: this,
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            Image.asset('assets/images/7.png'),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 252, 92, 66),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CameraPage();
                  }));
                },
                icon: Icon(Icons.camera_alt),
                label: Text('検索する'),
              ),
            ),
          ],
        ),
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.white,
        //             backgroundColor: Colors.red,
        //           ),
        //           onPressed: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) {
        //                 return const CameraPage();
        //               }),
        //             );
        //           },
        //           child: const Text('読み取り開始'))
        //     ],
        //   ),
        // ), behaviour: null, vsync: null,
        // child: null,
      ),
    );
  }
}
