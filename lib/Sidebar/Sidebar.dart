import 'dart:async';

import 'package:binge_watch/Sidebar/menu_item.dart';
import 'package:binge_watch/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin<Sidebar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenstreamController;
  Stream<bool> isSidebarOpenstream;
  StreamSink<bool> isSidebarOpensink;
  final animateduration=Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(vsync: this,duration: animateduration);
    isSidebarOpenstreamController=PublishSubject<bool>();
    isSidebarOpenstream=isSidebarOpenstreamController.stream;
    isSidebarOpensink=isSidebarOpenstreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenstreamController.close();
    isSidebarOpensink.close();
    super.dispose();
  }

  void onIconPressed(){
    final animationStatus=_animationController.status;
    final isAnimationCompleted=animationStatus==AnimationStatus.completed;

    if(isAnimationCompleted){
      isSidebarOpensink.add(false);
      _animationController.reverse();
    }
    else{
      isSidebarOpensink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth=MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenstream,
      builder: (context,isSidebarOpenAsync){
        return AnimatedPositioned(
          duration: animateduration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenAsync.data ? 0 : -screenwidth,
          right: isSidebarOpenAsync.data ? 0 : screenwidth-45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xff4E2DDE),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text("Sam Marlie",
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "sammarlie27@gmail.com",
                          style: TextStyle(color: Color(0xffA599DC), fontSize: 18),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Color(0xffA599DC),
                        indent: 20,
                        endIndent: 20,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomepageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.movie,
                        title: "Animes",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AnimeClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.live_tv,
                        title: "TV Series",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SeriesClickedEvent);
                        },
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Color(0xffA599DC),
                        indent: 20,
                        endIndent: 20,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0,-0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xff4E2DDE),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xffA599DC),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint=Paint();
    paint.color=Colors.white;

    final width=size.width;
    final height=size.height;

    Path path=Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
//color -> 0xff4E2DDE