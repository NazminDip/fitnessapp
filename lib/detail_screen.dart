import 'package:fitnesstest/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  ExerciseModel? exerciseModel;
 DetailScreen({super.key, required this.exerciseModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        child: Image.network("${widget.exerciseModel!.gif}",


        width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      ),
    )
    ;
  }
}
