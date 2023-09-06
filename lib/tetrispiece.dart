import 'package:flutter/material.dart';
import 'package:tetris/gameboard.dart';
import 'package:tetris/piece.dart';

class Piece{
  // type of piece
  TetrisPiece type;
  Piece({required this.type});
  // its just a list of integers

  List<int> position=[];


  Color get color{
    return tetriscolor[type] ?? 
    const Color(0xFFFFFFFF);
  }

  void initialisePiece(){
    switch (type) {
      case TetrisPiece.L:
      position=[-26,-16,-6,-5];
        
        break;

      case TetrisPiece.J:
      position=[-25,-15,-5,-6];
        
        break;
      case TetrisPiece.I:
      position=[-4,-5,-6,-7];
        
        break;

      case TetrisPiece.O:
      position=[-15,-16,-5,-6];

        break;
        case TetrisPiece.S:
      position=[-15,-14,-6,-5];
        
        break;
        case TetrisPiece.Z:
      position=[-17,-16,-6,-5];
        
        break;
        case TetrisPiece.T:
      position=[-26,-16,-6,-15];
        
        break;
      default:
    }
  }

  // move piece
  void movePiece(Direction direction){
        switch (direction) {
          case Direction.down:
              for(int i=0;i<position.length;i++){
                position[i]+=row;
              }
            
            break;

           case Direction.left:
              for(int i=0;i<position.length;i++){
                position[i]-=1;
              }
            
            break;

            case Direction.right:
              for(int i=0;i<position.length;i++){
                position[i]+=1;
              }
            
            break; 
          


          default:
        }
  }


// rotate
int rotationState=1;
void rotatePiece(){

  //new position

  List<int> newPosition=[];
  // rotate based on type
    switch (type) {
      case TetrisPiece.L:
          switch(rotationState){
            case 0:

            newPosition=[
                position[1]-row,
                position[1],
                position[1]+row,
                position[1]+row+1,
            ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
            break;

            case 1:

            newPosition=[
                position[1]-1,
                position[1],
                position[1]+1,
                position[1]+row-1,
            ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
          break;

          case 2:
          newPosition=[
              position[1]+row,
              position[1],
              position[1]-row,
              position[1]-1-row,
          ];
          if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
          break;
          

          case 3:
          newPosition=[
            position[1]-row+1,
            position[1],
            position[1]+1,
            position[1]-1
          ];
         if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
          break;
          }
        
        break;
     


      case TetrisPiece.J :
        switch(rotationState){
          case 0:
          newPosition=[
            position[1]-row,
            position[1],
            position[1]+row,
            position[1]+row-1,
          ];
          if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 1:
           newPosition=[
               position[1]-row-1,
            position[1],
            position[1]-1,
            position[1]+1,
           ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;
           
           case 2:
           newPosition=[
           position[1]+row,
           position[1],
           position[1]-row,
           position[1]-row+1,

           ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 3:
           newPosition=[
              position[1]+1,
              position[1],
              position[1]-1,
              position[1]+row-1,
           ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;
        }

        case TetrisPiece.I:
            switch(rotationState){
              case 0:
                newPosition=[
                  position[1]-1,
                  position[1],
                  position[1]+1,
                  position[1]+2
                ];
                 if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

              case 1:
                newPosition=[
                  position[1]-row,
                  position[1],
                  position[1]+row,
                  position[1]+2*row,
                ];
                 if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 2:
            newPosition=[
                position[1]+1,
                position[1],
                position[1]-1,
                position[1]-2,
            ];
             if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 3:
           newPosition=[
            position[1]+row,
            position[1],
            position[1]-row,
            position[1]-2*row
           ];
           if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

            }

            case TetrisPiece.O:
            break;
            case TetrisPiece.S:
              switch(rotationState){
                case 0:
                  newPosition=[
                    position[1],
                    position[1]+1,
                    position[1]+row-1,
                    position[1]+row
                  ];
                  if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 1:
              newPosition =[
               position[0]-row,
                position[0],
                position[0]+1,
                position[0]+row+1,
              ];
              if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 2:
              newPosition=[
                  position[1],
                  position[1]+1,
                  position[1]+row-1,
                  position[1]+row,
              ];
              if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;
              
            case 3:
              newPosition=[
                position[0]-row,
                position[0],
                position[0]+1,
                position[1]+row+1,
              ];
              if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;
              
              }
              case TetrisPiece.Z:
                  switch(rotationState){

                      case 0:
                        newPosition=[
                          position[0]+row-2,
                          position[1],
                          position[2]+row-1,
                          position[3]+1,
                        ];
                        if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

              case 1:
                  newPosition=[
                    position[0]-row+2,
                          position[1],
                          position[2]-row+1,
                          position[3]-1,
                  ];
                     if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 2:
              newPosition=[
                    position[0]+row-2,
                          position[1],
                          position[2]+row-1,
                          position[3]-1,
              ];
               if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

           case 3:

                  newPosition=[
                     position[0]-row+2,
                          position[1],
                          position[2]-row+1,
                          position[3]-1,
                  ];
                  if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;


                  }

            case TetrisPiece.T :
                switch(rotationState){
                    case 0:
                      newPosition=[
                        position[2]-row,
                        position[2],
                        position[2]+1,
                        position[2]+row,
                      ];
                       if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

                    case 1:
                      newPosition=[
                        position[1]-1,
                        position[1],
                        position[1]+1,
                        position[1]+row,
                      ];
                       if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

                    case 2:
                      newPosition=[
                        position[1]-row,
                        position[1]-1,
                        position[1],
                        position[1]+row,
                      ];
                       if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;

                    case 3:
                         newPosition=[
                        position[2]-row,
                        position[2]-1,
                        position[2],
                        position[2]+1,
                      ];
                       if(ispiecePositionValid(newPosition)){
            //update position
             position=newPosition;
            //update rotation state
            rotationState=(rotationState+1)%4;
           }
           break;



                }
    }

}


// check if valid position
bool ispositionValid(int position){
  // get row amd col of position
  int row1=(position/row).floor();
  int col=position%row;

    if(row1<0 || col<0 || gameBoard[row1][col]!=null){
      return false;
    }
    return true;

}

//check if piece is in valid position
bool ispiecePositionValid(List<int> piecePosition){
  bool firstColOccupied=false;
  bool lastColOccupied=false;
  for(int pos in piecePosition){
    if(!ispositionValid(pos)){
      return false;
    }
    int col=pos%row;

    if(col==0){
      firstColOccupied=true;
    }
    if(col==row-1){
      lastColOccupied=true;
    }
  }

  return !(firstColOccupied && lastColOccupied);
}

}