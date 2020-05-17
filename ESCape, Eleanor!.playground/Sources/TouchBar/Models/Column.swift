import Foundation
import SpriteKit


public class Column: SKSpriteNode {
    
    override public init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "column"
        self.lightingBitMask = BitmaskConstants.affectedByLight
        
        setDefaultPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disappear(completion: @escaping () -> ()) {
        let moveLeft = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.03)
        let moveRight = SKAction.move(by: CGVector(dx: 1, dy: 0), duration: 0.03)
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 30), duration: 4)
        let trembleLoop = SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight]))
        
        self.run(trembleLoop)
        self.run(moveUp) {
            completion()
            self.removeFromParent()
        }
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

}
