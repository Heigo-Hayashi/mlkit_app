import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mlkit_app/repository/repository.dart';
import 'package:mlkit_app/utils/camera.dart';
import 'package:mlkit_app/view_model/provider.dart';

import 'result_page.dart';

List<CameraDescription> cameras = [];

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  CameraState createState() => CameraState();
}

class CameraState extends ConsumerState<CameraPage> {
  late CameraController controller;
  final TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
  bool isReady = false;
  bool skipScanning = false;
  bool isScanned = false;
  RecognizedText? recognizedText;
  List scannedText = [];

  @override
  void initState() {
    super.initState();
    scannedText = [];
    _setup();
  }

  void reload() {
    skipScanning = false;
    isScanned = false;
    recognizedText = null;
    scannedText.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    textRecognizer.close();
    super.dispose();
  }

  _processImage(CameraImage availableImage) async {
    if (!mounted || skipScanning) return;
    setState(() {
      skipScanning = true;
      scannedText = [];
    });

    final inputImage = convert(
      camera: cameras[0],
      cameraImage: availableImage,
    );
    recognizedText = await textRecognizer.processImage(inputImage);
    //add
    if (scannedText != []) {
      scannedText.clear();
    }
    for (TextBlock block in recognizedText!.blocks) {
      for (TextLine line in block.lines) {
        scannedText.add(line.text);
      }
    }
    if (!mounted) return;
    setState(() {
      skipScanning = false;
    });

    //テキストが存在するとき
    if (recognizedText != null && recognizedText!.text.isNotEmpty) {
      controller.stopImageStream();
      setState(() {
        isScanned = true;
      });
    }
  }

  Future<void> _setup() async {
    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.max);

    await controller.initialize().catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // ignore: avoid_print
            print('User denied camera access.');
            break;
          default:
            // ignore: avoid_print
            print('Handle other errors.');
            break;
        }
      }
    });

    if (!mounted) {
      return;
    }

    setState(() {
      isReady = true;
    });

    controller.startImageStream(_processImage);
    reload();
  }

  @override
  Widget build(BuildContext context) {
    final textName = ref.watch(textNameProvider.notifier);
    final isLoading = !isReady || !controller.value.isInitialized;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/iPhone2.png'),
        elevation: 1.0,
      ),
      body: Column(
          children: isLoading
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          children: [
                            ClipRect(
                              child: Transform.scale(
                                scale: controller.value.aspectRatio * 16 / 9,
                                child: Center(
                                  child: CameraPreview(controller),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  if (isScanned)
                    ElevatedButton.icon(
                     style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 252, 92, 66),
                
                ),
                      onPressed: () {
                        setState(() {
                          reload();
                          scannedText = [];
                          if (scannedText != []) {
                            print('reloadしたけど空じゃない');
                          }
                        });
                        controller.startImageStream(_processImage);
                      },
                        icon: Icon(Icons.camera_alt),
                        label: Text('もう一度読み取る'),
                    )
                  else
                    const Text('読み込み中'),
                  if (recognizedText != null && scannedText != [])
                    for (final i in scannedText)
                      if (i.length > 2)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), //角の丸み
                            ),
                            foregroundColor: Color.fromARGB(255, 66, 165, 247),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                            color: Colors.blue, //色
                            width: 1, //太さ
    ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            textName.state = i;
                            Repository repository = Repository();
                            repository.fetchList(textName.state);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                          keyword: i,
                                        )));
                          },
                          child: Text(i),
                        ),
                ]),
    );
  }
}
