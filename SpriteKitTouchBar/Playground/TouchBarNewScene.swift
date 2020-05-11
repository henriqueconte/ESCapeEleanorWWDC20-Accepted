//
//  TouchBarNewScene.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 06/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class TouchBarNewScene: SKScene {
    
    var backgroundNode: SKSpriteNode?
    var playerNode: NewPlayer?
    var coffee: Coffee?
    var instructions: SKLabelNode?
    var hole: Hole?
    var column: Column?
    var invisibleNode: Column?
    
    let viewWidth: CGFloat = 690
    let viewHeight: CGFloat = 30
    let groundPosition: CGFloat = 18
    
    var puzzleState: PuzzleState = .none
    var updateTime: Double = 0.0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setPhysicsWorld()
        setBackground()
        setPlayer()
        setKeyboardEvents()
        setCoffe()
        setHole()
        setColumn()
        setInvisibleNode()
    }
    
    override func update(_ currentTime: TimeInterval) {

        if playerNode?.canAttack ?? false {
            let randomTime = Double.random(in: 2..<4)
            
            if currentTime - updateTime > randomTime {
                updateTime = currentTime
                spawnEnemie()
            }
        }

    }
    
    private func setBackground() {
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "caveBackground"), size: CGSize(width: self.view?.bounds.width ?? 0, height: self.view?.bounds.height ?? 0))
        backgroundNode?.zPosition = 0
        backgroundNode?.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundNode?.lightingBitMask = BitmaskConstants.affectedByLight
        
        addChild(backgroundNode!)
    }
    
    private func setPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    private func setPlayer() {
        playerNode = NewPlayer(texture: SKTexture(imageNamed: "charRight1"), color: NSColor.clear, size: CGSize(width: 11, height: 16))
        playerNode?.position = CGPoint(x: viewWidth * 0.8, y: groundPosition)
        
        addChild(playerNode!)
    }
    
    private func setCoffe() {
        coffee = Coffee(texture: SKTexture(imageNamed: "coffee"), color: .clear, size: CGSize(width: 13, height: 14))
        coffee?.position = CGPoint(x: viewWidth * 0.9, y: groundPosition + 2)
        
        addChild(coffee!)
    }
    
    private func setHole() {
        hole = Hole(texture: SKTexture(imageNamed: "hole"), color: .clear, size: CGSize(width: 35, height: 19))
        hole?.position = CGPoint(x: viewWidth * 0.05, y: groundPosition - 7)
        
        addChild(hole!)
    }
    
    private func setColumn() {
        column = Column(texture: SKTexture(imageNamed: "column"), color: .clear, size: CGSize(width: 9, height: 25))
        column?.position = CGPoint(x: viewWidth * 0.12, y: groundPosition + 2)
        
        addChild(column!)
    }
    
    private func setInvisibleNode() {
        invisibleNode = Column(texture: SKTexture(imageNamed: "column"), color: .clear, size: CGSize(width: 9, height: 25))
        invisibleNode?.alpha = 0
        invisibleNode?.position = CGPoint(x: viewWidth * 0.85, y: groundPosition)
        invisibleNode?.name = "invisibleNode"
        
        addChild(invisibleNode!)
    }
    
    private func startMonstersState() {
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        
        instructions?.text = "Look! An exit has just appeared!"
        instructions?.run(fadeIn)
        hole?.appear()
        puzzleState = .monsters
    }
    
    private func showAttackTutorial() {
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        
        instructions?.run(fadeOut, completion: {
            self.instructions?.text = "Monsters want to stop you! Press space to attack them!"
            self.instructions?.position = CGPoint(x: self.viewWidth * 0.45, y: self.viewHeight * 0.4)
            self.instructions?.run(fadeIn)
            self.playerNode?.canAttack = true
        })
    }
    
    private func spawnEnemie() {
        
        let enemy = NewEnemy(color: .clear, size: CGSize(width: 12, height: 12))
        
        addChild(enemy)
    }
    
    func setKeyboardEvents() {

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in

            switch event.keyCode {
            case KeyIdentifiers.leftArrow.rawValue:
                self.playerNode?.moveLeft()
                
            case KeyIdentifiers.rightArrow.rawValue:
                self.playerNode?.moveRight()
                
            case KeyIdentifiers.enter.rawValue:
                if self.puzzleState == .coffee {
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    
                    self.coffee?.disappear()
        
                    self.playerNode?.animateLightNodes {
                        self.playerNode?.canMove = true
                    }
                    
                    self.instructions?.run(fadeOut) {
                        self.startMonstersState()
                    }
                   
                }
                
            case KeyIdentifiers.space.rawValue:
                if self.playerNode?.canAttack ?? false {
                    self.playerNode?.shoot()
                    
                    if self.instructions?.alpha == 1 {
                        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                        self.instructions?.run(fadeOut)
                        self.playerNode?.canMove = true
                    }
                }
                
            default:
                return event
            }
            return event
        }
    }
    
}

extension TouchBarNewScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "coffee") && (bodyB.node?.name == "player" || bodyB.node?.name == "coffee") {
            
            instructions = coffee?.createInstructions()
            let fadeIn = SKAction.fadeIn(withDuration: 1.5)
            
            instructions?.position = CGPoint(x: viewWidth * 0.35, y: viewHeight * 0.4)
            
            instructions?.run(fadeIn)
            
            addChild(instructions!)
            
            playerNode?.canMove = false
            puzzleState = .coffee
        }
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "invisibleNode") && (bodyB.node?.name == "player" || bodyB.node?.name == "invisibleNode") {
            
            if puzzleState == .monsters {
                playerNode?.canMove = false
                showAttackTutorial()
            }
        }
    }
}

