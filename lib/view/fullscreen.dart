import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Fullscreen extends StatefulWidget {
  final String imageurl;

  const Fullscreen({Key? key, required this.imageurl}) : super(key: key);
  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    // ignore: unused_local_variable
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: Column(
        children: [
          Expanded(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Image.network(widget.imageurl),
            ),
          ),
          InkWell(
            onTap: () {
              setwallpaper();
            },
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              width: double.infinity,
              child: const Center(
                  child: Text(
                "set wallpaper",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              )),
            ),
          )
        ],
      )),
    );
  }
}
