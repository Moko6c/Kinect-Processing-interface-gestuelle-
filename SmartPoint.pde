class SmartPoint {
  
  PVector location;
  
  int maxValue;
  int closestValue;
  
  PVector currentLocation;
  PVector lastLocation;
  PImage hand;
  
  SmartPoint(){
    
    location = new PVector();
    
    maxValue = 1000;
    lastLocation = new PVector ();
    currentLocation = new PVector();
    hand = loadImage("Hand.png");
  }

  void update(){
    closestValue = maxValue;
    int[] depthValues = context.depthMap();
    int mapWidth = context.depthWidth();
    int mapHeight = context.depthHeight();
    
    for (int y=0; y<mapHeight; y++){
      for(int x=0; x<mapWidth; x++){
        
        int i = x + y * mapWidth;
        int currentDepthValue = depthValues[i];
        
        if ( currentDepthValue > 0 && currentDepthValue < closestValue){
          closestValue = currentDepthValue;
          
          currentLocation.x = x;
          currentLocation.y = y;
        }
      }
    }
    lastLocation.x = (lastLocation.x + currentLocation.x)/2;
    lastLocation.y = (lastLocation.y + currentLocation.y)/2;
  }
  boolean hitTarget (Btn btn){
    if (lastLocation.x > btn.location.x && lastLocation.x < btn.location.x + btn.mWidth
    && lastLocation.y > btn.location.y && lastLocation.y < btn.location.y + btn.mHeight){
    return true;
    }
    else {
    return false;
    }
  }
  void display(){
    
    image(hand, lastLocation.x, lastLocation.y, 80, 80);
  }
  
  void manipSon(){
    float halfWidth = width / 2.0;
    
    gainValue.setValue((float)lastLocation.y / (float)height);
    rateValue.setValue(((float)lastLocation.x - halfWidth)/ halfWidth);
  } 
}
