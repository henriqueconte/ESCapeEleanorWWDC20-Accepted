//
//  TouchBarNewScene.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 06/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


protocol EndCaveScene: class {
    func didFinishScene()
}

public class TouchBarNewScene: SKScene {
    
    var backgroundNode: SKSpriteNode?
    var playerNode: NewPlayer?
    var coffee: Coffee?
    var instructions: SKLabelNode?
    var hole: Hole?
    var column: Column?
    var invisibleNode: Column?
    var wordGuesser: WordGuess?
    
    let viewWidth: CGFloat = 690
    let viewHeight: CGFloat = 30
    let groundPosition: CGFloat = 18
    
    var puzzleState: PuzzleState = .none
    var updateTime: Double = 0.0
    var monstersAllowed: Bool = false
    
    var macScene: MacScene?
    var caveDelegate: EndCaveScene?
    
    var backgroundMusic = SKAction.playSoundFileNamed("DANCING.mp3", waitForCompletion: true)
    var backgroundMusicNode: SKSpriteNode?
    var soundEffectsNode: SKSpriteNode?
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        setPhysicsWorld()
        setBackground()
        setPlayer()
        setKeyboardEvents()
        setCoffe()
        setHole()
        setColumn()
        setInvisibleNode()
        setWordGuesser()
        setInitialInstructions()
        setBackgroundMusic()
        setSoundEffectsNode()
    }
    
    override public func update(_ currentTime: TimeInterval) {

        if puzzleState == .monsters && monstersAllowed {
            let randomTime = Double.random(in: 2..<4)
            
            if currentTime - updateTime > randomTime {
                updateTime = currentTime
                spawnEnemie()
            }
        
            if playerNode?.canAttack == false {
                if currentTime - (self.playerNode?.attackTime ?? 0.0) > 1.0 {
                    self.playerNode?.attackTime = currentTime
                    playerNode?.canAttack = true
                }
            }
        }

    }
    
    private func setBackground() {
        if let background = self.childNode(withName: "background") as? SKSpriteNode {
            background.lightingBitMask = BitmaskConstants.affectedByLight
        }
    }
    
    private func setSoundEffectsNode() {
        soundEffectsNode = SKSpriteNode()
        
        self.addChild(soundEffectsNode!)
    }
    
    private func setBackgroundMusic() {
        backgroundMusicNode = SKSpriteNode()
        backgroundMusicNode?.run(backgroundMusic) {
            self.backgroundMusicNode?.run(self.backgroundMusic){
                self.backgroundMusicNode?.run(self.backgroundMusic){
                    self.backgroundMusicNode?.run(self.backgroundMusic){
                        self.backgroundMusicNode?.run(self.backgroundMusic){
                            self.backgroundMusicNode?.run(self.backgroundMusic){
                                self.backgroundMusicNode?.run(self.backgroundMusic)
                            }
                        }
                    }
                }
            }
        }
        self.addChild(backgroundMusicNode!)
    }
    
    private func setPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    private func setInitialInstructions() {
        instructions = coffee?.createInstructions()
        instructions?.text = "Use the keyboard arrows to move"
        let fadeIn = SKAction.fadeIn(withDuration: 1.5)

        instructions?.position = CGPoint(x: viewWidth * 0.45, y: viewHeight * 0.4)
        
        instructions?.run(fadeIn)
        
        addChild(instructions!)
    }
    
    private func setPlayer() {
        playerNode = NewPlayer(texture: SKTexture(imageNamed: "charRight1"), color: NSColor.clear, size: CGSize(width: 11, height: 16))
        playerNode?.position = CGPoint(x: viewWidth * 0.1, y: groundPosition)
        
        addChild(playerNode!)
    }
    
    private func setCoffe() {
        coffee = Coffee(texture: SKTexture(imageNamed: "coffee"), color: .clear, size: CGSize(width: 13, height: 14))
        coffee?.position = CGPoint(x: viewWidth * 0.9, y: groundPosition + 2)
        
        addChild(coffee!)
    }
    
    private func setHole() {
        hole = Hole(texture: SKTexture(imageNamed: "hole"), color: .clear, size: CGSize(width: 35, height: 22))
        hole?.position = CGPoint(x: viewWidth * 0.05, y: groundPosition - 7)
        
        addChild(hole!)
    }
    
    private func setColumn() {
        column = Column(texture: SKTexture(imageNamed: "column"), color: .clear, size: CGSize(width: 9, height: 25))
        column?.position = CGPoint(x: viewWidth * 0.12, y: groundPosition + 2)
        column?.isHidden = true
        
        addChild(column!)
    }
    
    private func setInvisibleNode() {
        invisibleNode = Column(texture: SKTexture(imageNamed: "column"), color: .clear, size: CGSize(width: 9, height: 25))
        invisibleNode?.alpha = 0
        invisibleNode?.position = CGPoint(x: viewWidth * 0.85, y: groundPosition)
        invisibleNode?.name = "invisibleNode"
        
        addChild(invisibleNode!)
    }
    
    private func setWordGuesser() {
        wordGuesser = WordGuess()
        wordGuesser?.position = CGPoint(x: viewWidth * 0.74, y: viewHeight * 0.4)
        wordGuesser?.alpha = 0
        
        addChild(wordGuesser!)
    }
    
    private func showExit() {
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        
        instructions?.text = "Look! An exit has just appeared!"
        instructions?.run(fadeIn)
        column?.isHidden = false
        hole?.appear()
    }
    
    private func showAttackTutorial() {
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        
        puzzleState = .monsters
        
        instructions?.run(fadeOut, completion: {
            self.instructions?.text = "Monsters want to stop you! Press space to attack them!"
            self.instructions?.position = CGPoint(x: self.viewWidth * 0.45, y: self.viewHeight * 0.4)
            self.instructions?.run(fadeIn)
            self.invisibleNode?.position.x = self.viewWidth * 0.15
            self.playerNode?.canAttack = true
        })
    }
    
    private func showEscapeInstructions() {
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        
        puzzleState = .wall
        playerNode?.canAttack = false
        monstersAllowed = false
        
        instructions?.text = "Guess Eleanor's favorite programming language:"
        instructions?.run(fadeIn)
        wordGuesser?.run(fadeIn)
    }
    
    private func spawnEnemie() {
        
        let enemy = NewEnemy(color: .clear, size: CGSize(width: 12, height: 12))
        
        addChild(enemy)
    }
    
    private func endWordPuzzle() {
        let fadeOut = SKAction.fadeOut(withDuration: 3)
        
        wordGuesser?.run(fadeOut)
        instructions?.run(fadeOut) {
            self.column?.disappear() {
                self.playerNode?.canMove = true
                self.puzzleState = .macbook
            }
            self.playSound(fileNamed: "stoneSound.mp3") 
        }
    }
    
    func playSound(fileNamed: String) {
        let soundAction = SKAction.playSoundFileNamed(fileNamed, waitForCompletion: false)
        
        soundEffectsNode?.run(soundAction)
    }
    
    func setKeyboardEvents() {

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
    
            switch event.keyCode {
            case KeyIdentifiers.leftArrow.rawValue:
                self.playerNode?.moveLeft()
                if self.puzzleState == .none {
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    self.instructions?.run(fadeOut)
                }
                
            case KeyIdentifiers.rightArrow.rawValue:
                self.playerNode?.moveRight()
                if self.puzzleState == .none {
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    self.instructions?.run(fadeOut)
                }
                
            case KeyIdentifiers.enter.rawValue:
                if self.puzzleState == .coffee {
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    
                    self.coffee?.disappear()
                    self.playSound(fileNamed: "coffeeSound.mp3")
                    
                    self.playerNode?.animateLightNodes {
                        self.playerNode?.canMove = true
                    }
                    
                    self.instructions?.run(fadeOut) {
                        self.showExit()
                    }
                   
                }
                
            case KeyIdentifiers.space.rawValue:
                if self.playerNode?.canAttack ?? false {
                    self.playerNode?.shoot()
                    self.playSound(fileNamed: "throwSound.mp3")
                    self.monstersAllowed = true
                    
                    if self.instructions?.alpha ?? 0.0 > 0.0 {
                        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                        self.instructions?.run(fadeOut)
                        self.playerNode?.canMove = true
                    }
                }
                
            default:
                
                if self.puzzleState == .wall {
                    let shouldEndReading = self.wordGuesser?.readLetter(letter: event.characters ?? "c")
                    
                    if shouldEndReading ?? false {
                        self.endWordPuzzle()
                    }
                }
               
                return event
            }
            return event
        }
    }
    
    func explode(node: SKSpriteNode, closure: @escaping () -> ()) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        addChild(explosion)
        explosion.resetSimulation()
        explosion.particleTexture = node.texture
        explosion.position = CGPoint(x: node.position.x, y: node.position.y - node.size.height/2)
        explosion.particleSize = CGSize(width: node.size.width/2, height: node.size.height/2)
        
        self.run(SKAction.wait(forDuration: 1.5)) {
            explosion.removeFromParent()
            closure()
        }
    }

}

