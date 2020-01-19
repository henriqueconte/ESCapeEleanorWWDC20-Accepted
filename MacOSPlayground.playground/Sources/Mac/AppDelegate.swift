//
//  AppDelegate.swift
//  ProjectTouchBar
//
//  Created by Henrique Figueiredo Conte on 11/01/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    fileprivate var viewController: TouchBarViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        
        print("app delegate did finish")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate: NSTouchBarDelegate, NSTouchBarProvider {
    var touchBar: NSTouchBar? {
    
        let bar = NSTouchBar()
        
        bar.delegate = self
        bar.customizationIdentifier = .colorPickerBar
        
        bar.defaultItemIdentifiers = [.colorLabel, .colorScrubber]
        bar.customizationAllowedItemIdentifiers = [.colorLabel, .colorScrubber]
        
        return bar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.colorLabel:
            let item = NSCustomTouchBarItem(identifier: .colorLabel)
            
            if viewController == nil {
                viewController = TouchBarViewController()
            }
            item.viewController = viewController
            
            return item
            
        default: return nil
        }
    }
    
}


