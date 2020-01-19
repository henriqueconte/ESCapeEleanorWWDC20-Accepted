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
        
        print("game view not created")
        let gameView = SKView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        print("game view created")
        gameView.autoresizingMask = [.width, .height]
        print("autoresizing mask")
        
        //print("game view frame")

        return gameView
    }()
//
    var scene: GameScene?
//
    override public func viewDidLoad() {
        super.viewDidLoad()

        print("View did load game view controller")
    }
//
    override public func loadView() {
        view = MyView(frame: .init(origin: .zero, size: .init(width: 100, height: 100)))//SKView(frame: NSRect(x: 0, y: 0, width: 50, height: 50))//skView//NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 30))
        
        let skview = self.skView
        
//        skview.frame = view.bounds
        
        
        view.addSubview(skview)
        
        
//        view.addSubview(skView)
        print("Load view game view controller")
//        print(view.frame)
    }

    override public func viewDidLayout() {
        super.viewDidLayout()

//        skView.frame = view.bounds

        print("view did layout game view controller")
    }

    override public func viewDidAppear() {
        print("view did appear game view controller")
        if skView.scene == nil {
            print("skview scene is nil")
            scene = GameScene(size: skView.frame.size)
            skView.presentScene(scene!)
        }
    }
}


