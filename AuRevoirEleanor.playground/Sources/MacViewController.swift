import AppKit
import Cocoa
import SpriteKit


open class MacViewController: NSViewController{
    
    //public var touchBarViewController: TouchBarViewController!
    
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
        print("mac view did appear")
        if skView.scene == nil {
            scene = MacScene(size: skView.frame.size)
            skView.presentScene(scene)
        }
        
    }
}

extension MacViewController: NSTouchBarDelegate {

    override public func makeTouchBar() -> NSTouchBar? {

 //       let touchBar = NSTouchBar()
        
//        touchBar.delegate = self
//        touchBar.customizationIdentifier = .colorPickerBar
//        touchBar.defaultItemIdentifiers = [.colorLabel, .colorScrubber]
//        touchBar.customizationAllowedItemIdentifiers = [.colorLabel, .colorScrubber]
//
//        return touchBar
        
        let bar = NSTouchBar()

        bar.delegate = self
        bar.defaultItemIdentifiers = [.touchBarView]

        return bar
        
    }

    public func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {


//        let item = NSCustomTouchBarItem(identifier: .colorLabel)
//
//        switch identifier {
//        case NSTouchBarItem.Identifier.colorLabel:
//
//            if touchBarViewController == nil {
//                touchBarViewController = TouchBarViewController()
//                touchBarViewController.macScene = scene
//            }
//            item.viewController = touchBarViewController
//
//            return item
//
//        default: return nil
//        }
        switch identifier {
        case NSTouchBarItem.Identifier.touchBarView:
            let item = NSCustomTouchBarItem(identifier: .touchBarView)

            if touchBarView == nil {
                touchBarView = TouchBarViewController()
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


