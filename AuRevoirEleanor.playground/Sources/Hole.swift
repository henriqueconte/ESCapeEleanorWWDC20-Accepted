//
//  Hole.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 07/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

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
    
    func disappear() {
        
        let increaseLight = SKAction.customAction(withDuration: 0.02) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff -= 0.05
            }
        }
        
        let reduceLight = SKAction.customAction(withDuration: 0.005) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff += 0.16
            }
        }
        
        let increaseLightSequence = SKAction.sequence([increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight,increaseLight,increaseLight,increaseLight
            ,increaseLight,increaseLight])
        
        let reduceLightSequence = SKAction.sequence([reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight])
        
        let wait = SKAction.wait(forDuration: 1)
        
        
        self.run(SKAction.sequence([wait, reduceLightSequence])) {
            self.isHidden = true
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
        lightNode.falloff = 1.0
        lightNode.zPosition = 1
        lightNode.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        self.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        lightNodes.append(lightNode)
        addChild(lightNode)
    }
}
