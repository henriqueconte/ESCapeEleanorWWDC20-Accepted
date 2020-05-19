import Foundation
import SpriteKit


public class Coffee: SKSpriteNode {
    
    override public init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "coffee"
        self.lightingBitMask = BitmaskConstants.affectedByLight
        
        setDefaultPhysicsBody()
        setBounce()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disappear() {
        self.removeAllActions()
        
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)

        self.run(fadeOut) {
            self.removeFromParent()
        }
    }
    
    func createInstructions() -> SKLabelNode {
        let instruction = SKLabelNode(text: "Press enter to take the coffee")
        instruction.fontSize = 15
        instruction.fontName = "Arial Rounded MT Bold"
        instruction.fontColor = .white
        instruction.zPosition = 1
        instruction.alpha = 0
        
        return instruction
    }
    
    // MARK:- Sets initial elements
    private func setDefaultPhysicsBody() {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width * 0.5,
                                                            height: self.frame.height * 0.5)
        )
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        physicsBody.contactTestBitMask = 1
        physicsBody.collisionBitMask = 0
        
        self.physicsBody = physicsBody
    }
    
    private func setBounce() {
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 2), duration: 0.2)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -2), duration: 0.1)
        let gap = SKAction.wait(forDuration: 1.7)
        let loopAction = SKAction.sequence([moveUp, moveDown, gap])
        
        self.run(SKAction.repeatForever(loopAction))
    }
    
}
