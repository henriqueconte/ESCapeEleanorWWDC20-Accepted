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
        
        let gameView = SKView(frame: NSRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        return gameView
    }()

    var scene: TouchBarScene?
    var macScene: MacScene?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        
        view = MyView(frame: NSRect(x: 0, y: 0, width: 1, height: 1))
        
        let skview = self.skView

        view.addSubview(skview)
    }

    override public func viewDidLayout() {
        super.viewDidLayout()
    }

    override public func viewDidAppear() {
        if skView.scene == nil {
            
            scene = TouchBarScene(size: skView.frame.size)
            scene?.macScene = macScene
            
            skView.presentScene(scene!)
        }
    }
}


