Grid g = new Grid(10, 10);
Boolean won = false;
Boolean lose = false;

void setup() {
 size(501, 501);
 background(0);
 g.intersperseMines(11);
 textSize(30);
} 

void draw() {
 background(0);
 if(!won && !lose) {
 g.render();
 }
 else if(won) {
   textSize(50);
   text("You Won!", width / 2 - 100, height / 2);
   textSize(20);
   fill(0, 255, 0);
   text(str(millis() / 1000) + " seconds", width / 2 - 50, height / 2 + 100);
   noLoop();
 }
 else if (lose) {
   textSize(50);
   text("You Lost!", width / 2 - 110, height / 2);
   noLoop();
 }
}

void mousePressed() {
 if(mouseButton == LEFT) {
   if(g.cells[floor(mouseX / (width / g.cells[0].length))][floor(mouseY / (height / g.cells[1].length))].type == 0) {
     fillEmpty(g.cells, floor(mouseX / (width / g.cells[0].length)), floor(mouseY / (height / g.cells[1].length)));
   }
   else {
     g.reveal(floor(mouseX / (width / g.cells[0].length)), floor(mouseY / (height / g.cells[1].length)));
   }
 }
 else if (mouseButton == RIGHT) {
   g.toggleFlag(floor(mouseX / (width / g.cells[0].length)), floor(mouseY / (height / g.cells[1].length)));
 }
}
