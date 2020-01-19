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

public class GameViewController: NSViewController{

    lazy var skView: SKView = {
        
        
        let gameView = SKView(frame: NSRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

        gameView.autoresizingMask = [.width, .height]

        
        //print("game view frame")

        return gameView
    }()
//
    var scene: GameScene?
//
    override public func viewDidLoad() {
        super.viewDidLoad()

    }
//
    override public func loadView() {
        
        view = MyView(frame: .init(origin: .zero, size: .init(width: 1, height: 1)))//SKView(frame: NSRect(x: 0, y: 0, width: 50, height: 50))//skView//NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 30))
        
        let skview = self.skView
        
        skview.frame = view.bounds
        
        
        view.addSubview(skview)
        
    }

    override public func viewDidLayout() {
        super.viewDidLayout()

//        skView.frame = view.bounds

    }

    override public func viewDidAppear() {
        if skView.scene == nil {
            
            scene = GameScene(size: skView.frame.size)
            skView.presentScene(scene!)
        }
    }
}


