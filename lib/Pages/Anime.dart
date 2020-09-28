import 'package:binge_watch/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class Animepage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Anime", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28),),
    );
  }
}