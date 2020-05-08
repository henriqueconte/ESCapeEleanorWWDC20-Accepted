//
//  GameScene.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 22/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class GameScene: SKScene {
    
    var playerNode: Player?
    var backgroundNode: SKSpriteNode?
    var updateTime: Double = 0
    
    var viewWidth: CGFloat {
        return view?.bounds.width ?? 0
    }
    
    var viewHeight: CGFloat {
        return view?.bounds.height ?? 0
    }
    
    override func didMove(to view: SKView) {
        setPhysicsWorld()
        setBackground()
        setPlayer()
        setKeyboardEvents()
    }
    
    override func update(_ currentTime: TimeInterval) {

        if playerNode?.isAlive ?? true {
            let randomTime = Double.random(in: 0.8..<2)
            
            if currentTime - updateTime > randomTime {
                updateTime = currentTime
                spawnEnemie()
            }
        }

    }
    
    func setPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    func setBackground() {
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "spaceBackground"), size: CGSize(width: self.view?.bounds.width ?? 0, height: self.view?.bounds.height ?? 0))
        backgroundNode?.zPosition = 0
        backgroundNode?.anchorPoint = CGPoint(x: 0, y: 0)
        
        addChild(backgroundNode!)
    }
    
    func setPlayer() {
        playerNode = Player(text: "🚀")
        playerNode?.position = CGPoint(x: viewWidth * 0.05, y: viewHeight / 3)
        
        addChild(playerNode!)
    }
    
    func setPlayerAttack () {
        if playerNode?.isAlive ?? true {
            let projectile = self.playerNode?.shoot()
            self.addChild(projectile!)
            
            let moveAction = SKAction.move(to: CGPoint(x: 700, y: projectile?.position.y ?? 0), duration: 1)

            projectile?.run(moveAction) {
                projectile?.removeFromParent()
            }
        }
    }
    
    func setKeyboardEvents() {

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in

            switch event.keyCode {
            case KeyIdentifiers.upArrow.rawValue:
                self.playerNode?.moveUp()
                
            case KeyIdentifiers.downArrow.rawValue:
                self.playerNode?.moveDown()

            case KeyIdentifiers.space.rawValue:
                self.setPlayerAttack()
                
            default:
                return event
            }
            return event
        }
    }
    
    func spawnEnemie() {
        let enemy = Enemy(text: "🌖")
        let enemyYPosition = CGFloat(Int.random(in: 0..<Int(viewHeight)))
        let moveAction = SKAction.move(to: CGPoint(x: -10, y: enemyYPosition), duration: 2)
        
        enemy.position = CGPoint(x: viewWidth, y: enemyYPosition)
        
        addChild(enemy)
        
        enemy.run(moveAction) {
            enemy.removeFromParent()
        }
    }
    
    func stopEnemies() {
        for element in self.children {
            if element.name == "enemy" {
                element.isPaused = true
            }
        }
    }
    
    func showStartScene() {
        let scene = SKScene(fileNamed: "StartScene") as? StartScene
        scene!.scaleMode = .aspectFill
        self.view?.presentScene(scene)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.node?.name == "playerBomb" || bodyA.node?.name == "enemy") && (bodyB.node?.name == "playerBomb" || bodyB.node?.name == "enemy") {
            
            if let enemyNode = bodyA.node as? Enemy {
                enemyNode.die()
                bodyB.node?.removeFromParent()
            }
            else if let enemyNode = bodyB.node as? Enemy {
                enemyNode.die()
                bodyA.node?.removeFromParent()
            }
        }
        
        else if (bodyA.node?.name == "enemy" || bodyA.node?.name == "player") && (bodyB.node?.name == "enemy" || bodyB.node?.name == "player") {
            
            if let playerNode = bodyA.node as? Player {
                stopEnemies()
                playerNode.die({
                    self.showStartScene()
                })
            }
            else if let playerNode = bodyB.node as? Player {
                stopEnemies()
                playerNode.die({
                    self.showStartScene()
                })
            }
        }
    }
}
