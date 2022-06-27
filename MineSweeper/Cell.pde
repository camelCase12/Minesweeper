class Cell {
  int x;
  int y;
  Boolean revealed = false;
  Boolean flagged = false;
  int type; // 0 empty, 1-8 mines surrounding, 9 mine on
  
  void toggleFlag() {
   flagged = !flagged; 
  }
  Cell(int x, int y) {
   this.x = x;
   this.y = y;
  }
  Cell() {}
}
