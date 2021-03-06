import Foundation
import SpriteKit
import AppKit


public class NewPlayer: SKSpriteNode {
    
    private var leftAssetCount: Int = 1
    private var rightAssetCount: Int = 1
    private var lightNodes: [SKLightNode] = []
    var canMove: Bool = true
    var canAttack: Bool = false
    var currentDirection: String = "right"
    var attackTime: Double = 0.0
    
    override public init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "player"
        setDefaultPhysicsBody(from: self)
        setLightNodes()
    }
    
    // Moves right changing the char asset
    func moveRight() {
        
        if canMove {
            if self.position.x < 676 {
                setNewPosition(newPoint: CGPoint(x: self.position.x + 7, y: self.position.y), duration: 0.1, completion: {})
            }
            
            leftAssetCount = 1
            
            if rightAssetCount > 3 {
                rightAssetCount = 1
            }
            
            self.texture = SKTexture(imageNamed: "charRight\(rightAssetCount)")
            
            rightAssetCount += 1
            
            currentDirection = "right"
        }
        
    }
    
    // Moves left changing the char asset
    func moveLeft() {
        
        if canMove {
            if self.position.x > 7 {
                setNewPosition(newPoint: CGPoint(x: self.position.x - 7, y: self.position.y), duration: 0.1, completion: {})
            }
            
            rightAssetCount = 1
            
            if leftAssetCount > 3 {
                leftAssetCount = 1
            }
            self.texture = SKTexture(imageNamed: "charLeft\(leftAssetCount)")
            
            leftAssetCount += 1
            
            currentDirection = "left"
        }
        
    }
    
    // When enabled, the char shoots
    func shoot() {
        let shootNode = SKSpriteNode(texture: SKTexture(imageNamed: "hammer"), color: .clear, size: CGSize(width: 10, height: 10))
        var moveAction: SKAction = SKAction()
        shootNode.position = CGPoint(x: 0, y: 0)
        shootNode.name = "hammer"
        shootNode.lightingBitMask = BitmaskConstants.affectedByLight
        setDefaultPhysicsBody(from: shootNode)
        
        let spinningAction = SKAction.repeatForever(SKAction.rotate(byAngle: .pi * 2, duration: 0.5))
        
        let lightNode = SKLightNode()

        lightNode.position = shootNode.position
        lightNode.ambientColor = .clear
        lightNode.lightColor = .white
        lightNode.falloff = 0.8
        lightNode.zPosition = 1
        lightNode.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        shootNode.addChild(lightNode)
        
        if currentDirection == "left" {
            moveAction = SKAction.move(by: CGVector(dx: -700, dy: 0), duration: 2)
            
        }
        else {
            moveAction = SKAction.move(by: CGVector(dx: 700, dy: 0), duration: 2)
        }
        
        shootNode.run(spinningAction)
        shootNode.run(moveAction) {
            shootNode.removeFromParent()
        }
        
        addChild(shootNode)
        
        canAttack = false
    }
    
    // MARK:- Sets initial elements
    
    private func setDefaultPhysicsBody(from node: SKNode) {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width * 0.5,
                                                            height: node.frame.height * 0.5)
        )
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        physicsBody.contactTestBitMask = 1
        physicsBody.collisionBitMask = 0
        
        node.physicsBody = physicsBody
    }
    
    private func setNewPosition(newPoint: CGPoint, duration: TimeInterval, completion: @escaping () -> ()) {
        let moveAction = SKAction.move(to: newPoint, duration: duration)
        self.run(moveAction) {
            completion()
        }
    }
    
    private func setLightNodes() {
        for _ in 0..<2 {
            let lightNode = SKLightNode()

            lightNode.position = self.position
            lightNode.ambientColor = .clear
            lightNode.lightColor = .white
            lightNode.falloff = 0
            lightNode.zPosition = 1
            lightNode.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
            
            self.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
            
            lightNodes.append(lightNode)
            addChild(lightNode)
        }
    }
    
    // Used to show that something happened
    func animateLightNodes(completion: @escaping () -> ()) {
 
        let reduceLight = SKAction.customAction(withDuration: 0.01) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff += 0.014
            }
        }
        
        let increaseLight = SKAction.customAction(withDuration: 0.01) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff -= 0.011
            }
        }
        
        let reduceLightSequence = SKAction.sequence([reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight])
        
        let increaseLightSequence = SKAction.sequence([increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight])
        
        let loop = SKAction.sequence([reduceLightSequence, increaseLightSequence, reduceLightSequence, increaseLightSequence])
        
        
        self.run(loop, completion: {
            completion()
        })
        
    }
    
    // Disappear using light nodes effects
    func disappear(_ completion: @escaping () -> ()) {
        
        let wait = SKAction.wait(forDuration: 1)
        let moveOut = SKAction.move(by: CGVector(dx: 0, dy: -30), duration: 4)
        
        
        let reduceLight = SKAction.customAction(withDuration: 0.01) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff += 0.014
            }
        }
        
        let reduceLightSequence = SKAction.sequence([reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight])
        
        let sequence = SKAction.sequence([wait, moveOut, reduceLightSequence, reduceLightSequence])
        
        self.run(sequence) {
            completion()
        }
    }
    
    // Shows the character on the macbook scene
    func appearOnMacBook(completion: @escaping () -> ()) {
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 3.0)
        
        self.alpha = 1.0
        self.run(moveUp) {
            self.moveLeft()
            self.setNewPosition(newPoint: CGPoint(x: self.position.x - 7, y: self.position.y), duration: 0.4, completion: {
                self.moveLeft()
                self.setNewPosition(newPoint: CGPoint(x: self.position.x - 14, y: self.position.y), duration: 0.4, completion: {
                    self.moveLeft()
                    self.setNewPosition(newPoint: CGPoint(x: self.position.x - 21, y: self.position.y), duration: 0.4, completion: {
                        self.moveLeft()

                        completion()
                    })
                })
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
