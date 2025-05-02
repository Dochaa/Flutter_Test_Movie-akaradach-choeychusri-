import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testflutter/color.dart';
import 'package:testflutter/controllers/movie_controller.dart';
import 'package:testflutter/views/Moviedetailview/movie_detail_view.dart';
// import 'package:testflutter/views/Moviedetailview/movie_detail_view.dart';
import 'package:testflutter/views/Player/videoPlayerPage.dart';

class MovieListView extends StatelessWidget {
  final MovieController controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarybackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) => controller.searchText.value = val,
                      style: TextStyle(color:primaryWhite),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: primaryGrey),
                        prefixIcon: Icon(Icons.search, color: primaryGrey),
                        filled: true,
                        fillColor: primaryDarkGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () => controller.searchText.value = '',
                    child: Text('Cancel', style: TextStyle(color: primaryWhite)),
                  ),
                ],
              ),
            ),
            Obx(() => controller.isLoading.value
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = controller.filteredMovies[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: GestureDetector(
                            onTap: () => Get.to(() => MovieDetailView(movie: movie)),
                            // onTap: () => Get.to(() => VideoPlayerPage(videoUrls: movie.video,title: movie.title,)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    movie.poster,
                                    width: 112,
                                    height: 147,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: primaryBlue,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text('Free', style: TextStyle(color: primaryWhite)),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: primaryWhite, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, color: primaryGrey, size: 16),
                                          SizedBox(width: 4),
                                          Text('${movie.year}', style: TextStyle(color: primaryGrey, fontSize: 12)),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.timer, color: primaryGrey, size: 16),
                                          SizedBox(width: 4),
                                          Text(movie.movieDuration, style: TextStyle(color: primaryGrey, fontSize: 12)),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
