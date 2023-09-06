import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/tetrispiece.dart';

/*
Game board
2*2 grid
null = empty place

non empty space will have color to represent the landed pieces.

*/
// create game board
List<List<TetrisPiece?>> gameBoard = List.generate(column,
 (i) => List.generate(
    row,
    (j)=>null,
 ),
 );



class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
 
  // current tetris piece
  Piece currentPiece= Piece(type: TetrisPiece.O);
  int score=0;
  bool gameover=false;

  @override
  void initState() {
    super.initState();
    startGame();
    
  }
  void startGame(){
    currentPiece.initialisePiece();

    //frame refresh rate
    Duration frameRate= const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }
  // gameloop

  void gameLoop(Duration frameRate){
    // timer will execeute its code after every framerate secs.
        Timer.periodic(frameRate
        , (timer) {
            setState(() {

              // clear lines
              clearLines();

              //check landing
              checkLanding();

              // check game over
              if(gameover==true){
                timer.cancel();
                showGameOverDialog();
              }

              //move down
              currentPiece.movePiece(Direction.down);
            });
         });
  }

  // game over message

    void showGameOverDialog(){
      showDialog(context: context, builder:(context)=>AlertDialog(
          title: const Text('GAME OVER !!'),
          content: Text('Your score is $score'),
          actions: [
                TextButton(onPressed: (){
                  resetGame();
                  Navigator.pop(context);
                }, child: const Text('Play Again'))
          ],

      ));
    }
    // reset game method

      void resetGame(){
        // clear the game board
        gameBoard=List.generate(column,
 (i) => List.generate(
    row,
    (j)=>null,
 ),
 );

 // NEW GAME 
 gameover=false;
 score=0;
 // craet new piece
 createNewPiece();
 startGame();
      }

  // collision detetction in the future
  //true=>collision
  //false=> no collision

  bool checkCollision(Direction direction){
    //loop thru each pos
    for(int i=0;i<currentPiece.position.length;i++){
      // calculate row and column of current
      int row1=(currentPiece.position[i] / row ).floor();
      int col=(currentPiece.position[i] % row);
      // adjust row and column
    if(direction==Direction.left){
      col-=1;
    }
    else if(direction==Direction.right){
        col+=1;
    }
    else if(direction==Direction.down){
      row1+=1;
    }
    // check if piece is out of bounds
    if(row1>=column || col<0 || col>=row){
      return true;
    }
  else if(col>0 && row1>0 && gameBoard[row1][col]!=null){
    return true;
  }
    // if no collisions


    }
    return false;
  }
  void checkLanding(){
    // if going down is occupied
    if(checkCollision(Direction.down)){
      for(int i=0;i<currentPiece.position.length;i++){
        int row1=(currentPiece.position[i]/row).floor();
        int col=currentPiece.position[i]%row;
        if(row1>=0 && col >=0){
              gameBoard[row1][col]=currentPiece.type;
        }
      }
      //once landed create new piece
      createNewPiece();
    }
  }
  void createNewPiece(){
      // create a random object to generate tetrispieces
      Random random=Random();
      TetrisPiece randomtype =TetrisPiece.values[random.nextInt(TetrisPiece.values.length)];
       currentPiece=Piece(type: randomtype);
       currentPiece.initialisePiece();

       // check if game over when new piece is created
       if(gameOver()){
          gameover=true;
       }
  
  }


  //move left
  void moveLeft(){
    // MAKING SURE THE MOVE IS VALID before moving

    if(!checkCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //move right
  void moveRight(){

    // MAKING SURE THE MOVE IS VALID before moving

    if(!checkCollision(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }

  }
  // rotate piece

  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }
  // clear line
    void clearLines(){
      //1.loops thrpugh each row of the board
      for(int row1=column-1;row>=0;row--){
        // 2. a variable to see if row is full
        bool rowIsFull=true;
        //3. see if it full
        for(int col=0;col<row;col++){
            if(gameBoard[row1][col]==null){
              rowIsFull=false;
              break;
            }
        }
        // if row is full clesr the row and shift them down
        if(rowIsFull){
        
              // 5 move all rows above the cleared row down by one position
              for(int r=row1;r>0;r--){
                // 6 copy above row to current row
                gameBoard[r]=List.from(gameBoard[r-1]);
              }

              // 7 empty thr top row
              gameBoard[0]=List.generate(row1, (index) => null);

              // increase the score
                score++;
        }
      }
    }

    // Game over 
    bool gameOver(){
        for(int col=0;col<row;col++){
          if(gameBoard[0][col] != null){
            return true;
          }
        }
        return false;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: row*column,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:row), 
              itemBuilder:(context,index) {
          
                // get row and col for each index
              int row1=(index/row).floor();
              int col=index%row;
          
                //current pieces
                    if(currentPiece.position.contains(index)){
                      return Pixel(color: Colors.yellow,);
                    }
          
                    // landed piece
                    else if(gameBoard[row1][col]!= null){
                      final TetrisPiece? tetristype=gameBoard[row1][col];
                      return Pixel(color: tetriscolor[tetristype]);
                    }
                    
                  
                    else{
                      // blank pixel
                      return Pixel(color: Colors.grey[900]);
                    }
                
              },),
          ),
          // SCORE
            Text('Score :$score',style: const TextStyle(color: Colors.white),),
          // Game controls//
            Padding(
              padding: const EdgeInsets.only(bottom: 50,top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left
                  IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                     icon:const Icon(Icons.arrow_back)
                     ),
            
                  // rotate
                  IconButton(
                    onPressed: rotatePiece, 
                      color: Colors.white,
                    icon:const Icon(Icons.rotate_right)
                    ),
            
                  //left
                  IconButton(
                    onPressed: moveRight, 
                      color: Colors.white,
                    icon: const Icon(Icons.arrow_forward)),
            
                ],
            
              ),
            )
        ],
      ),

    );
    
  }
}