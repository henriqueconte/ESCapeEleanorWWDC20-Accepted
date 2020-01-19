import AppKit
import Cocoa
import PlaygroundSupport


var str = "Hello, playground"

print(str)

//let gameViewController = GameViewController()

//gameViewController.view = gameScene

let touchBarViewController = TouchBarViewController() 

PlaygroundPage.current.liveView = touchBarViewController

touchBarViewController.view.becomeFirstResponder()
 
