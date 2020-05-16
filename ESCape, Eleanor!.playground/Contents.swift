
//: # ESCape, Eleanor! 🕊
//:  by [Henrique Conte](https://github.com/henriqueconte)
/*:
 The usage of unusual and different technologies always fascinated me, so I decided to create a mini game showing a little bit of what we can do with the Touch Bar.
 
 
 Your objective will be to help Eleanor, a young and brave programmer to escape from the cave she ended while searching for exotic technologies. In order to do that, you will just have to:
 
 
 1. Show the Assistant Editor with the LiveView selected
 2. Run the Playground
 2. Click on the canvas to show the controls
 
 
 * Important:
 If your Macbook does not have a TouchBar, press ⌘ + ⇧ + 8
 
 ---
 
 ### Controls
 
 Use your arrow keys to walk ⬅️ ➡️. More commands will be taught during the gameplay.
 
 
### Take a cup of coffee and let's start with the demo!
 
  ![Coffee](smallCoffee.png)
 */



import PlaygroundSupport


let macViewController = MacViewController()

PlaygroundPage.current.liveView = macViewController
macViewController.view.becomeFirstResponder()
