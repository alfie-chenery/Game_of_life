int res = 10;
boolean[] current;
boolean[] next;
int w;
int h;
int n;

void setup(){
  size(1000,1000);
  w = width/res;
  h = height/res;
  n = w * h;
  current = new boolean[n];
  next = new boolean[n];
  stroke(200);
  fill(0);
  
  PImage initial = loadImage("generation_0.png");
  initial.loadPixels();
  for(int y=0; y<initial.height; y++){
    for(int x=0; x<initial.width; x++){
      int loc = x + y*initial.width;
      current[loc] = (initial.pixels[loc] == color(0,0,0));
    }
  }
}

void draw(){
  //display current
  background(255);
  frameRate(10);//make animations slower
  
  for(int y=0; y<h; y++){
    for(int x=0; x<w; x++){
      int loc = x + y*w;
      if(current[loc]){
        fill(0);
      }else{
        fill(255);
      }
      rect(x*res, y*res, res, res);
      
    }
  }
    
  
  //calculate next
  for (int i = 0; i < n; i++){
    if ((i < w)||(i > n-w)||(i % w==0)||(i % w == w-1)){
    //if (top edge) or (bottom edge) or (left edge) or (right edge)
      next[i] = false; // force edges of next to be dead
    }else{
      //if not edge count neighbours
      int neighbours = 0;
      if (current[i-(w+1)]){
        neighbours ++;
      }
      if (current[i-w]){
        neighbours ++;
      }
      if (current[i+1-w]){
        neighbours ++;
      }      
      if (current[i-1]){
        neighbours ++;
      }      
      //skip pixel[i] itself
      if (current[i+1]){
        neighbours ++;
      }      
      if (current[(i-1)+w]){
        neighbours ++;
      }      
      if (current[i+w]){
        neighbours ++;
      }      
      if (current[i+w+1]){
        neighbours ++;
      }      
      
      //update next based on neighbours
      if ((current[i])&&((neighbours < 2)||(neighbours > 3))){
        next[i] = false;
      }else if ((!current[i])&&(neighbours==3)){
        next[i] = true;
        
      }else{
        next[i] = current[i];
      }
    }
  }
  
  //copy array
  for(int i=0; i<n; i++){
    current[i] = next[i];
  }
  next = new boolean[n];
}
