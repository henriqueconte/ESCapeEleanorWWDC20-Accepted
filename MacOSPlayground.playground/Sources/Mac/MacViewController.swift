import AppKit
import Cocoa
import SpriteKit


open class MacViewController: NSViewController{
    
    public var touchBarViewController: TouchBarViewController!
    
    var scene: OnboardMacScene?
    
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
            scene = OnboardMacScene(size: skView.frame.size)
            skView.presentScene(scene)
        }
        
    }
}

extension MacViewController: NSTouchBarDelegate {

    override public func makeTouchBar() -> NSTouchBar? {

        let touchBar = NSTouchBar()
        
        touchBar.delegate = self
        touchBar.customizationIdentifier = .colorPickerBar
        
        touchBar.defaultItemIdentifiers = [.colorLabel, .colorScrubber]
        touchBar.customizationAllowedItemIdentifiers = [.colorLabel, .colorScrubber]
        
        return touchBar
    }

    public func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {


        let item = NSCustomTouchBarItem(identifier: .colorLabel)
        
        switch identifier {
        case NSTouchBarItem.Identifier.colorLabel:

            if touchBarViewController == nil {
                touchBarViewController = TouchBarViewController()
            }
            item.viewController = touchBarViewController
            
            return item

        default: return nil
        }
    }
}


