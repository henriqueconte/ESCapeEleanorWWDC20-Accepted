//
//  NewEnemy.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 06/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit
import AppKit


public class NewEnemy: SKSpriteNode {
    
    private var lightNodes: [SKLightNode] = []
    
    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "monster"
        setDefaultPhysicsBody(from: self)
        setLightNodes()
        setInitialPosition()
        setRandomAsset()
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
    
    private func setInitialPosition() {
        let spinningAction = SKAction.repeatForever(SKAction.rotate(byAngle: .pi * 2, duration: 0.5))
        let randomNumber = Int.random(in: 0...2)
        
        if randomNumber == 2 {
            let moveAction = SKAction.move(by: CGVector(dx: -700, dy: 0), duration: 4)
            self.position = CGPoint(x: 690, y: 18)
            
            self.run(moveAction) {
                self.removeFromParent()
            }
        }
        else {
            let moveAction = SKAction.move(by: CGVector(dx: 700, dy: 0), duration: 4)
            self.position = CGPoint(x: -10 , y: 18)
            
            self.run(moveAction) {
                self.removeFromParent()
            }
        }
        
        self.run(spinningAction)
    }
    
    private func setRandomAsset() {
        let randomNumber = Int.random(in: 0...1)
        
        if randomNumber == 0 {
            self.texture = SKTexture(imageNamed: "warning")
        }
        else {
            self.texture = SKTexture(imageNamed: "error")
        }
    }
    
    private func setLightNodes() {
        
        let lightNode = SKLightNode()

        lightNode.position = self.position
        lightNode.ambientColor = .clear
        lightNode.lightColor = .white
        lightNode.falloff = 0.8
        lightNode.zPosition = 1
        lightNode.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        self.physicsBody?.categoryBitMask = BitmaskConstants.affectedByLight
        
        lightNodes.append(lightNode)
        addChild(lightNode)
        
    }
    
    func disable() {
        self.removeAllActions()
        self.physicsBody = nil
        self.size = CGSize(width: 50, height: 10)
        self.zRotation = 0
    }
    
    func die() {
        
        let reduceLight = SKAction.customAction(withDuration: 0.005) {
            (_, time) -> Void in
            
            for element in self.lightNodes {
                element.falloff += 0.014
            }
        }
        
         let reduceLightSequence = SKAction.sequence([reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight,reduceLight])
        
        let resize = SKAction.resize(toWidth: 0, height: 0, duration: 0.21)
        
        self.run(SKAction.group([reduceLightSequence, resize])) {
            self.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
