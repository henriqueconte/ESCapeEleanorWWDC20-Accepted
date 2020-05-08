//
//  NewPlayer.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 06/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit
import AppKit


class NewPlayer: SKSpriteNode {
    
    private var leftAssetCount: Int = 1
    private var rightAssetCount: Int = 1
    private var lightNodes: [SKLightNode] = []
    
    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "player"
        setDefaultPhysicsBody(from: self)
        setLightNodes()
    }
    
    func moveRight() {
        if self.position.x < 676 {
            setNewPosition(newPoint: CGPoint(x: self.position.x + 7, y: self.position.y), duration: 0.1)
        }
        
        leftAssetCount = 1
        
        if rightAssetCount > 3 {
            rightAssetCount = 1
        }
        
        self.texture = SKTexture(imageNamed: "charRight\(rightAssetCount)")
        
        rightAssetCount += 1
        
    }
    
    func moveLeft() {
        if self.position.x > 7 {
            setNewPosition(newPoint: CGPoint(x: self.position.x - 7, y: self.position.y), duration: 0.1)
        }
        
        rightAssetCount = 1
        
        if leftAssetCount > 3 {
            leftAssetCount = 1
        }
        self.texture = SKTexture(imageNamed: "charLeft\(leftAssetCount)")
        
        leftAssetCount += 1
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
