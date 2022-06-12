// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:setstate/title.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import 'fullscreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001a7ba7ceef93f417c8c06f881c187a22c'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      // ignore: avoid_print
      print(images[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001a7ba7ceef93f417c8c06f881c187a22c'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: newText(),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
              ),

              Expanded(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Fullscreen(
imageurl: images[index]['src']['large2x'],                             )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              )),
              InkWell(
                onTap: () {
                  loadmore();
                },
                child: const SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Load more",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )),
                ),
              )

              // padding: EdgeInsets.all(10),

              // child: Row(
              //   children: const [
              //     Expanded(
              //       child: TextField(

              //         decoration: InputDecoration(hintText: "    search wallpapers",border: InputBorder.none,),
              //       ),
              //     ),
              //     Icon(Icons.search)
              //   ],
              // ),
            ],
          ),
        ));
  }
}
