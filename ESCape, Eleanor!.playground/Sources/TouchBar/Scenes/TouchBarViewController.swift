import AppKit
import Cocoa
import SpriteKit

public class TouchBarViewController: NSViewController{

    lazy var skView: SKView = {

        let gameView = SKView(frame: self.view.bounds)
        gameView.autoresizingMask = [.width, .height]

        return gameView
    }()
    
    private lazy var unlockView: UnlockView = {
        let view = UnlockView(frame: self.view.bounds)
        view.autoresizingMask = [.width, .height]
        view.delegate = self
        view.isHidden = true
        
        return view
    }()

    var scene: TouchBarNewScene?
    var macScene: MacScene?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        view = NSView()
        
        view.addSubview(skView)
        view.addSubview(unlockView)
    }

    override public func viewDidAppear() {
        if skView.scene == nil {

            scene = TouchBarNewScene(fileNamed: "StartScene")!
            scene?.macScene = macScene
            scene?.caveDelegate = self
            
            skView.presentScene(scene)
        }
    }
}

extension TouchBarViewController: SlideToUnlock {
    func didFinishSliding() {
        scene?.macScene?.unlockBackground()
        scene?.playSound(fileNamed: "unlockSound.mp3")
    }
}

extension TouchBarViewController: EndCaveScene {
    func didFinishScene() {
        scene?.pauseBackgroundSound()
        unlockView.isHidden = false
    }
}


