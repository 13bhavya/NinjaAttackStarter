import SpriteKit

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
  }
#endif

class Monster: GameObject {
  
  // constructor
  init()
  {
      super.init(imageString: "monster", initialScale: 2.0)
      Start()
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func CheckBounds() {
     //right boundary
//    if(self.position.x >= 307 - self.halfWidth!)
//    {
//        self.position.x = 307 - self.halfWidth!
//    }
//
//    // left boundary
//    if(self.position.x <= -307 + self.halfWidth!)
//    {
//        self.position.x = -307 + self.halfWidth!
//    }
  }
  
  func Move()
  {
    self.position.y -= self.dy!
    self.position.x -= self.dx!
  }
  
  override func Reset() {
    
  }
  
  override func Start() {
    
    self.zPosition = 2
  }
  
  override func Update() {
    self.CheckBounds()
  }
  
  func TouchMove(newPos: CGPoint)
  {
    self.position = newPos
  }
  
}
