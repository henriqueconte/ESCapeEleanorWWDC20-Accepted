import AppKit
import Cocoa
import PlaygroundSupport


var str = "Hello, playground"

print(str)


let macViewController = MacViewController()

PlaygroundPage.current.liveView = macViewController

macViewController.view.becomeFirstResponder()
 
