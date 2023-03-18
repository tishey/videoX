// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:video_x/src/features/home/presention/view/record_camera.dart';
import 'package:video_x/src/features/home/provider/home_provider.dart';
import 'package:video_x/src/features/home/provider/location_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
 

  late CameraController _cameraController;

  bool isLoading = false;
  bool isRecording = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  // late List<CameraDescription> availableCameras;

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) {
      return camera.lensDirection == CameraLensDirection.front;
    });
    final back = cameras.firstWhere((camera) {
      return camera.lensDirection == CameraLensDirection.back;
    });
    _cameraController = CameraController(
      front,
      ResolutionPreset.max,
    );
    await _cameraController.initialize();
    setState(() => isLoading = false);
  }

  recordVideo() async {
    if (isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => RecordVideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => isRecording = true);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      CameraPreview(_cameraController);
    }
    return Consumer<HomeProvider>(builder: (context, locate, child) {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),

            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(isRecording ? Icons.stop : Icons.circle),
                onPressed: () {
                  recordVideo();
                  locate.getCurrentPosition(context);
                },
              ),
            ),
            // Padding(
            //   padding:  EdgeInsets.only(right: 70, top: 20),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: GestureDetector(
            //       onTap: ()=> _toggleCamera(),
            //       child: Image.asset('assets/images/repeat.png', height: 40, color: Colors.white,)),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
