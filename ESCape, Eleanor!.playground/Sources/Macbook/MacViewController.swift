import AppKit
import Cocoa
import SpriteKit


open class MacViewController: NSViewController{
    
    var scene: MacScene?
    public var touchBarView: TouchBarViewController!
    
    lazy var skView: SKView = {
        let gameView = SKView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        
        return gameView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        view = skView
    }
    
    override public func viewDidLayout() {
        super.viewDidLayout()
    }
    
    override public func viewDidAppear() {
        if skView.scene == nil {
            scene = MacScene(size: skView.frame.size)
            skView.presentScene(scene)
        }
        
    }
}

extension MacViewController: NSTouchBarDelegate {

    // Instantiates the touch bar that will be presented
    override public func makeTouchBar() -> NSTouchBar? {
        
        let bar = NSTouchBar()

        bar.delegate = self
        bar.defaultItemIdentifiers = [.touchBarView]

        return bar
        
    }

    // Instantiates the elements that will be presented on the touch bar
    public func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {

        switch identifier {
        case NSTouchBarItem.Identifier.touchBarView:
            let item = NSCustomTouchBarItem(identifier: .touchBarView)

            if touchBarView == nil {
                touchBarView = TouchBarViewController()
                touchBarView?.macScene = scene
            }

            item.viewController = touchBarView

            return item
        default: return nil
        }
    }
}

extension NSTouchBarItem.Identifier {
    static let touchBarView = NSTouchBarItem.Identifier("com.spriteKit.touchBar")
}


