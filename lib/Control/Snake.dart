



import 'dart:math';

import 'Point.dart';

 class Snake {
  List<Point>list=[];
  Point apple=new Point(0,0,"red");
  String control="right";//direct Snake is running
  bool isPaused=false;
  bool isEnd=false;
  //String director;
   Snake(){
     createApple();
    for(int i=13;i>10;i--){
      list.add(new Point(10,i,"blue"));
    }
  }
  /*  boolean checkTheSameLocalof1Local(int i,int j,int temp){
        if(list.get(temp).getX()==j && list.get(temp).getY()==i)return true;
        return false;*/


   int moveRight(){
    if(list[0].getY()+1==list[1].getY())return -1;
    for(int i=list.length-1;i>0;i--){

      list[i].setX(list[i-1].getX());
      list[i].setY(list[i-1].getY());

    }
    if( list[0].getY()==40)
      list[0].setY(0);
    else
      list[0].setY(list[0].getY()+1);


    if(checkCollision()==true)return 0;
    return 1;
  }
   int moveLeft(){
    if(list[0].getY()-1==list[1].getY())return -1;
    for(int i=list.length-1;i>0;i--){

      list[i].setX(list[i-1].getX());
      list[i].setY(list[i-1].getY());

    }
    if( list[0].getY()==0)
      list[0].setY(40);
    else
      list[0].setY(list[0].getY()-1);


    if(checkCollision()==true)return 0;
    return 1;
  }
   int moveDown(){
    if(list[0].getX()+1==list[1].getX())return -1;
    for(int i=list.length-1;i>0;i--){

      list[i].setX(list[i-1].getX());
      list[i].setY(list[i-1].getY());

    }
    if( list[0].getX()==20)
      list[0].setX(0);
    else
      list[0].setX(list[0].getX()+1);


    if(checkCollision()==true)return 0;
    return 1;
  }
   int moveUp(){
    if(list[0].getX()-1==list[1].getX())return -1;
    for(int i=list.length-1;i>0;i--){

      list[i].setX(list[i-1].getX());
      list[i].setY(list[i-1].getY());

    }
    if( list[0].getX()==0)
      list[0].setX(20);
    else
      list[0].setX(list[0].getX()-1);


    if(checkCollision()==true)return 0;
    return 1;
  }
   bool checkCollision(){
    for(int i=1;i<list.length;i++){
      if(list[0].getY()==list[i].getY() && list[0].getX()==list[i].getX() )return true;
    }
    return false;
  }
  int move(String direct){
    if(this.control.compareTo("left")==0)
      this.moveLeft();
    else if(this.control.compareTo("right")==0)
      this.moveRight();
    else if(this.control.compareTo("up")==0)
      this.moveUp();
    else if(this.control.compareTo("down")==0)
      this.moveDown();
    return 1;
  }
   void createApple(){
    //Random rd=new Random();
    flag:do {
      apple = new Point(Random().nextInt(21), Random().nextInt(41),"red");

      for(int i=0;i<list.length;i++) {
        if(apple.getX()==list[i].getX() && apple.getY()==list[i].getY()) continue flag;
      }
      break;

    }while(true);

  }
   void reLoadApple() {
    if (apple.getX() == list[0].getX() && apple.getY() == list[0].getY()) {

      createApple();
      int n = list.length;
      Point add;
      if (list[n-1].getX() == list[n-2].getX()) {  // same row
        if (list[n-1].getY() < list[n-2].getY()) {
          add = new Point(list[n-1].getX(), list[n-1].getY() - 1,"red");
        } else {
          add = new Point(list[n-1].getX(), list[n-1].getY() + 1,"red");
        }

      } else {// same columns
        if (list[n-1].getX() < list[n-2].getX()) {
          add = new Point(list[n-1].getX() - 1, list[n-1].getY(),"red");
        } else {
          add = new Point(list[n-1].getX() + 1, list[n-1].getY(),"red");
        }
      }
      list.add(add);


    }
  }





}
