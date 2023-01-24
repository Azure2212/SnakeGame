import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:snake/Control/MapControl.dart';
import 'package:snake/main.dart';
import 'dart:async';
import '../Control/Snake.dart';

class MapGame extends StatefulWidget {
  const MapGame({
    Key? key,
    required this.widthofScreen, required this.heightofScreen, required this.map, required this.snake}) : super(key: key);

  final double widthofScreen;
  final MapControl map;
  final double heightofScreen;
  final Snake snake;


  @override
  State<MapGame> createState() => _MapGameState(widthofScreen,heightofScreen,map,snake);
}

class _MapGameState extends State<MapGame> {
   double widthofScreen=0;
   MapControl map=new MapControl();
   double heightofScreen=0;
   Snake snake=new Snake();
   String direct="right";
   Icon pauseGameIcon=Icon(Icons.pause);
   Timer? timer;
   _MapGameState(widthofScreen,heightofScreen,map,snake){
    this.widthofScreen=widthofScreen;
    this.heightofScreen=heightofScreen;
    this.map=map;
    this.snake=snake;
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthofScreen * 0.97,
      height: heightofScreen * 0.7,
      margin: EdgeInsets.only(top: 15, left: 15),
      color: Colors.white,
      child: Stack(
          children: [
            netGame(),
            controlBoard(),

          ]),
    );
  }

  Color getColorAt(int i, int j) {
     if(snake.apple.x==i && snake.apple.y==j)return Colors.red.shade900;
    for (int k = 0; k < snake.list.length; k++) {
      if (snake.list[k].x == i && snake.list[k].y == j && k == 0)
        return Colors.blueAccent.shade700;
      if (snake.list[k].x == i && snake.list[k].y == j)
        return Colors.blueAccent.shade400;
    }
    if (map.m[i][j].color.compareTo("green") == 0)
      return Colors.lightGreenAccent.shade700;
    if (map.m[i][j].color.compareTo("yellow") == 0)
      return Colors.lightGreenAccent.shade400;
    else
      return Colors.blueAccent.shade400;
  }

  Widget netGame() {
    return
      Container(
          child: Column(
            children: [
              for(int i = 0; i < map.m.length; i++)
                Row(
                  children: [
                    for(int j = 0; j < map.m[i].length; j++)
                      Container(
                        width: widthofScreen * 0.75 / 41,
                        height: heightofScreen * 0.7 / 21,
                        color: getColorAt(i, j),
                      )
                  ],
                )


            ],

          )
      );
  }

  Widget controlBoard() {

    return Container(
      width: widthofScreen * 0.18,
      height: heightofScreen * 0.7,

      margin: EdgeInsets.only(left: widthofScreen * 0.785),
      child: Container(
        child: Column(
          children: [
            Text(""),
            Container(
              child: Row(children: [// 2 button Pause and reload
                Container(// pause game button
                  width: 40,
                  height: 50,
                  margin: EdgeInsets.only(left: 12.5,top:15),
                  child: IconButton(
                      iconSize: 25,
                      icon:  pauseGameIcon,
                      onPressed: (){
                        setState(() {
                          if(snake.isPaused==false){
                            pauseGameIcon=Icon( Icons.last_page, );
                            snake.isPaused=true;

                          }else{
                            pauseGameIcon=Icon(Icons.pause);
                            snake.isPaused=false;
                          }
                        });}),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellowAccent,
                  ),
                ),
                Container(// reload game button
                  width: 40,
                  height: 50,
                  margin: EdgeInsets.only(left: 10,top:15),
                  child: IconButton(
                      iconSize: 25,
                      icon:  Icon( Icons.refresh),
                      onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              return MyApp();
                            })
                        );
                      }
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellowAccent,
                  ),

                ),
              ],),
            ),
            SizedBox(height:heightofScreen * 0.2,),
            Row(
              children: [
                SizedBox(width:widthofScreen * 0.18*0.3),
                Container(

                    width: (widthofScreen * 0.18)/2.5,
                    height:heightofScreen * 0.75*0.1,
                    child: IconButton(
                      iconSize: 20,
                      icon:  Icon( Icons.arrow_upward, ),
                      onPressed:(){ changeDirection("up");},
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent,
                    )
                ),
              ],
            ),
            SizedBox(height:heightofScreen * 0.0175,),
            Row(
              children: [
                SizedBox(width:widthofScreen * 0.18*0.075),
                Container(

                    width: (widthofScreen * 0.18)/2.5,
                    height:heightofScreen * 0.75*0.1,
                    child: IconButton(
                      iconSize: 20,
                      icon:  Icon( Icons.arrow_back, ),onPressed:(){changeDirection("left");},
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent,
                    )
                ),//goleft button
                SizedBox(width:widthofScreen * 0.18*0.075),
                Container(

                    width: (widthofScreen * 0.18)/2.5,
                    height:heightofScreen * 0.75*0.1,
                    child: IconButton(
                      iconSize: 20,
                      icon:  Icon( Icons.arrow_forward, ),onPressed:(){changeDirection("right");},
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent,
                    )
                ),//goright button



              ],
            ),
            SizedBox(height:heightofScreen * 0.0175,),
            Row(

              children: [
                SizedBox(width:widthofScreen * 0.18*0.3),
                Container(// godown button

                    width: (widthofScreen * 0.18)/2.5,
                    height:heightofScreen * 0.75*0.1,
                    child: IconButton(
                      iconSize: 20,
                      icon:  Icon( Icons.arrow_downward, ),onPressed:(){
                      changeDirection("down");
                    },
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent,
                    )
                ),//godown button
              ],
            ),

          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.redAccent,
      )
      ,
    );
  }

  void changeDirection(String direct) {
    if (snake.isPaused == true) return;
    if (snake.control.compareTo("right") == 0 &&
        direct.compareTo("left") == 0) {
      this.direct = "right";
      return;
    }
    if (snake.control.compareTo("left") == 0 &&
        direct.compareTo("right") == 0) {
      this.direct = "left";
      return;
    }
    if (snake.control.compareTo("up") == 0 && direct.compareTo("down") == 0) {
      this.direct = "up";
      return;
    }
    if (snake.control.compareTo("down") == 0 && direct.compareTo("up") == 0) {
      this.direct = "down";
      return;
    }
    setState(() {
      snake.control = direct;
      snake.move(direct);
      snake.reLoadApple();
      if (snake.checkCollision()) {
        snake.isEnd = true;
        snake.isPaused = true;
        if (snake.isEnd == true) {
          timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
            setState(() {
              int count = 0;
              for (int i = 1; i < snake.list.length; i++) {
                if (count == 0)
                  snake.list[i].color = "red";
                else if (count == 1)
                  snake.list[i].color = "green";
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
    });
  }
}


