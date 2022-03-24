import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photoapp/app/data/ImageDataResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {

  TextEditingController searchText = TextEditingController();
  RxList<Hits> hits = <Hits>[].obs;
  Dio dio = Dio();
  int pageCount = 1;
  RefreshController refreshController =  RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  loadMore(){
      pageCount++;
      getImage();
  }

  void getImage({bool clearList = false}) async {

    if (searchText.text != "") {
      try {
        if (clearList) {
          hits.clear();
        }
        var response = await dio.get('https://pixabay.com/api/',queryParameters: {
          "key":"26285796-76c9eb0b01dd772d686fe421c",
          "image_type":"photo",
          "q": searchText.text,
          "page":pageCount
        });
        if (response.statusCode == 200) {
          ImageDataResponse imageDataResponse = ImageDataResponse.fromJson(response.data);
          hits.addAll(imageDataResponse.hits??[]);
        }
      } catch (e) {
        print(e);
        showAlertDialog(title: "Alert",msg: e.toString());
      }
      refreshController.loadComplete();
    }else{
      showAlertDialog(title: "Alert",msg: "Enter text to search");
    }

  }

  showAlertDialog({String? title, String? msg}) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title!),
      content: Text(msg!),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
