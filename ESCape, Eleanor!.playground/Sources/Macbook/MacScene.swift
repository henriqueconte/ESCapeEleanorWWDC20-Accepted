import Cocoa
import Foundation
import SpriteKit


public class MacScene: SKScene {
    
    var playerNode: NewPlayer?
    
    var hole: SKSpriteNode?
    var colorBackgroundNode: SKSpriteNode?
    var blackBackgroundNode: SKSpriteNode?
    var closedPadlock: SKSpriteNode?
    var greenBar: SKSpriteNode?
    var openPadlock: SKSpriteNode?
    var finalMessage: SKLabelNode?
    var onboardMessage: SKLabelNode?
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        setOnboardMessage()
        setBackground()
        setPadlocks()
        setHole()
        setPlayer()
        setGreenBar()
        setFinalMessage()
    }
    
    // MARK:- Sets initial elements
    private func setOnboardMessage() {
        
        onboardMessage = SKLabelNode(text: "Click here to start and then \nlook at your Touch Bar")
        onboardMessage?.position = CGPoint(x: 0, y: 100)
        onboardMessage?.numberOfLines = 2
        onboardMessage?.fontSize = (view?.frame.size.width ?? 0) * 0.05
        onboardMessage?.fontName = "Arial Rounded MT Bold"
        
        
        let fadeIn = SKAction.fadeIn(withDuration: 1.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        
        onboardMessage?.run(SKAction.repeatForever(SKAction.sequence([fadeIn, fadeOut])))
        
        addChild(onboardMessage!)
    }
    
    private func setBackground() {
        colorBackgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "openCamp"), color: .clear, size: view?.frame.size ?? CGSize(width: 300, height: 300))
        colorBackgroundNode?.alpha = 0.0
        colorBackgroundNode?.zPosition = 1
        
        blackBackgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "blackCamp"), color: .clear, size: view?.frame.size ?? CGSize(width: 300, height: 300))
        blackBackgroundNode?.alpha = 0.3
        blackBackgroundNode?.zPosition = 40
        
        addChild(colorBackgroundNode!)
        addChild(blackBackgroundNode!)
    }
    
    private func setPadlocks() {
        closedPadlock = SKSpriteNode(texture: SKTexture(imageNamed: "closedPadlock"), color: .clear, size: CGSize(width: 150, height: 152))
        openPadlock = SKSpriteNode(texture: SKTexture(imageNamed: "openPadlock"), color: .clear, size: closedPadlock?.size ?? CGSize(width: 0, height: 0))
        
        blackBackgroundNode?.addChild(closedPadlock!)
        colorBackgroundNode?.addChild(openPadlock!)
    }
    
    private func setHole() {
        hole = SKSpriteNode(texture: SKTexture(imageNamed: "hole"), color: .clear, size: CGSize(width: 35, height: 22))
        hole?.position = CGPoint(x: 150, y: -150)
        hole?.zPosition = 4
        hole?.alpha = 0
        
        addChild(hole!)
    }
    
    private func setPlayer() {
        playerNode = NewPlayer(texture: SKTexture(imageNamed: "charLeft1"), color: .clear, size: CGSize(width: 17, height: 24))
        playerNode?.position = CGPoint(x: hole?.position.x ?? 0, y: (hole?.position.y ?? 0) * 1.1)
        playerNode?.zPosition = 2
        playerNode?.alpha = 0
        
        addChild(playerNode!)
    }
    
    private func setGreenBar() {
        greenBar = SKSpriteNode(texture: SKTexture(imageNamed: "greenBar"), color: .clear, size: CGSize(width: 400, height: 90))
        greenBar?.position = CGPoint(x: 0, y: -200)
        greenBar?.zPosition = 3
        greenBar?.alpha = 0
        
        addChild(greenBar!)
    }
    
    private func setFinalMessage() {
        finalMessage = SKLabelNode(text: "Thank you for helping Eleanor!\nEleanor is now a free programmer ;]")
        finalMessage?.position = CGPoint(x: 60, y: 55)
        finalMessage?.fontColor = .white
        finalMessage?.fontName = "Arial Rounded MT Bold"
        finalMessage?.fontSize = 15
        finalMessage?.alpha = 0
        finalMessage?.zPosition = 2
        finalMessage?.numberOfLines = 2
        
        addChild(finalMessage!)
    }
    
    // Shows elements on screen after the touch bar phase ends
    func unlockBackground() {
        let wait = SKAction.wait(forDuration: 1.5)
        let smallWait = SKAction.wait(forDuration: 1.0)
        let fadeOut = SKAction.fadeOut(withDuration: 2.0)
        let fadeIn = SKAction.fadeIn(withDuration: 2.0)
        let fadeInSequence = SKAction.sequence([wait, fadeIn])
        
        colorBackgroundNode?.run(SKAction.sequence([wait, fadeIn]))
        greenBar?.run(fadeInSequence)
        hole?.run(fadeInSequence)
        openPadlock?.run(SKAction.sequence([wait, fadeIn, smallWait, fadeOut])) {
            self.playerNode?.appearOnMacBook(completion: {
                
                let sound = SKAction.playSoundFileNamed("medievalSound.mp3", waitForCompletion: false)
                self.run(sound)
                
                self.finalMessage?.run(fadeIn)
            })
        }
        
        blackBackgroundNode?.run(SKAction.sequence([wait, fadeOut]))
        blackBackgroundNode?.run(SKAction.sequence([wait, fadeOut]))
    }

    
}
