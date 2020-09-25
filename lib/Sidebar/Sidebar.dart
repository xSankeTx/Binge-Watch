import 'dart:async';

import 'package:flutter/material.dart';
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
          left: isSidebarOpenAsync.data ? 0 : 0,
          right: isSidebarOpenAsync.data ? 0 : screenwidth-45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xff4E2DDE),
                ),
              ),
              Align(
                alignment: Alignment(0,-0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
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
              )
            ],
          ),
        );
      },
    );
  }
}
//color -> 0xff4E2DDE