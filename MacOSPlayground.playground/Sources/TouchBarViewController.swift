import AppKit
import Cocoa
import SpriteKit


open class TouchBarViewController: NSViewController{
    
    public var gameViewController: GameViewController!
    
    var scene: FillerScene?
    
    lazy var skView: SKView = {
        let gameView = SKView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        gameView.autoresizingMask = [.width, .height]
        
        return gameView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        
        print("Load view touch bar view controller")
        view = skView//NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))

        //view.addSubview(skView)
    }
    
    override public func viewDidLayout() {
        super.viewDidLayout()
    }
    
    override public func viewDidAppear() {
        print("view did appear touch bar view controller")
        
        if skView.scene == nil {
            scene = FillerScene(size: skView.frame.size)
            skView.presentScene(scene)
        }
        
    }
}

extension TouchBarViewController: NSTouchBarDelegate {

    override public func makeTouchBar() -> NSTouchBar? {
        print("make touch bar")
        let touchBar = NSTouchBar()
        
        touchBar.delegate = self
        touchBar.customizationIdentifier = .colorPickerBar
        
        touchBar.defaultItemIdentifiers = [.colorLabel, .colorScrubber]
        touchBar.customizationAllowedItemIdentifiers = [.colorLabel, .colorScrubber]
        print("make touch bar end")
        
        return touchBar
    }

    public func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {


        let item = NSCustomTouchBarItem(identifier: .colorLabel)
        
        switch identifier {
        case NSTouchBarItem.Identifier.colorLabel:

            if gameViewController == nil {
                gameViewController = GameViewController()
            }
            item.viewController = gameViewController
            
            return item

        default: return nil
        }
    }
}


