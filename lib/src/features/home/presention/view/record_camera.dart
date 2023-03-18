
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:video_x/src/features/home/presention/view/camera_detail.dart';
import 'package:video_x/src/share/navigator/navigator.dart';

class RecordVideoPage  extends StatefulWidget {

  final String filePath;
  const RecordVideoPage ({required this.filePath, super.key});

  @override
  State<RecordVideoPage> createState() => _RecordVideoPageState();
}

class _RecordVideoPageState extends State<RecordVideoPage>{

  late VideoPlayerController _videoPlayerController;
  

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }
  late XFile file;
    shareVideo(){
        Share.shareXFiles([VideoPlayerController.file(File(widget.filePath)) as XFile]);
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Preview'),
      elevation: 0,
      backgroundColor: Colors.black26,
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: (){
            VxNavigator.displayBottomSheet(context, const CameraDetail());
          //  VxNavigator.navigateAndRemoveUntilRoute(const HomeView());
            print('do something with the file');
          },
        )
      ],
    ),
    extendBodyBehindAppBar: true,
    body: FutureBuilder(
      future: _initVideoPlayer(),
      builder: (context, state){
        if(state.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return VideoPlayer(_videoPlayerController);
        }
      },
    ),
  );
  }
}

