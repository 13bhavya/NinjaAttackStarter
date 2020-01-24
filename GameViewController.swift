import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  var currentScene: SKScene?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    SetScene(sceneName: "GameScene")
//    let scene = GameScene(size: view.bounds.size)
//    let skView = view as! SKView
//    skView.showsFPS = true
//    skView.showsNodeCount = true
//    skView.ignoresSiblingOrder = true
//    scene.scaleMode = .resizeFill
//    skView.presentScene(scene)

  }
  
  func SetScene(sceneName: String)
  {
    if let view = self.view as! SKView?
    {
      //Load SKscene from GameScene.sks
      currentScene = SKScene(fileNamed: sceneName)
      
      view.showsFPS = true
      view.showsNodeCount = true
      currentScene?.scaleMode = .aspectFill
      view.presentScene(currentScene)
    }
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
  
}
