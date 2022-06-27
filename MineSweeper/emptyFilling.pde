class searchArrow {
  int x;
  int y;
  Boolean alive = true;
  int dir; // 0-3, 0 right 1 down 2 left 3 up 4 all
  
  searchArrow(int x, int y, int dir) {
   this.x = x;
   this.y = y;
   this.dir = dir;
  }
  searchArrow() {}
}

searchArrow[] resizeSearch(searchArrow[] arrows, Boolean expand, int newLength) {
 searchArrow[] newA = new searchArrow[newLength];
 if(expand) {
  for(int i = 0; i < arrows.length; i++) {
   newA[i] = arrows[i]; 
  }
 }
 else {
  for(int i = 0; i < newLength; i++) {
   newA[i] = arrows[i]; 
  }
 }
 return newA;
}

Boolean checkEmpty(int x, int y, Cell[][] c, searchArrow[] arrows) {
  for(int i = 0; i < arrows.length; i++) {
   if(arrows[i].x == x && arrows[i].y == y) {
    return false; 
   }
  }
 try {
  if(c[x][y].type == 0) { return true; }
  else { return false; }
 }
 catch (IndexOutOfBoundsException e) { return false; }
}

void fillEmpty(Cell[][] c, int x, int y) { // where x, y empty cell currently being revealed
 int prevFilledIn = 0;
 int curFilledIn = 1;
 searchArrow[] arrows = new searchArrow[1];
 arrows[0] = new searchArrow(x, y, 4);
 while(prevFilledIn < curFilledIn) {
   prevFilledIn = curFilledIn;
   int searchLength = arrows.length;
   for(int i = 0; i < searchLength; i++) {
     if(arrows[i].alive) {
       arrows[i].alive = false;
          if(checkEmpty(arrows[i].x + 1, arrows[i].y, c, arrows)) {
            arrows = resizeSearch(arrows, true, arrows.length + 1);
            arrows[arrows.length - 1] = new searchArrow(arrows[i].x + 1, arrows[i].y, 3);
            curFilledIn++;
          }
          if(checkEmpty(arrows[i].x, arrows[i].y - 1, c, arrows)) {
            arrows = resizeSearch(arrows, true, arrows.length + 1);
            arrows[arrows.length - 1] = new searchArrow(arrows[i].x, arrows[i].y - 1, 2);
            curFilledIn++;
          }
          if(checkEmpty(arrows[i].x - 1, arrows[i].y, c, arrows)) {
            arrows = resizeSearch(arrows, true, arrows.length + 1);
            arrows[arrows.length - 1] = new searchArrow(arrows[i].x - 1, arrows[i].y, 1);
            curFilledIn++;
          }
          if(checkEmpty(arrows[i].x, arrows[i].y + 1, c, arrows)) {
            arrows = resizeSearch(arrows, true, arrows.length + 1);
            arrows[arrows.length - 1] = new searchArrow(arrows[i].x, arrows[i].y + 1, 0);
            curFilledIn++;
          }
     }
   }
 }//endwhile
 for(int i = 0; i < arrows.length; i++) {
  for(int j = -1; j < 2; j++) {
    for(int k = -1; k < 2; k++) {
     try {
       if(c[arrows[i].x + j][arrows[i].y + k].type > 0) {
         g.reveal(arrows[i].x + j, arrows[i].y + k);
       }
     }
     catch (IndexOutOfBoundsException e) {
       
     }
    }
  }
 }
 for(int i = 0; i < arrows.length; i++) {
  g.reveal(arrows[i].x, arrows[i].y); 
 }
 
}
