import AppKit
import Cocoa
import SpriteKit

protocol SlideToUnlock: class {
    func didFinishSliding()
}


public class MyView: NSView {
    
    override public var acceptsFirstResponder: Bool { return true }
    var touchBarPaddle: NSView?
    var trackingTouchIdentity: AnyObject?
    var hasFinishedSliding: Bool = false
    let paddleWidth: Double = 60
    let paddleHeight: Double = 25
    
    weak var delegate: SlideToUnlock? = nil
    
    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if touchBarPaddle == nil {
            touchBarPaddle = NSView(frame: NSRect(x: 2,
                                                  y: 2.5,
                                                  width: paddleWidth,
                                                  height: paddleHeight))
            touchBarPaddle?.wantsLayer = true   // Necessary
            touchBarPaddle?.layer?.cornerRadius = 5.0
            touchBarPaddle?.layer?.masksToBounds = true
            touchBarPaddle?.layer?.backgroundColor = NSColor.clear.cgColor
            touchBarPaddle?.layer?.zPosition = 2
            
            addSubview(touchBarPaddle!)
            
            let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: paddleWidth, height: paddleHeight))
            imageView.image = NSImage(named: NSImage.Name("filledArrow"))
            
            touchBarPaddle?.addSubview(imageView)
        }
        // #1d161d
        NSColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1).setFill()

        dirtyRect.fill()
        
        addInstructions()
    }

    override public func touchesBegan(with event: NSEvent) {
        if trackingTouchIdentity == nil {
            if let touch = event.touches(matching: .began, in: self).first, touch.type == .direct {
                trackingTouchIdentity = touch.identity
            }
        }
    }
    
    override public func touchesMoved(with event: NSEvent) {
        if let trackingTouchIdentity = trackingTouchIdentity {
            let relevantTouches = event.touches(matching: .moved, in: self)
            let actualTouches = relevantTouches.filter({ $0.type == .direct && $0.identity.isEqual(trackingTouchIdentity) })
            if let trackingTouch = actualTouches.first {
                let location = trackingTouch.location(in: self)
                let locationX = Double(location.x) - paddleWidth / 2
                
                var finalLocationX = 0.0
                if locationX < 0.0 {
                    finalLocationX = 0.0
                } else if locationX + paddleWidth > Double(frame.width) {
                    finalLocationX = Double(frame.width) - paddleWidth
                } else {
                    finalLocationX = locationX
                }
  
                touchBarPaddle?.frame = NSRect(x: finalLocationX,
                                               y: 0,
                                               width: paddleWidth,
                                               height: paddleHeight)
            }
        }
        
        if touchBarPaddle?.frame.maxX == 685 && hasFinishedSliding == false {
            delegate?.didFinishSliding()
            hasFinishedSliding = true
        }
        super.touchesMoved(with: event)
    }

    override public func touchesEnded(with event: NSEvent) {
        if let trackingTouchIdentity = trackingTouchIdentity {
            let relevantTouches = event.touches(matching: .ended, in: self)
            let actualTouches = relevantTouches.filter({ $0.type == .direct && $0.identity.isEqual(trackingTouchIdentity) })
            if let _ = actualTouches.first {
                self.trackingTouchIdentity = nil
            }
        }
        super.touchesEnded(with: event)
    }

    override public func touchesCancelled(with event: NSEvent) {
        if let trackingTouchIdentity = trackingTouchIdentity {
            let relevantTouches = event.touches(matching: .cancelled, in: self)
            let actualTouches = relevantTouches.filter({ $0.type == .direct && $0.identity.isEqual(trackingTouchIdentity) })
            if let _ = actualTouches.first {
                self.trackingTouchIdentity = nil
            }
        }
        super.touchesCancelled(with: event)
    }
    
    func addInstructions() {
        let instructions = NSText(frame: NSRect(x: 300, y: 0, width: 200, height: 23))
        instructions.insertText("Slide to unlock")
        instructions.textColor = NSColor.white
        instructions.backgroundColor = NSColor.clear
        instructions.layer?.zPosition = 0
        
        addSubview(instructions)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 90
            instructions.animator().alphaValue = 1.0
        }, completionHandler: {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 2
                instructions.animator().alphaValue = 0.0
            }, completionHandler: {
                NSAnimationContext.runAnimationGroup({ (context) in
                    context.duration = 2
                    instructions.animator().alphaValue = 1.0
                }, completionHandler: {
                    NSAnimationContext.runAnimationGroup({ (context) in
                        context.duration = 2
                        instructions.animator().alphaValue = 0.0
                    }, completionHandler: {
                        NSAnimationContext.runAnimationGroup({ (context) in
                            context.duration = 2
                            instructions.animator().alphaValue = 1.0
                        }, completionHandler: {
                            NSAnimationContext.runAnimationGroup({ (context) in
                                context.duration = 2
                                instructions.animator().alphaValue = 0.0
                            }, completionHandler: {
                                NSAnimationContext.runAnimationGroup({ (context) in
                                    context.duration = 2
                                    instructions.animator().alphaValue = 1.0
                                }, completionHandler: {
                                    NSAnimationContext.runAnimationGroup({ (context) in
                                        context.duration = 2
                                        instructions.animator().alphaValue = 0.0
                                    }, completionHandler: {
                                        NSAnimationContext.runAnimationGroup({ (context) in
                                            context.duration = 2
                                            instructions.animator().alphaValue = 1.0
                                        }, completionHandler: {
                                            
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
        
        

    }
    
}
