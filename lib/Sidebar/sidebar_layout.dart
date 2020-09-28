import 'package:binge_watch/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Pages/HomePage.dart';
import 'package:flutter/material.dart';

import 'Sidebar.dart';

class SidebarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<NavigationBloc>(
          create: (context)=>NavigationBloc(),
          child: Stack(
            children: <Widget>[
              BlocBuilder<NavigationBloc,NavigationStates>(
                builder: (context,navigationStates){
                  return navigationStates as Widget;
                },
              ),
              Sidebar(),
            ],
          ),
        ),
    );
  }
}
