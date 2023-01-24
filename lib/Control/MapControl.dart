import 'package:snake/Control/Point.dart';

class MapControl{
  List<List<Point>>m=[];

  MapControl(){
    m=List.generate(21, (i) => List.generate(41,(j)=>Point(0, 0,"")));



    for(int i=0;i<m.length;i++){
      for(int j=0;j<m[i].length;j++){
        m[i][j]=new Point(i, j,"");
        if(i%2==0){
          if(j%2==0) m[i][j].color="green";
          else m[i][j].color="yellow";
        }else{
          if(j%2==0) m[i][j].color="yellow";
          else m[i][j].color="green";
        }
      }
    }
  }
}