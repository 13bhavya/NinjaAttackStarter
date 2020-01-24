import SpriteKit
import UIKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

class GameScene: SKScene {
  
  var playerSprite: Player?
  var monsterSprite: Monster?
  //let player = SKSpriteNode(imageNamed: "player")

  
  override func didMove(to view: SKView) {
    backgroundColor = SKColor.gray
    
    // add Player
    self.playerSprite = Player()
    self.playerSprite?.position = CGPoint(x: -585.646, y: -253.635)
    self.addChild(playerSprite!)
    
    // add Player
    self.monsterSprite = Monster()
    
    // Determine y axis
    let actualY = random(min: monsterSprite!.size.height , max: size.height - monsterSprite!.size.height)
    
    self.monsterSprite!.position = CGPoint(x: size.width + monsterSprite!.size.width/2, y: actualY)
    
    let actualDuration = random(min: CGFloat(5.0), max: CGFloat(6.0))
    
    self.addChild(monsterSprite!)
    
    // Create the actions
    let actionMove = SKAction.move(to: CGPoint(x: -monsterSprite!.size.width/2, y: actualY),
                                   duration: TimeInterval(actualDuration))
    
    let actionMoveDone = SKAction.removeFromParent()
    monsterSprite!.run(SKAction.sequence([actionMove, actionMoveDone]))
    
  }
  
  func random() -> CGFloat {
    return CGFloat (Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func touchDown(atPoint pos: CGPoint)
  {
    
    self.playerSprite!.TouchMove(newPos: CGPoint(x: -585.646 , y: pos.y))
  }
  
  func touchMoved(atPoint pos: CGPoint)
  {
    
    self.playerSprite!.TouchMove(newPos: CGPoint(x: -585.646 , y: pos.y))
  }
  
  func touchUp(atPoint pos: CGPoint)
  {
    
    self.playerSprite!.TouchMove(newPos: CGPoint(x: -585.646 , y: pos.y))
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
  {
    for t in touches { self.touchDown(atPoint: t.location(in: self))}
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
  {
      for t in touches { self.touchMoved(atPoint: t.location(in: self))}
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    for t in touches { self.touchDown(atPoint: t.location(in: self))}

    // 1 - Choose one of the touches to work with
    guard let touch = touches.first else {
      return
    }
    let touchLocation = touch.location(in: self)
    
    // 2 - Set up initial location of projectile
    let projectile = SKSpriteNode(imageNamed: "projectile")
    projectile.position = playerSprite!.position
    
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
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         for t in touches { self.touchUp(atPoint: t.location(in: self))}
     }
  
  override func update(_ currentTime: TimeInterval)
  {
    self.playerSprite?.Update()
  }
}
