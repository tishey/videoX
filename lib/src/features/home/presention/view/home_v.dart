import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_x/src/features/home/presention/view/camera_view.dart';
import 'package:video_x/src/features/home/provider/home_provider.dart';
import 'package:video_x/src/share/navigator/navigator.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/text_styling.dart';
import 'package:video_x/src/share/utils/ui_helper.dart';
import 'package:video_x/src/share/widget/custom_textfield.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    final getData = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: VxTypography.vXTextStyle(context).copyWith(
              color: VxColor.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            VxTextField(
              hintText: 'Search',
              textController: getData.searchController,
              onChanged: (val) {
                getData.searchQuery(val);
              },
            ),
            addVertSpace(20),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: getData.getCameraDesc.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: VxColor.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 6),
                                    blurRadius: 15,
                                    color: Colors.grey.withOpacity(0.1))
                              ]),
                          child: ListTile(
                            title: Row(
                              children: [
                                const CircleAvatar(),
                                addHorizonSpace(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getData.getCameraDesc[index].title,
                                      style: VxTypography.vXTextStyle(context)
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(getData.getCameraDesc[index].desc),
                                  ],
                                )
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Lat: ${getData.currentPosition.latitude.toStringAsFixed(3)} ',
                                ),
                                Text(
                                    'Long: ${getData.currentPosition.longitude.toStringAsFixed(3)}'),
                                Text('Location: ${getData.currentAddress}')
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
      // body: isShowing
      //     ? Container(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 20,
      //           vertical: 30,
      //         ),
      //         child: Consumer<HomeProvider>(
      //           builder: (context, getData, child) {
      //             return ListView.builder(itemBuilder: (context, index) {
      //               return Column(
      //                 children: [
      //                   ListTile(
      //                     title: Row(
      //                       children: [
      //                         const CircleAvatar(),
      //                         addHorizonSpace(20),
      //                         Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               getData.getCameraDesc[index].title,
      //                               style: VxTypography.vXTextStyle(context)
      //                                   .copyWith(fontWeight: FontWeight.bold),
      //                             ),
      //                             Text(getData.getCameraDesc[index].desc),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               );
      //             });
      //           },
      //         ))
      //     : const Center(child: Text('No Data added yet')),
      floatingActionButton: FloatingActionButton(
          backgroundColor: VxColor.lightBrandColor,
          child: const Icon(Icons.camera),
          onPressed: () {
            VxNavigator.navigateToRoute(const CameraPage());
          }),
    );
  }
}
