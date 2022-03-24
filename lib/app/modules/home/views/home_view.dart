import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photoapp/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              searchBar(),
              Obx(
                 ()=>Expanded(
                   child: Visibility(
                     visible: controller.hits.isNotEmpty ,
                     child: SmartRefresher(controller: controller.refreshController,
                       enablePullUp: true,
                       enablePullDown: false,

                       onLoading: (){
                          controller.loadMore();
                       },
                       child: GridView.builder(
                         itemBuilder: (_,index){
                         return GestureDetector(
                             onTap: ()=>Get.toNamed(Routes.VIEW_IMAGE,arguments: [
                               controller.hits[index].largeImageURL
                             ]),
                             child: Image.network(controller.hits[index].previewURL!,fit: BoxFit.cover,));
                         },itemCount: controller.hits.length,
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3,childAspectRatio: 1.0,crossAxisSpacing: 5,mainAxisSpacing: 5
                       )),
                     ),
                   ),
                 )
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar(){
    return Row(
      children: [
        Expanded(child: TextField(decoration: InputDecoration(hintText: "Search images"),
        controller: controller.searchText,
        )),
        IconButton(onPressed: (){
          controller.getImage(clearList: true);
        }, icon: Icon(CupertinoIcons.search),)
      ],
    );
  }
}

