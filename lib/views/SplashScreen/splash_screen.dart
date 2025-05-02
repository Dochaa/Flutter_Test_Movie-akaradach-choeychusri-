import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testflutter/color.dart';
import 'package:testflutter/views/Movielistview/movie_list_view.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => MovieListView());
    });

    return Scaffold(
      backgroundColor: primarybackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/live_tv_black_24dp.png', 
              width: 80,
              height: 80,
              color:
                  primaryBlue, 
            ),
            SizedBox(height: 16),
            Text('CINEMAX', style: TextStyle(color: primaryBlue, fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
