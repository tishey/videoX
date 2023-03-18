import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_x/src/features/home/model/camera_data.dart';
import 'package:video_x/src/features/home/presention/view/home_v.dart';
import 'package:video_x/src/features/home/provider/home_provider.dart';
import 'package:video_x/src/share/navigator/navigator.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/ui_helper.dart';
import 'package:video_x/src/share/widget/custom_button.dart';
import 'package:video_x/src/share/widget/custom_textfield.dart';
import 'package:share_plus/share_plus.dart';

class CameraDetail extends StatefulWidget {
 const CameraDetail({super.key});

  @override
  State<CameraDetail> createState() => _CameraDetailState();
}

  
class _CameraDetailState extends State<CameraDetail> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late List<XFile> files;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
      titleController.dispose();
      descController.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, add, child){
      return Container(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
        height: screenHeight(context) / 3,
        child: Column(
          children: [
            addVertSpace(30),
            VxTextField(
                hintText: 'Enter title', textController: titleController),
                addVertSpace(30),
            VxTextField(
                hintText: 'Enter Desciption', textController: descController),
               const  Spacer(),
               VxPrimaryButton(
                isEnabled: true,
                buttonTitle: 'Share',
                color: VxColor.brandColor.withOpacity(0.5),
                onPressed: () {
                  

                }),
            VxPrimaryButton(
                isEnabled: true,
                buttonTitle: 'Enter',
                onPressed: () {
                  add.addCameraDesc(
                  CameraDesc(desc: descController.text,title: titleController.text),
                  );
                   VxNavigator.navigateAndRemoveUntilRoute(HomeView());
                })
          ],
        ));
    },);
        
  }
}
