//
//  AppDelegate.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 22/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    fileprivate var touchBarView: TouchBarView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate: NSTouchBarDelegate, NSTouchBarProvider {
    
    var touchBar: NSTouchBar? {
        let bar = NSTouchBar()

        bar.delegate = self
        bar.defaultItemIdentifiers = [.touchBarView]

        return bar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {


        switch identifier {
        case NSTouchBarItem.Identifier.touchBarView:
            let item = NSCustomTouchBarItem(identifier: .touchBarView)

            if touchBarView == nil {
                touchBarView = TouchBarView()
            }

            item.viewController = touchBarView

            return item
        default: return nil
        }
    }
}

@available(OSX 10.12.1, *)
extension NSTouchBarItem.Identifier {
    static let touchBarView = NSTouchBarItem.Identifier("com.spriteKit.touchBar")
}
