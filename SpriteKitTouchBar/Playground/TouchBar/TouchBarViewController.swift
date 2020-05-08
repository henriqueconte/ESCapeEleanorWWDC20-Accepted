import AppKit
import Cocoa
import SpriteKit

class MyView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // #1d161d
        NSColor(red: 0x0/255, green: 0x0/255, blue: 0xFF/255, alpha: 1).setFill()

        dirtyRect.fill()
    }

}

public class TouchBarViewController: NSViewController{

    lazy var skView: SKView = {

        let gameView = SKView(frame: self.view.bounds)
        gameView.autoresizingMask = [.width, .height]

        return gameView
    }()

    var scene: TouchBarScene?
    //var macScene: MacScene?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        view = NSView()
        view.addSubview(skView)
    }

    override public func viewDidAppear() {
        if skView.scene == nil {

            scene = TouchBarScene(fileNamed: "TouchBarScene")!
            //scene?.macScene = macScene
            
            skView.presentScene(scene)
        }
    }
}


