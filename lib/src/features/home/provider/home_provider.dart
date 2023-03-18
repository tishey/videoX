
 import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_x/src/features/home/model/camera_data.dart';
import 'package:video_x/src/features/home/presention/view/record_camera.dart';

class HomeProvider extends ChangeNotifier{
  List<CameraDesc> getCameraDesc = [];
  List<CameraDesc>? myList;
   String searchList = '';

 TextEditingController searchController = TextEditingController();



  int index = 0;

  addCameraDesc(CameraDesc desc) {
      getCameraDesc.add(desc);
    notifyListeners();
  }

  //  void searchQuery(String query){
  //    List<String> getData = [];
  //    getData.addAll(getCameraDesc as Iterable<String>);
  //    if(query.isNotEmpty){
  //      List<String> dummyList = [];
  //      dummyList.forEach((e) { 
  //        if(e.contains(query)){
  //          dummyList.add(e);
  //        }
  //      });
  //      dummyCameraDesc.clear();
  //      dummyCameraDesc.addAll(getCameraDesc as Iterable<String>);
  //      notifyListeners();
  //      return;
  //    }else{
  //      dummyCameraDesc.clear();
  //      dummyCameraDesc.addAll(getCameraDesc as Iterable<String>);
  //      notifyListeners();
  //    }
  //  }

  searchQuery(String query){
    searchList = query;
    myList = getCameraDesc.where((item) => item.title.contains(searchList)).toList();
    notifyListeners();
  } 


  // Getting user video record location

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  String currentAddress = '';
  late Position currentPosition;
  // getCurrentLocation() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      _getAddressFromLatLng(currentPosition);
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Formatting the location to readable code

  Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[index];
    notifyListeners();
      currentAddress =
         ' ${place.country}';
    notifyListeners();
  }).catchError((e) {
    debugPrint(e);
  });
 }


  late CameraController _cameraController;

  bool isLoading = false;
  bool isRecording = false;
  
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
      isLoading = false;
      notifyListeners();
    
  
  }

  recordVideo(BuildContext context) async {
    if (isRecording) {
      final file = await _cameraController.stopVideoRecording();
       isRecording = false;
       notifyListeners();
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => RecordVideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      isRecording = true;
      notifyListeners();
    }
  }
}