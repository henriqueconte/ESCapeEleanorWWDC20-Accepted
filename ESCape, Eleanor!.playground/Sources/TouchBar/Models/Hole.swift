import Foundation
import SpriteKit


public class Hole: SKSpriteNode {
    
    private var lightNodes: [SKLightNode] = []
    
    override public init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "hole"
        self.lightingBitMask = BitmaskConstants.affectedByLight
        self.alpha = 0.0
        
        setDefaultPhysicsBody()
        setLightNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Disappear using light effects
    func disappear(_ completion: @escaping () -> ()) {
        
        let reduceLight = SKAction.customAction(withDuration: 0.005) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff += 0.16
            }
        }
        
        let reduceLightSequence = SKAction.sequence([reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight])
        
        let wait = SKAction.wait(forDuration: 1)
        
        self.run(SKAction.sequence([wait, reduceLightSequence])) {
            self.isHidden = true
            completion()
        }
    }
    
    // Appear using light efects
    func appear() {
        let increaseLight = SKAction.customAction(withDuration: 0.01) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff -= 0.008
            }
        }
        
        let increaseLightSequence = SKAction.sequence([increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight])
        
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 1.0)
        
        self.run(SKAction.group([increaseLightSequence, fadeIn]))
    }
    
    // MARK:- Sets initial elements
    private func setDefaultPhysicsBody() {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width * 0.05,
                                                            height: self.frame.height * 0.3)
        )
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        physicsBody.contactTestBitMask = 1
        physicsBody.collisionBitMask = 0
        
        self.physicsBody = physicsBody
    }
    
    private func setLightNodes() {
        let lightNode = SKLightNode()

        lightNode.position = self.position
        lightNode.ambientColor = .clear
        lightNode.lightColor = .white
        lightNode.falloff = 0.9
        lightNode.zPosition = 1
        lightNode.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        self.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        lightNodes.append(lightNode)
        addChild(lightNode)
    }
}
