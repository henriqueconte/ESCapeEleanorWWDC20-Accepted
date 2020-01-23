import Foundation
import SpriteKit



class EndMenuTouchBarScene: SKScene {
    
    var aboutMeButton: SKSpriteNode?
    var playAgainButton: SKSpriteNode?
    var selectedButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundColor = .orange
        
        setMenuButtons()
        setVisualElements()
        setKeyboardEvents()
    }
    
    func setMenuButtons() {
        
        aboutMeButton = SKSpriteNode()
        aboutMeButton?.position = CGPoint(x: -0.2, y: 0)
        aboutMeButton?.size = CGSize(width: 0.25, height: 0.8)
        aboutMeButton?.color = .purple
        
        selectedButton = aboutMeButton
        
        playAgainButton = SKSpriteNode()
        playAgainButton?.position = CGPoint(x: 0.2, y: 0)
        playAgainButton?.size = CGSize(width: 0.25, height: 0.8)
        playAgainButton?.color = .green
        
        
        addChild(aboutMeButton!)
        addChild(playAgainButton!)
    }
    
    func setVisualElements() {
        
        let spinningCircle = SKSpriteNode(texture: SKTexture(imageNamed: "solidCircle"))
        spinningCircle.size = CGSize(width: 0.033, height: 0.8)
        spinningCircle.position = CGPoint(x: 0, y: 0)
        
       // let oneRevolution:SKAction = SKAction.rotate(byAngle: (CGFloat.pi * 2), duration: 1)
//        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
//
//        spinningCircle.run(repeatRotation)

        addChild(spinningCircle)
    }
    
    func setKeyboardEvents() {
        
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (event) -> NSEvent? in
            
            switch event.keyCode {
            case KeyIdentifiers.leftArrow.rawValue:
                
                self.selectedButton = self.aboutMeButton
                self.glowNode()
            
                
            case KeyIdentifiers.rightArrow.rawValue:
                self.selectedButton = self.playAgainButton
                self.glowNode()
                
            case KeyIdentifiers.space.rawValue:
                if self.selectedButton == self.aboutMeButton {
                    
                }
                else if self.selectedButton == self.playAgainButton {
                    
                }
                
            default:
                return event
            }
            
            return event
        }
    }
    
    func glowNode() {
        
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.17)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.25)
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])
        
//        let neonShape = SKShapeNode(rectOf: selectedButton?.frame.size ?? CGSize(width: 0.1, height: 0.4))//SKShapeNode(rectOf: selectedButton?.frame.size ?? CGSize(width: 0.1, height: 0.4), cornerRadius: 0)
//
//
//
//        neonShape.lineWidth = 0.0001
//        neonShape.glowWidth = 10
//        neonShape.strokeColor = .blue
//        neonShape.fillColor = .red
//        neonShape.blendMode = SKBlendMode(rawValue: 10)!
//        neonShape.alpha = 0.1
//
//        selectedButton?.addChild(neonShape)
//
//        self.selectedButton?.run(fadeSequence) {
//            neonShape.removeFromParent()
//        }
        
        let neonShape = SKSpriteNode()
        neonShape.color = .blue
        neonShape.position = CGPoint(x: 0, y: 0)
        neonShape.size = selectedButton?.size ?? CGSize(width: 0.1, height: 0.5)
        neonShape.blendMode = SKBlendMode(rawValue: 10)!
        
        selectedButton?.addChild(neonShape)
        
        neonShape.run(fadeSequence) {
            neonShape.removeFromParent()
        }
        
    }
    
}
