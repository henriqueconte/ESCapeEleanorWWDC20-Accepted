////
////  ViewController.swift
////  SpriteKitTouchBar
////
////  Created by Henrique Figueiredo Conte on 22/04/20.
////  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
////
//
//import Cocoa
//import SpriteKit
//
//
//class ViewController: NSViewController {
//
//
//    lazy var skView: SKView = {
//        let gameView = SKView(frame: self.view.bounds)
//        gameView.autoresizingMask = [.width, .height]
//
//        return gameView
//    }()
//
//    var scene: GameScene?
//    var touchBarView: TouchBarView?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
////            if let scene = SKScene(fileNamed: "GameScene") {
////
////                gameScene = scene as? GameScene
////
////                scene.scaleMode = .aspectFill
////
////                view.presentScene(scene)
////            }
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func loadView() {
//        view = NSView()
//        view.addSubview(skView)
//    }
//
//    override func viewDidLayout() {
//        super.viewDidLayout()
//
//        skView.frame = view.bounds
//    }
//
//    override func viewDidAppear() {
//        super.viewDidAppear()
//
//        if skView.scene == nil {
//            scene = GameScene(size: skView.frame.size)
//            skView.presentScene(scene)
//        }
//        //view.window!.styleMask.remove(NSWindow.StyleMask.resizable)
//    }
//
//
//
//}
//
//extension ViewController: NSTouchBarDelegate {
//
//    @available(OSX 10.12.2, *)
//    override func makeTouchBar() -> NSTouchBar? {
//        let touchBar = NSTouchBar()
//        touchBar.delegate = self
//        touchBar.customizationIdentifier = .touchBar
//        touchBar.defaultItemIdentifiers = [.touchEvent]
//        touchBar.customizationAllowedItemIdentifiers = [.touchEvent]
//
//        return touchBar
//    }
//
//    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
//
//        if touchBarView == nil {
//            touchBarView = TouchBarView()
//        }
//        //touchBarView.view.wantsLayer = true
//      //  touchBarView.view.layer?.backgroundColor = NSColor.blue.cgColor
//    //    touchBarView.view.allowedTouchTypes = .direct
//
//        let item = NSCustomTouchBarItem(identifier: identifier)
//        item.viewController = touchBarView
//
//        return item
//    }
//}
//
//
//@available(OSX 10.12.2, *)
//fileprivate extension NSTouchBar.CustomizationIdentifier {
//    static let touchBar = NSTouchBar.CustomizationIdentifier("com.spriteKit.touchBar")
//}
//
//@available(OSX 10.12.2, *)
//fileprivate extension NSTouchBarItem.Identifier {
//    static let touchEvent = NSTouchBarItem.Identifier("com.spriteKit.touch")
//}


//
//  ViewController.swift
//  TouchBreakout
//
//  Created by 宋 奎熹 on 2017/11/16.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit


class MacViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window!.styleMask.remove(NSWindow.StyleMask.resizable)
    }

}
