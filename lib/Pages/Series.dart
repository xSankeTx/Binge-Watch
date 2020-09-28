import 'package:binge_watch/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class Seriespage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Series", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28),),
    );
  }
}