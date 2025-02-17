import 'dart:convert';

import 'package:app_fitness/detail_screen.dart';
import 'package:app_fitness/model/fitness_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FitnessApp extends StatefulWidget {
  const FitnessApp({super.key});

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  FitnessModel? fm;
  List<FitnessModel> postList = [];

  var fitnessUrl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A;";

  getFitnessData() async {
    var res = await http.get(Uri.parse(fitnessUrl));
    var data = jsonDecode(res.body);

    for (Map i in data["exercises"]) {
      fm = FitnessModel(
        id: i['id'],
        title: i['title'],
        thumbnail: i['thumbnail'],
        gif: i['gif'],
      );
      postList.add(fm!);
    }
  }

  @override
  void initState() {
    getFitnessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailScreen(
                      fm: postList[index],
                    );
                  }));
                },
                child: Container(
                  child: ClipRRect(
                    child: Stack(
                      children: [
                        Image.network("${postList[index].thumbnail}"),
                        Positioned(
                            right: 20, child: Text("${postList[index].title}")),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
