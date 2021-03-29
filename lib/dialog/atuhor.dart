import 'package:flutter/cupertino.dart';

import 'auth.dart';
import 'register.dart';

class Author extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAuthor();
  }

}

class StateAuthor extends State<Author>{
  PageController pageController=PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        Reg(pageController),
        Aut(pageController)
      ],
    );

  }

}