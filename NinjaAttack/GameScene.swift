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

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

class GameScene: SKScene {
  
  let player = SKSpriteNode(imageNamed: "player")
  
  func TouchMove(newPos: CGPoint)
  {
      self.position = newPos
  }
  
  override func didMove(to view: SKView) {
    backgroundColor = SKColor.gray
    
    
    
    player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.1)
    
    addChild(player)
    
    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(addMonster),
        SKAction.wait(forDuration: 5.0)
        ])
    ))
  }
  
  func random() -> CGFloat {
    return CGFloat (Float(arc4random()) / 0xFFFFFFFF)
  }

  
  
  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func touchDown(atPoint pos : CGPoint)
  {
    //player.self.touchesMoved(<#T##touches: Set<UITouch>##Set<UITouch>#>, with: <#T##UIEvent?#>)
    
    player.position = CGPoint(x: size.width * 0.1, y: pos.y)
    //self.planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: -575))
  }
  
  func touchMoved(toPoint pos : CGPoint)
  {
    player.position = CGPoint(x: size.width * 0.1, y: pos.y)
    //self.planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: -575))
  }
  
  func touchUp(atPoint pos : CGPoint)
  {
    player.position = CGPoint(x: size.width * 0.1, y: pos.y)
    //self.planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: -575))
  }
  
  func addMonster() {
    
    // create sprite
    let monster = SKSpriteNode(imageNamed: "monster")
    
    // Determine y axis
    let actualY = random(min: monster.size.height , max: size.height - monster.size.height)
    
    monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
    
    addChild(monster)
    
    let actualDuration = random(min: CGFloat(5.0), max: CGFloat(6.0))
    
    // Create the actions
    let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
                                   duration: TimeInterval(actualDuration))
    
    let actionMoveDone = SKAction.removeFromParent()
    monster.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
  
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // 1 - Choose one of the touches to work with
    guard let touch = touches.first else {
      return
    }
    let touchLocation = touch.location(in: self)
    
    // 2 - Set up initial location of projectile
    let projectile = SKSpriteNode(imageNamed: "projectile")
    projectile.position = player.position
    
    // 3 - Determine offset of location to projectile
    let offset = touchLocation - projectile.position
    print("Touch location", touchLocation)
    print("player position", projectile.position)
    print("Offset", offset)
    
    // 4 - Bail out if you are shooting down or backwards
    if offset.x < 0 { return }
    
    // 5 - OK to add now - you've double checked position
    addChild(projectile)
    
    // 6 - Get the direction of where to shoot
    let direction = offset.normalized()
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    let shootAmount = direction * 1000
    
    // 8 - Add the shoot amount to the current position
    let realDest = shootAmount + projectile.position
    
    // 9 - Create the actions
    let actionMove = SKAction.move(to: realDest, duration: 2.0)
    let actionMoveDone = SKAction.removeFromParent()
    projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
}
