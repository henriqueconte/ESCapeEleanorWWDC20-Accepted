//
//  Column.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 07/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class Column: SKSpriteNode {
    
    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
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
