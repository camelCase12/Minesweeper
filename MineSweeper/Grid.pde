class Grid {
  Cell[][] cells;
  int minec;
  
  void reveal(int x, int y) {
    if(cells[x][y].type == 9) {
     //lose message
     lose();
    }
    else {
     cells[x][y].revealed = true; 
    }
    int revealCount = 0;
    for(int i = 0; i < cells[0].length; i++) {
     for(int j = 0; j < cells[1].length; j++) {
      if(cells[i][j].revealed) {
        revealCount++;
      }
     }
    }
    if(revealCount == (((cells[0].length) * (cells[1].length)) - minec)) {
     win();
    }
  }
  void toggleFlag(int x, int y) {
   cells[x][y].flagged = !cells[x][y].flagged;
  }
  void render() {
   for(int i = 0; i < cells[0].length; i++) {
    for(int j = 0; j < cells[1].length; j++) {
      if(cells[i][j].flagged) {
        stroke(0);
        fill(80, 80, 200);
        rect(i * (width / cells[0].length) + 2, j * (width / cells[1].length) + 2, (width / cells[0].length) - 4, (width / cells[1].length) - 4);
      }
      else if(!cells[i][j].revealed) {
        stroke(0);
        fill(186);
        rect(i * (width / cells[0].length), j * (width / cells[1].length), (width / cells[0].length), (width / cells[1].length));
      }
      else {
      switch(cells[i][j].type) {
       case 0: 
         stroke(0);
         fill(128);
         rect(i * (width / cells[0].length), j * (width / cells[1].length), (width / cells[0].length), (width / cells[1].length));
         break;
       case 9:
         stroke(0);
         fill(200, 80, 80);
         rect(i * (width / cells[0].length) + 2, j * (width / cells[1].length) + 2, (width / cells[0].length) - 4, (width / cells[1].length) - 4);
         break;
       default:
         stroke(0);
         fill(128);
         rect(i * (width / cells[0].length), j * (width / cells[1].length), (width / cells[0].length), (width / cells[1].length));
         fill(255);
         text(str(cells[i][j].type), i * (width / cells[0].length) + (width / cells[0].length) / 2 - 9, (j + 1) * (width / cells[1].length) - (width / cells[0].length) / 2 + 10);
       }
      }
    }
   }
  }
  void intersperseMines(int mineCount) {// mineCount < gridWidth * gridHeight
    minec = mineCount;
    int minesPlaced = 0;
    while(minesPlaced < mineCount) {
      int rand1 = int(random(0, cells[0].length));
      int rand2 = int(random(0, cells[1].length));
      if(cells[rand1][rand2].type != 9) {
        cells[rand1][rand2].type = 9;
         minesPlaced++;
      }
    }
    placeNumbers();
  }
  void placeNumbers() { // called after mine interspersal
    for(int i = 0; i < cells[0].length; i++) {
     for(int j = 0; j < cells[1].length; j++) {
       if(cells[i][j].type != 9) {
       int mineCount = 0;
       for(int k = -1; k < 2; k++) {
         for(int l = -1; l < 2; l++) {
           try{
           if(((i + k != 0) || (j + l != 0)) && cells[i + k][j + l].type == 9) {
              mineCount++; 
           }
           }
           catch (IndexOutOfBoundsException e){
             
           }
         }
       }
       cells[i][j].type = mineCount;
     }
     }
    }
  }
  Grid(int gridWidth, int gridHeight) {
   cells = new Cell[gridWidth][gridHeight];
   for(int i = 0; i < cells[0].length; i++) {
     for(int j = 0; j < cells[1].length; j++) {
       cells[i][j] = new Cell(i, j);
     }
   }
  }
  Grid() {}
}
