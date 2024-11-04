
import 'dart:convert';

import 'package:fitnesstest/detail_screen.dart';
import 'package:fitnesstest/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}
ExerciseModel? exerciseModel;
List<ExerciseModel> fitnessList=[];

class _FitnessPageState extends State<FitnessPage> {
fetchfitnessData()async{
  var response = await http.get(Uri.parse(fitnessUrl));
  var data = jsonDecode(response.body);
  //print("My data is ${data}");
  for(var i in data["exercises"]){
   // print(i);
    exerciseModel = ExerciseModel(
      id: i ["id"],
      title: i ["title"],
      thumbnail: i["thumbnail"],
      gif: i["gif"],

    );
    fitnessList.add(exerciseModel!);
   // print("===================");
    //print("My List Is $fitnessList");
  }
}
  var fitnessUrl =
  'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json';
@override
  void initState() {
  fetchfitnessData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body: ListView.builder(
    itemCount: fitnessList.length,
    itemBuilder: (context, index){

  return InkWell(
    onTap: (){

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
      DetailScreen(exerciseModel: fitnessList[index],))

      );
    },
    child: Container(

      child: ClipRRect(
        child: Stack(
          children: [

            Image.network("${fitnessList[index].thumbnail}",
              //fit: BoxFit.cover,

            ),
            Positioned(
                right: 20,
                child: Text("${fitnessList[index].title}", style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    ),
  );
})
    );
  }
}
