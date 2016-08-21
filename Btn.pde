class Btn {

  PVector location;
  int mWidth, mHeight;
  color couleur;
  int alpha;
  int id;
  
  int speed;
  
  Btn (float _x, float _y, int _mWidth, int _mHeight, color _couleur, int _id, int _speed){
    
    location = new PVector(_x, _y);
    mWidth = _mWidth;
    mHeight = _mHeight;
    couleur = _couleur;
    alpha = 0;
    
    id = _id;
    speed = _speed;
  }
  
  void isHit(){
    if (alpha<255){
      alpha+= speed;
    } else if (alpha >= 255) {
      println("hit"+ random(1));
      //console.updateMessage(str(id));
      alpha = 0;
    }
  }
  
  void isNotHit(){
    if (alpha>1){
      alpha-= speed;
    }
  }
  
  void display(){
    stroke(0);
    fill(couleur, alpha);
    rect(location.x, location.y, mWidth, mHeight);
    line (0,70,640,70);
  }
  
  void update (){
  }
}
