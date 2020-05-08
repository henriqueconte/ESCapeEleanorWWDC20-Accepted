//
//  Player.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 23/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class Player: SKLabelNode {
    
    var isAlive: Bool = true
    
    init(text: String) {
        super.init()
        self.text = text
        self.fontSize = 14
        self.zRotation = 5.5
        self.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.name = "player"
        setDefaultPhysicsBody(from: self)
    }
    
    func moveUp() {
        if isAlive {
            if self.position.y < 26 {
                setNewPosition(newPoint: CGPoint(x: self.position.x, y: self.position.y + 5), duration: 0.1)
            }
        }
    }
    
    func moveDown() {
        if isAlive {
            if self.position.y > 2 {
                setNewPosition(newPoint: CGPoint(x: self.position.x, y: self.position.y - 5), duration: 0.1)
            }
        }
    }
    
    func shoot() -> SKLabelNode {
        let shootNode = SKLabelNode(text: "💣")
        shootNode.fontSize = 6
        shootNode.position = CGPoint(x: self.position.x + 5, y: self.position.y)
        shootNode.zRotation = -5.5
        shootNode.name = "playerBomb"
        setDefaultPhysicsBody(from: shootNode)
        
        let spinningAction = SKAction.repeatForever(SKAction.rotate(byAngle: .pi * 2, duration: 0.5))
        
        shootNode.run(spinningAction)
        
        return shootNode
    }
    
    func die(_ completion: @escaping () -> ()) {
        self.removeAllActions()
        isAlive = false
        
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
            completion()
        }
    }
    
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
    
    private func setNewPosition(newPoint: CGPoint, duration: TimeInterval) {
        let moveAction = SKAction.move(to: newPoint, duration: duration)
        self.run(moveAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
