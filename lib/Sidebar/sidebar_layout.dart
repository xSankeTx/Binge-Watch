import '../Pages/HomePage.dart';
import 'package:flutter/material.dart';

import 'Sidebar.dart';

class SidebarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            HomePage(),
            Sidebar(),
          ],
        ),
    );
  }
}