extension TouchBarNewScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "coffee") && (bodyB.node?.name == "player" || bodyB.node?.name == "coffee") {
            
            instructions?.text = "Press enter to take the coffee"
            let fadeIn = SKAction.fadeIn(withDuration: 1.5)
            
            instructions?.position = CGPoint(x: viewWidth * 0.35, y: viewHeight * 0.4)
            
            instructions?.run(fadeIn)
            
            playerNode?.canMove = false
            puzzleState = .coffee
        }
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "invisibleNode") && (bodyB.node?.name == "player" || bodyB.node?.name == "invisibleNode") {
            
            if instructions?.text == "Look! An exit has just appeared!" {
                playerNode?.canMove = false
                showAttackTutorial()
            }
            
            else if instructions?.text == "Monsters want to stop you! Press space to attack them!" {
                playerNode?.canMove = false
                showEscapeInstructions()
            }
        }
        
        if (bodyA.node?.name == "hammer" || bodyA.node?.name == "monster") && (bodyB.node?.name == "hammer" || bodyB.node?.name == "monster") {
            
            var hammer: SKSpriteNode?
            var monster: NewEnemy?
            
            if bodyA.node?.name == "hammer" {
                hammer = bodyA.node as? SKSpriteNode
                monster = bodyB.node as? NewEnemy
            }
            else {
                hammer = bodyB.node as? SKSpriteNode
                monster = bodyA.node as? NewEnemy
            }
            
            hammer?.removeFromParent()

            monster?.disable()
            monster?.texture = SKTexture(imageNamed: "buildSucceeded")
            
            playSound(fileNamed: "successSound.mp3")
            
            let increaseAction = SKAction.resize(byWidth: 9, height: 3, duration: 1.0)
            
            
            monster?.run(increaseAction) {
                monster?.die()
            }
        }
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "monster") && (bodyB.node?.name == "player" || bodyB.node?.name == "monster") {
            
            var monster: NewEnemy?
            
            if bodyA.node?.name == "monster" {
                monster = bodyA.node as? NewEnemy
            }
            else {
                monster = bodyB.node as? NewEnemy
            }
            
            monster?.disable()
            monster?.texture = SKTexture(imageNamed: "buildFailed")
            
            playSound(fileNamed: "failSound.m4a")
            
            let increaseAction = SKAction.resize(byWidth: 9, height: 3, duration: 1.0)
            
            monster?.run(increaseAction) {
                monster?.die()
            }
        }
        
        if (bodyA.node?.name == "player" || bodyA.node?.name == "hole") && (bodyB.node?.name == "player" || bodyB.node?.name == "hole") {
            
            if puzzleState == .macbook {
                playerNode?.canMove = false
                playerNode?.disappear({
                    self.hole?.disappear({ 
                        let colorize = SKAction.colorize(with: NSColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0), colorBlendFactor: 0, duration: 1.0)
                        
                        self.run(colorize) {
                            self.caveDelegate?.didFinishScene()
                        }
                    })
                })
            }
        }
        
    }
}

