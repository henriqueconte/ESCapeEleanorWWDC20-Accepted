//
//  Coffee.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 07/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class Coffee: SKSpriteNode {
    
    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "coffee"
        setDefaultPhysicsBody()
        setBounce()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickCoffee() {
        self.removeAllActions()
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        addChild(explosion)
        explosion.resetSimulation()
        explosion.particleTexture = SKTexture(imageNamed: "Bloob")
        explosion.position = CGPoint(x: self.position.x, y: self.position.y)
        explosion.particleSize = CGSize(width: 15, height: 15)
        explosion.speed = 0.5
        
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)

        self.run(fadeOut) {
            explosion.removeFromParent()
            self.removeFromParent()
//            completion()
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
