import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/Control/Snake.dart';
import 'package:snake/Control/MapControl.dart';
import 'Boundary/MapGame.dart';

void main() {

  // Step 2
  WidgetsFlutterBinding.ensureInitialized();

  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MaterialApp(home:const MyApp())));

  
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Snake snake=new Snake();
  MapControl map=new MapControl();
  Timer ?timer;

  //direct Snake is running
  @override
  void initState(){
    super.initState();
    gamePlay();

  }
  Widget build(BuildContext context) {
    double widthofScreen = MediaQuery. of(context). size. width ;
    double heightofScreen = MediaQuery. of(context). size. height;
    return SafeArea(
        child:Scaffold(
          appBar:AppBar(title: Text(widthofScreen.toString()+"  "+heightofScreen.toString()),),
          body:Stack(
          children: [

            Container(
              width: double.maxFinite,
              height: double.maxFinite,

            ),

            MapGame(widthofScreen: widthofScreen,heightofScreen:heightofScreen,map:map,snake: snake),
          ],
        )
    ));

  }


  void gamePlay(){
    timer= Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        if(snake.isPaused==false) {

          snake.reLoadApple();
          snake.move(snake.control);
          if(snake.checkCollision()){
            snake.isEnd=true;
            snake.isPaused=true;
            timer.cancel();
            if (snake.isEnd == true) {
              timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
                setState(() {
                  int count = 0;
                  for (int i = 0; i < snake.list.length; i++) {
                    if (count == 0) {
                      snake.list[i].color = "red";
                    }
                    else if (count == 1) {
                      snake.list[i].color = "green";
                    }
                    else
                      snake.list[i].color = "yellow";
                  }
                  if (count == 2)
                    count = 0;
                  else
                    count++;
                });
              });
            }
          }
          snake.reLoadApple();
        }

      });
    });

  }
}


