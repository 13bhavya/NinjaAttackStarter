import SpriteKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
  }
#endif


class Player: GameObject {
  
  // constructor
  init()
  {
      super.init(imageString: "player", initialScale: 2.0)
      Start()
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func CheckBounds() {
     //right boundary
    
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
