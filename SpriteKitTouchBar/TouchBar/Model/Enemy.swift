//
//  Enemy.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 23/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class Enemy: SKLabelNode {
    
    init(text: String) {
        super.init()
        self.text = text
        self.fontSize = 10
        self.zRotation = 5.5
        self.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.name = "enemy"
        setDefaultPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func die() {
        self.removeAllActions()
        self.physicsBody?.affectedByGravity = true
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        addChild(explosion)
        explosion.resetSimulation()
        explosion.particleTexture = SKTexture(imageNamed: "Bloob")
        explosion.position = CGPoint(x: self.position.x, y: self.position.y)
        explosion.particleSize = CGSize(width: 10, height: 10)
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)

        self.run(fadeOut) {
            explosion.removeFromParent()
            self.removeFromParent()
        }
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
    
}
